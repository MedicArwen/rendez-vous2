//
//  TypeCuisine.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class TypeCuisine
{   var id = 0
    var libelle = ""
    init(id:Int,libelle:String) {
        self.id = id
        self.libelle = libelle
    }
    convenience init(json:JSON) {
        self.init(id:json["idTypeCuisine"].intValue,libelle:json["libelle"].stringValue)
    }
    
}
extension TypeCuisine:TypeCuisineListable
{
    static func load(datasource: TypeCuisineDataSource) {
        print("TypeCuisine:TypeCuisineListable:load")
        let webservice = WebServiceTypeCuisine(commande: .LIST, entite: .TypeCuisine, datasource: datasource)
        webservice.execute()
    }
    
}

