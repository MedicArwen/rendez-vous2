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
