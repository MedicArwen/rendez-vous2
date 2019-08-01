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


class ListeRestaurants
{
    static var sharedInstance: ListeRestaurants?
    var liste = [Restaurant]()

    init(json:JSON) {
        print("ListeRestaurants:init")
        for jRestaurant in json {
            self.liste.append(Restaurant(json:jRestaurant.1))
        }
    }
}
extension ListeRestaurants: WebServiceListable
{
    // cette méthode permet d'invoquer le web service et de gérer le call back
    // cela utilise la classe mère WebServiceSubscribable pour abonner les différences éléments d'interface à sa mise à jour
    // afin de les synchroniser
    static func load(controleur: RamonViewController)
    {
        print("ListeRestaurants:Load")
        ListeRestaurants.createListRequest
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
                        ListeRestaurants.sharedInstance = ListeRestaurants(json:json["data"])
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
    static func remove(controleur:RamonViewController,indexPath:IndexPath)
    {
        print("ListeRestaurants:remove (IndexPath) - non implémenté")
        // pas utile
    }
    static func remove(controleur:RamonViewController,item:Any)
    {
         print("ListeRestaurants:remove (any) - non implémenté")
        // pas utile car on y touche pas
    }
     static func append(controleur:RamonViewController,item:Any)
     {
         print("ListeRestaurants:append - non implémenté")
        // pas utile car on y touche pas
    }
}
extension ListeRestaurants:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeRestaurants:subscribe")
        self.suscribedViews.append(vue)
        print("Il y a \(self.suscribedViews.count) vues abonnée(s) à ListeRestaurants")
    }
    
    static func reloadViews()
    {
        print("ListeRestaurants:reloadViews")
        print("Il y a \(self.suscribedViews.count) vues abonnée(s) à ListeRestaurants")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeRestaurants:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRestaurants")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRestaurants")
    }
    
}
