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

class ListeRendezVousAsConvive:WebServiceSubscribable {
    var liste = [RendezVous]()
    init(json:JSON) {
        //print(json)
        var i = 1
        print(" il y a \(json.arrayValue.count) rendez-vous à afficher")
        for item in json.arrayValue
        {
            print("element n°\(i)")
            //    print("les invitations:\(item["Invitations"])")
            //   print("le restaurant:\(item["Restaurant"])")
            //   print("le rendezvous:\(item["Rendez-Vous"])")
          //  let rendezVous = RendezVous(json: item["Rendez-Vous"])
            let rendezVous = RendezVous(jRendezVous:item["Rendez-Vous"],jHote:item["Hote"])
            rendezVous.restaurant = Restaurant(json: item["Restaurant"])
            for jUtilisateur in item["Invitations"]
            {
             //   print("jutilisateur: \(jUtilisateur.1["Utilisateur"])")
                let invitation = Invitation(jsonInvitation: jUtilisateur.1["Invitation"], jsonUtilisateur: jUtilisateur.1["Utilisateur"])
                rendezVous.addInvitation(invitation: invitation)
            }
            liste.append(rendezVous)
            i += 1
        }
    }
}
extension ListeRendezVousAsConvive:WebServiceListable
{
    static func load(controleur: RamonViewController) {
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
                    RendezVousApplication.sharedInstance.listeInvitationsRecues = ListeRendezVousAsConvive(json:json["data"])
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
        print("chargement des rendez vous créés par l'utilisateur")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    
    static func remove(controleur:RamonViewController,indexPath:IndexPath)
    {
        RendezVousApplication.sharedInstance.listeInvitationsRecues!.liste[indexPath.row].cancel{ (json: JSON?, error: Error?) in
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
                    
                    RendezVousApplication.sharedInstance.listeInvitationsRecues!.liste.remove(at: indexPath.row)
                    ListeRendezVousAsConvive.reloadViews()
                }
            }
        }
    }
}
