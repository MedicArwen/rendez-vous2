//
//  ListeRestaurants.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON
import MapKit


class ListeRestaurants:WebServiceSubscribable
{
    var liste = [Restaurant]()

    init(json:JSON) {
        for jRestaurant in json {
            self.liste.append(Restaurant(json:jRestaurant.1))
        }
    }
    
    static func getListRestaurant(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "LIST"
        params["ENTITY"] = "Restaurant"
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
    
    static func refreshList(controleur: RamonViewController)
    {
    print("refreshList Restaurant")
    ListeRestaurants.getListRestaurant
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
                RendezVousApplication.sharedInstance.listeRestaurantsProches = ListeRestaurants(json:json["data"])
                ListeRestaurants.reloadViews()
            }
    }
    }
    }
}
