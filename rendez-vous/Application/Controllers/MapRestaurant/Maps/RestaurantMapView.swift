//
//  RamonMKMapView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import MapKit

class RestaurantMapView: MKMapView, WebServiceLinkable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func reloadData()
    {
        guard ListeRestaurants.sharedInstance != nil else {
            print("RestaurantMapView:reloadData - listeRestaurantsProches non trouvée")
            return
        }
        var i = 0
        for item in ListeRestaurants.sharedInstance!.liste
        {
            item.indice = i
            self.addAnnotation(item)
            i += 1
        }
        print("RestaurantMapView:reloadData - il y a \(ListeRestaurants.sharedInstance!.liste.count) restaurants à afficher sur la carte")
    }
    func refresh()
    {
        print("RestaurantMapView:refresh")
        reloadData()
    }
}
