//
//  StyleCuisine.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class StyleCuisineUtilisateur
{
    var id = 0
    var libelle = ""
    var order = 0
    init(id:Int,libelle:String, order:Int) {
        self.id = id
        self.libelle = libelle
        self.order = order
    }
    
    convenience init(json:JSON,ordre:Int) {
        self.init(id:json["idTypeCuisine"].intValue,libelle:json["libelle"].stringValue,order:ordre)
    }
    
    static func getTypeCuisineList(json:JSON)->[StyleCuisineUtilisateur]
    {
        var list = [StyleCuisineUtilisateur]()
        var i = 1
        for jStyleCuisine in json {
            list.append(StyleCuisineUtilisateur(json:jStyleCuisine.1,ordre:i))
            i += 1
        }
        return list
    }
}
