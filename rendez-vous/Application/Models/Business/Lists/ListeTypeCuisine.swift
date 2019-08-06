//
//  ListeTypeCuisine.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListeTypeCuisine
{
    static var sharedInstance: ListeTypeCuisine?
    var liste = [TypeCuisine]()
    
    init(json:JSON) {
        print("ListeTypeCuisine:init")
        for jCuisine in json {
            self.liste.append(TypeCuisine(json:jCuisine.1))
        }
    }
}
