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
    static func saveUserConnected(connectedRamonUser:ConnectedRamonUser)
    {
        print("username:\(connectedRamonUser.ramonUser.courriel)")
        print("pwd:\(connectedRamonUser.ramonUser.motdepasse)")
        UserDefaults.standard.set(connectedRamonUser.ramonUser.courriel, forKey: "userName")
        UserDefaults.standard.set(connectedRamonUser.ramonUser.motdepasse, forKey: "password")
    }
    static func connectUtilisateurDefault()
    {
        print("ConnectedRamonUser:connectUtilisateurDefault")
        guard UserDefaults.standard.string(forKey: "userName") != nil else {
            print("userName non trouvé")
            return
        }
        guard UserDefaults.standard.string(forKey: "password") != nil else {
            print("password non trouvé")
            return
        }
        AuthWebService.sharedInstance.userName = UserDefaults.standard.string(forKey: "userName")!
        AuthWebService.sharedInstance.password = UserDefaults.standard.string(forKey: "password")!
        print("username:\(String(describing: AuthWebService.sharedInstance.userName))")
        print("pwd:\(UserDefaults.standard.string(forKey: "password")!)")
    }
}
