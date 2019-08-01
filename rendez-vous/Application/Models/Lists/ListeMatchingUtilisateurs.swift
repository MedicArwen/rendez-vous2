//
//  MatchListe.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHash

class ListeMatchingUtilisateurs
{
    static var sharedInstance : ListeMatchingUtilisateurs?
    var liste = [RankedUtilisateur]()
    
    init(json:JSON)
    {
       
        print("ListeMatchingUtilisateurs:init")
        for jUtilisateur in json {
           liste.append(RankedUtilisateur(json:jUtilisateur.1))
        }
        self.liste = self.getPurgedList()
    }
    // cette méthode permet de construire l'appel du web service en lui-même ainsi que la requête http qui est envoyée.
    private static func createListRequest(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "LIST"
        params["ENTITY"] = "Utilisateur"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        params["distance"] = "10.0"
        params["latitude"] = "\(LocationManager.SharedInstance.location!.coordinate.latitude)"
        params["longitude"] = "\(LocationManager.SharedInstance.location!.coordinate.longitude)"
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)10.0\(LocationManager.SharedInstance.location!.coordinate.latitude)\(LocationManager.SharedInstance.location!.coordinate.longitude)onmangeensembleb20")
        print("chargement des Utilisateurs qui matchent")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)10.0\(LocationManager.SharedInstance.location!.coordinate.latitude)\(LocationManager.SharedInstance.location!.coordinate.longitude)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
    }
    // retourne l'indice de l'utilisateur
   func find(rankedUser:RankedUtilisateur)->Int
    {
        print("ListeMatchingUtilisateurs:find")
        var i = 0
        var indice = -1
        for item in self.liste
        {
            if item.idUtilisateur == rankedUser.idUtilisateur
            {
                indice = i
            }
            i += 1
        }
        print("-> indice trouvé: \(indice) (-1 = rien trouvé)")
        return indice
    }
 func getPurgedList()-> [RankedUtilisateur]
 {
    var liste = [RankedUtilisateur]()
    for rankedUtilisateur in self.liste
        {
            let utilisateur = rankedUtilisateur as Utilisateur
            if !isHote(utilisateur: utilisateur) && !inInvitationList(utilisateur: utilisateur)
            {
                liste.append(rankedUtilisateur)
            }
        }
    return liste
    }
    
    func isHote(utilisateur:Utilisateur)->Bool
    {
        return utilisateur == RendezVous.sharedInstance!.hote
    }
    func inInvitationList(utilisateur:Utilisateur)->Bool
    {
        var found = false
        for item in RendezVous.sharedInstance!.invitationList
        {
            if item.utilisateur == utilisateur
            {
                found = true
            }
        }
        return found
    }
}
extension ListeMatchingUtilisateurs: WebServiceListable
{
  
    static func remove(controleur: RamonViewController, indexPath: IndexPath) {
        guard ListeMatchingUtilisateurs.sharedInstance != nil else {
            print("ListeMatchingUtilisateurs:remove(indexPath) - aucune liste ListeMatchingUtilisateurs trouvée")
            return
        }
        if let currentList = ListeMatchingUtilisateurs.sharedInstance
        {
            print("ListeMatchingUtilisateurs:remove(indexPath) - indice:\(indexPath.row) ")
            currentList.liste.remove(at: indexPath.row)
            ListeMatchingUtilisateurs.reloadViews()
        }
    }
    
    static func remove(controleur: RamonViewController, item: Any) {
    guard ListeMatchingUtilisateurs.sharedInstance != nil else {
        print("ListeMatchingUtilisateurs:remove(any) - aucune liste ListeMatchingUtilisateurs trouvée")
        return
    }
        if let currentList = ListeMatchingUtilisateurs.sharedInstance
        {
            let rankedUser = item as! RankedUtilisateur
            let indice = currentList.find(rankedUser: rankedUser)
            print("ListeMatchingUtilisateurs:remove(indexPath) - indice:\(indice) ")
            if indice != -1
            {
                print("l'utilisateur a été trouvé")
                currentList.liste.remove(at: indice)
            }
            ListeMatchingUtilisateurs.reloadViews()
        }
    }
    
    // cette méthode permet d'invoquer le web service et de gérer le call back
    // cela utilise la classe mère WebServiceSubscribable pour abonner les différences éléments d'interface à sa mise à jour
    // afin de les synchroniser
    static func load(controleur: RamonViewController)
    {
        print("ListeMatchingUtilisateurs:load")
        ListeMatchingUtilisateurs.createListRequest
            { (json: JSON?, error: Error?) in
                guard error == nil else
                {
                    print("Une erreur est survenue")
                    return
                }
                if let json = json
                {
                    print(json)
                    if json["returnCode"].intValue != 200
                    {
                        AuthWebService.sendAlertMessage(vc: controleur, returnCode: json["returnCode"].intValue)
                    }
                    else
                    {
                        ListeMatchingUtilisateurs.sharedInstance = ListeMatchingUtilisateurs(json:json["data"])
                        ListeMatchingUtilisateurs.reloadViews()
                    }
                }
        }
    }
  
    static func append(controleur:RamonViewController,item:Any)
    {
        guard ListeMatchingUtilisateurs.sharedInstance != nil else {
            print("ListeMatchingUtilisateurs:append - aucune liste ListeMatchingUtilisateurs trouvée")
            return
        }
        let match = item as! RankedUtilisateur
        print("ListeMatchingUtilisateurs:append - id utilisateur: \(match.idUtilisateur)")
        ListeMatchingUtilisateurs.sharedInstance!.liste.append(match)
        ListeMatchingUtilisateurs.reloadViews()
    }
}
extension ListeMatchingUtilisateurs:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeMatchingUtilisateurs:subscribe")
        self.suscribedViews.append(vue)
        print("Il y a \(self.suscribedViews.count) vues abonnées à ListeMatchingUtilisateurs")
    }
    
    static func reloadViews()
    {
        print("ListeMatchingUtilisateurs:reloadView")
        print("Il y a \(self.suscribedViews.count) vues abonnée(s) à ListeMatchingUtilisateurs")
        print (" il faut afficher les \(ListeMatchingUtilisateurs.sharedInstance!.liste.count) utilisateurs qui matchent")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeMatchingUtilisateurs:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeMatchingUtilisateurs")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeMatchingUtilisateurs")
    }
}
