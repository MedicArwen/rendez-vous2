//
//  UtilisateurConnected.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHash

class ConnectedRamonUser
{
    var ramonUser: RamonUser
    var apiKey: String?
    init(json:JSON) {
        print("ConnectedRamonUser:init")
        self.ramonUser = RamonUser(ramonUserJson:json["ramonUser"])
        self.apiKey = json["apiKey"].stringValue
    }
    func isEmailValide()->Bool
    {
        return self.ramonUser.estCompteValide == 1
    }
    func loadProfile(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = self.apiKey
        params["CMD"] = "READ"
        params["ENTITY"] = "Utilisateur"
        params["NUMRAMONUSER"] = "\(self.ramonUser.idRamonUser)"
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print("chargement des centres d'interet")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
    }
}
