//
//  RamonTableView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RestaurantTableView: UITableView, WebServiceLinkable {
    fileprivate var indiceSuscribedView = 0
    func refresh() {
        print("RestaurantTableView: refresh")
        reloadData()
    }
    var indice: Int {
        get {
            return indiceSuscribedView
        }
        set {
            indiceSuscribedView = newValue
        }
    }


}
