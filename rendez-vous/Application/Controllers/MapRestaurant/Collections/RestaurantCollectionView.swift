//
//  RamonCollectionView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RestaurantCollectionView: UICollectionView, WebServiceLinkable {
    func refresh() {
        print("RestaurantCollectionView: refresh")
        reloadData()
    }

}
