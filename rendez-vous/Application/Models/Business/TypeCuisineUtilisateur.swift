//
//  TypeCuisineUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class TypeCuisineUtilisateur:TypeCuisine
{
    var order = 0
    init(id:Int,libelle:String, order:Int) {
       super.init(id: id, libelle: libelle)
        self.order = order
    }
    
    convenience init(json:JSON,ordre:Int) {
        self.init(id:json["idTypeCuisine"].intValue,libelle:json["libelle"].stringValue,order:ordre)
    }
    
}
