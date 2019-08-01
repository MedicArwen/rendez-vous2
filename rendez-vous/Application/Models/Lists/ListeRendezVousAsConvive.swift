//
//  ListeRendezVousAsConvive.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
import Foundation
import Foundation
import SwiftyJSON
import SwiftHash

class ListeRendezVousAsConvive {
    static var sharedInstance : ListeRendezVousAsConvive?
    var liste = [RendezVous]()
    init(json:JSON) {
        print("ListeRendezVousAsConvive:init")
        var i = 1
        print("-> ajout des \(json.arrayValue.count) invitations reçues")
        for item in json.arrayValue
        {
            let rendezVous = RendezVous(jRendezVous:item["Rendez-Vous"],jHote:item["Hote"],jRestau: item["Restaurant"])
            //rendezVous.restaurant = Restaurant(json: item["Restaurant"])
            for jUtilisateur in item["Invitations"]
            {
                let invitation = Invitation(jsonInvitation: jUtilisateur.1["Invitation"], jsonUtilisateur: jUtilisateur.1["Utilisateur"])
                rendezVous.addInvitation(invitation: invitation)
            }
            liste.append(rendezVous)
            i += 1
        }
    }
    func find(rendezVous:RendezVous)->Int
    {
        print("ListeRendezVousAsConvive:find")
        var i = 0
        var indice = -1
        for item in self.liste
        {
            if item.idRendezVous == rendezVous.idRendezVous
            {
                indice = i
            }
            i += 1
        }
        print("-> indice trouvé: \(indice) (-1 = rien trouvé)")
        return indice
    }
    static func accept(controleur:RamonViewController,rendezVous:RendezVous)
    {
        print("ListeRendezVousAsConvive:accept")
        guard RendezVousApplication.sharedInstance.connectedUtilisateur != nil else {
            print("-> aucun utilisateur connecté reconnu")
            return
        }
        let utilisateur = RendezVousApplication.sharedInstance.connectedUtilisateur!
        print("-> utilisateur cherché:\(utilisateur.idUtilisateur)")
        rendezVous.getInvitationOfOneUser(utilisateur: utilisateur)!.accept{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: controleur, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    print("-> rechargement de la liste des rendez-vous")
                    ListeRendezVousAsConvive.load(controleur: controleur)
                }
            }
        }
    }
    static func reject(controleur:RamonViewController,rendezVous:RendezVous)
    {
        print("ListeRendezVousAsConvive:reject")
        guard RendezVousApplication.sharedInstance.connectedUtilisateur != nil else {
            print("-> aucun utilisateur connecté reconnu")
            return
        }
        let utilisateur = RendezVousApplication.sharedInstance.connectedUtilisateur!
        print("-> utilisateur cherché:\(utilisateur.idUtilisateur)")
        rendezVous.getInvitationOfOneUser(utilisateur: utilisateur)!.reject{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: controleur, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    
                    print("-> rechargement de la liste des rendez-vous")
                    ListeRendezVousAsConvive.load(controleur: controleur)
                }
            }
        }
    }
}
extension ListeRendezVousAsConvive:WebServiceListable
{
    
    static func load(controleur: RamonViewController) {
        print("ListeRendezVousAsConvive:load")
        ListeRendezVousAsConvive.createListRequest{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: controleur , returnCode: json["returnCode"].intValue)
                }
                else
                {
                    ListeRendezVousAsConvive.sharedInstance = ListeRendezVousAsConvive(json:json["data"])
                    ListeRendezVousAsConvive.reloadViews()
                }
            }
        }
    }
    
    static func createListRequest(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "LIST"
        params["ENTITY"] = "RendezVousMesInvitations"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print("chargement des rendez vous auquel l'utilisateur est invité")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    
    static func remove(controleur:RamonViewController,indexPath:IndexPath)
    {
        guard ListeRendezVousAsConvive.sharedInstance != nil else {
            print("ListeRendezVousAsConvive:remove(indexPath) - aucune liste ListeRendezVousAsConvive trouvée")
            return
        }
        print("ListeRendezVousAsConvive:removein(dexPath) - il faut annuler l'invitation'")
        ListeRendezVousAsConvive.sharedInstance!.liste[indexPath.row].cancel{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: controleur, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    ListeRendezVousAsConvive.remove(controleur: controleur, indexPath: indexPath)
                    ListeRendezVousAsConvive.reloadViews()
                }
            }
        }
    }
    static func append(controleur: RamonViewController, item: Any) {
        guard ListeRendezVousAsConvive.sharedInstance != nil else {
            print("ListeRendezVousAsConvive:append- aucune liste ListeRendezVousAsConvive trouvée")
            return
        }
        print("ListeRendezVousAsConvive:append - il faut annuler l'invitation'")
        let rendezVous = item as! RendezVous
        ListeRendezVousAsConvive.sharedInstance!.liste.append(rendezVous)
        ListeRendezVousAsConvive.reloadViews()
    }
    static func remove(controleur: RamonViewController, item: Any) {
        guard ListeRendezVousAsConvive.sharedInstance != nil else {
            print("ListeRendezVousAsConvive:remove(item) - aucune liste ListeRendezVousAsConvive trouvée")
            return
        }
        print("ListeRendezVousAsConvive:removein(item) - il faut annuler l'invitation'")
        if let currentList = ListeRendezVousAsConvive.sharedInstance
        {
            let rendezVous = item as! RendezVous
            let indice = currentList.find(rendezVous: rendezVous)
            if indice != -1
            {
                print("-> invitation n°\(indice) trouvée")
                currentList.liste.remove(at: indice)
                ListeRendezVousAsConvive.reloadViews()
            }
        }
    }
    
}
extension ListeRendezVousAsConvive:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeRendezVousAsConvive:subscribe")
        self.suscribedViews.append(vue)
        print("->\(self.suscribedViews.count) vue(s) abonnée(s) à ListeRendezVousAsConvive")
    }
    
    static func reloadViews()
    {
        print("ListeRendezVousAsConvive:reloadViews")
        print("-> \(self.suscribedViews.count) vue(s) abonnée(s) à ListeRendezVousAsConvive")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeRendezVousAsConvive:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRendezVousAsConvive")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRendezVousAsConvive")
    }
}
