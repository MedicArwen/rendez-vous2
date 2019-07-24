//
//  AgendaEventHosted.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import Foundation
import SwiftyJSON
import SwiftHash

class AgendaEventHosted {
    var events = [RendezVous]()
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
            let rendezVous = RendezVous(json: item["Rendez-Vous"])
            rendezVous.restaurant = Restaurant(json: item["Restaurant"]) 
            for jUtilisateur in item["Invitations"]
            {
                print("jutilisateur: \(jUtilisateur.1["Utilisateur"])")
                let invitation = Invitation(jsonInvitation: jUtilisateur.1["Invitation"], jsonUtilisateur: jUtilisateur.1["Utilisateur"])
                rendezVous.addInvitation(invitation: invitation)
            }
            events.append(rendezVous)
            i += 1
        }
    }
    static func loadHostedRendezVous(_ completion: @escaping ServiceResponse) {
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
    static func refreshList()
    {
        AgendaEventHosted.loadHostedRendezVous{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: self, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    RendezVousApplication.sharedInstance.listeRendezVousCrees = AgendaEventHosted(json:json["data"])
                    
                    //  self.tableRendezVousHosted.reloadData()
                }
            }
        }
    }
}
