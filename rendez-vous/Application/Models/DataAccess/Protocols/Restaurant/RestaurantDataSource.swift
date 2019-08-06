//
//  RestaurantDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol RestaurantDataSource {
    func restaurantOnLoaded(restaurants:ListeRestaurants)
    func restaurantOnLoaded(restaurant:Restaurant)
    func restaurantOnNotFoundRestaurant()
    func restaurantOnWebServiceError(code:Int)
}
