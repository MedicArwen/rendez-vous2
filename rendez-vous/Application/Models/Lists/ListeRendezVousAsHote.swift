//
//  ListeRendezVousAsHote.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import Foundation
import SwiftyJSON
import SwiftHash

class ListeRendezVousAsHote {
    static var sharedInstance : ListeRendezVousAsHote?
    var liste = [RendezVous]()
    
    init(json:JSON) {
        print("ListeRendezVousAsHote:init")
        var i = 1
        print("-> ajout des \(json.arrayValue.count) rendez-vous à la liste")
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
        print("ListeMatchingUtilisateurs:find")
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
}
extension ListeRendezVousAsHote:WebServiceListable
{
    static func load(controleur: RamonViewController) {
        print("ListeRendezVousAsHote:load")
        ListeRendezVousAsHote.createListRequest{ (json: JSON?, error: Error?) in
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
                    ListeRendezVousAsHote.sharedInstance = ListeRendezVousAsHote(json:json["data"])
                    ListeRendezVousAsHote.reloadViews()
                }
            }
        }
    }
    
    static func createListRequest(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "LIST"
        params["ENTITY"] = "RendezVousCreatedByUtilisateur"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print("chargement des rendez vous créés par l'utilisateur")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    
    static func remove(controleur:RamonViewController,indexPath:IndexPath)
    {
        guard ListeRendezVousAsHote.sharedInstance != nil else {
            print("ListeRendezVousAsHote:remove(indexPath) - aucune liste ListeRendezVousAsHote trouvée")
            return
        }
        print("ListeRendezVousAsHote:removein(dexPath) - il faut annuler le rendez-vous")
        ListeRendezVousAsHote.sharedInstance!.liste[indexPath.row].cancel{ (json: JSON?, error: Error?) in
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
                    ListeRendezVousAsHote.sharedInstance!.liste.remove(at: indexPath.row)
                    ListeRendezVousAsHote.reloadViews()
                }
            }
        }
    }
    static func remove(controleur:RamonViewController,item:Any)
    {
        guard ListeRendezVousAsHote.sharedInstance != nil else {
            print("ListeRendezVousAsHote:remove(item) - aucune liste ListeRendezVousAsHote trouvée")
            return
        }
            print("ListeRendezVousAsHote:removein(dexPath) - il faut annuler le rendez-vous")
            let rendezVous = item as! RendezVous
            let indice = ListeRendezVousAsHote.sharedInstance!.find(rendezVous: rendezVous)
        if indice != -1
        {
            print("-> rendez-vous trouvé: indice = \(indice)")
            ListeRendezVousAsHote.sharedInstance!.liste.remove(at: indice)
            ListeRendezVousAsHote.reloadViews()
        }
    }
     static func append(controleur:RamonViewController,item:Any)
     {
        guard ListeRendezVousAsHote.sharedInstance != nil else {
            print("ListeRendezVousAsHote:append(item) - aucune liste ListeRendezVousAsHote trouvée")
            return
        }
        let rendezVous = item as! RendezVous
        ListeRendezVousAsHote.sharedInstance!.liste.append(rendezVous)
        ListeRendezVousAsHote.reloadViews()
    }
    
}
extension ListeRendezVousAsHote:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeRendezVousAsHote:suscrobe")
        self.suscribedViews.append(vue)
        print("Il y a \(self.suscribedViews.count) vues abonnées à ListeRendezVousAsHote")
    }
    
    static func reloadViews()
    {
        print("ListeRendezVousAsHote:reloadViews")
        print("Il y a \(self.suscribedViews.count) vue(s) abonnée(s) à ListeRendezVousAsHote")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
}

