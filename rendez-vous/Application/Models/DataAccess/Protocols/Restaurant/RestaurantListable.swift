//
//  RestaurantListable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation

protocol RestaurantListable {
    static func load(datasource:RestaurantDataSource,latitude:Double,longitude:Double,range:Int)
}
