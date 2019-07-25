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

class ListeMatchingUtilisateurs:WebServiceSubscribable
{
    var liste = [RankedUtilisateur]()
    init(json:JSON)
    {
        for jUtilisateur in json {
            print("instantation d'un utilisateur Ranked")
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

}
extension ListeMatchingUtilisateurs: WebServiceListable
{
    // cette méthode permet d'invoquer le web service et de gérer le call back
    // cela utilise la classe mère WebServiceSubscribable pour abonner les différences éléments d'interface à sa mise à jour
    // afin de les synchroniser
    static func load(controleur: RamonViewController)
    {
        print("Load: ListeRestaurant")
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
                        RendezVousApplication.sharedInstance.listeUtilisateursMatch = ListeMatchingUtilisateurs(json:json["data"])
                        ListeRestaurants.reloadViews()
                    }
                }
        }
    }
    // cette méthode permet de construire l'appel du web service en lui-même ainsi que la requête http qui est envoyée.
    static func createListRequest(_ completion: @escaping ServiceResponse) {
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
    
    static func remove(controleur:RamonViewController,indexPath:IndexPath)
    {
        
    }
}
