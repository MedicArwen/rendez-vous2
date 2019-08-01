//
//  ListeCentreInteretUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 31/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON
import MapKit


class ListeCentreInteretUtilisateur
{
   static var sharedInstance : ListeCentreInteretUtilisateur?
    var liste = [CentreInteret]()
    
    init(json:JSON) {
        print("ListeCentreInteretUtilisateur:init")
        var i = 1
        for jCentreInteret in json {
            self.liste.append(CentreInteret(json: jCentreInteret.1, ordre: i))
            i += 1
        }
    }
    // cette méthode permet d'invoquer le web service et de gérer le call back
    // cela utilise la classe mère WebServiceSubscribable pour abonner les différences éléments d'interface à sa mise à jour
    // afin de les synchroniser
}
extension ListeCentreInteretUtilisateur:WebServiceListable
{
    static func remove(controleur: RamonViewController, indexPath: IndexPath) {
        print("ListeCentreInteretUtilisateur:remove - pas implanté ")
    }
    
    static func remove(controleur: RamonViewController, item: Any) {
        print("ListeCentreInteretUtilisateur:remove - pas implanté ")
    }
    
    static func append(controleur: RamonViewController, item: Any) {
        print("ListeCentreInteretUtilisateur:append - pas implanté ")
    }
    static func swap(source:Int,dest:Int)
    {
       // ListeCentreInteretUtilisateur.sharedInstance!.liste[source].order = dest + 1
       // ListeCentreInteretUtilisateur.sharedInstance!.liste[dest].order = source + 1
        ListeCentreInteretUtilisateur.sharedInstance!.liste.swapAt(source, dest)
        var i = 1
        for item in ListeCentreInteretUtilisateur.sharedInstance!.liste
        {
            item.order = i
            print ("item \(item.order) - \(item.libelle)")
            i += 1
    
        }
        ListeCentreInteretUtilisateur.reloadViews()
        
    }
    static func load(controleur: RamonViewController)
    {
        print("ListeCentreInteretUtilisateur:Load")
        ListeCentreInteretUtilisateur.createListRequest
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
                     //   print("data récupéré")
                     //   print(json["data"])
                        ListeCentreInteretUtilisateur.sharedInstance = ListeCentreInteretUtilisateur(json:json["data"])
                        ListeCentreInteretUtilisateur.reloadViews()
                    }
                }
        }
        print("end of load")
    }
    // cette méthode permet de construire l'appel du web service en lui-même ainsi que la requête http qui est envoyée.
    static func createListRequest(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "LIST"
        params["ENTITY"] = "UtilisateurCentreInteret"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print("-> chargement des centres d'interet de l'utilisateur")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
}
extension ListeCentreInteretUtilisateur:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeCentreInteretUtilisateur:subscribe")
        self.suscribedViews.append(vue)
        print("->\(self.suscribedViews.count) vue(s) abonnée(s) à ListeCentreInteretUtilisateur")
    }
    
    static func reloadViews()
    {
        print("ListeCentreInteretUtilisateur:reloadViews")
        print("-> \(self.suscribedViews.count) vue(s) abonnée(s) à ListeCentreInteretUtilisateur")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeCentreInteretUtilisateur:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeCentreInteretUtilisateur")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeCentreInteretUtilisateur")
    }
}
