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
    var liste = [RankedUtilisateur]()
    init(json:JSON)
    {
        for jUtilisateur in json {
            self.liste.append(RankedUtilisateur(json:jUtilisateur.1))
        }
    }
    func remove(rankedUser:Utilisateur)
    {
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
        if indice > -1
        {
           liste.remove(at: indice)
            print("on retire l'utilisateur:\(indice)")
        }
    
    }
    static func listeMatchingUtilisateurs(_ completion: @escaping ServiceResponse) {
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
        print("chargement des restaurants")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)10.0\(LocationManager.SharedInstance.location!.coordinate.latitude)\(LocationManager.SharedInstance.location!.coordinate.longitude)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
}
