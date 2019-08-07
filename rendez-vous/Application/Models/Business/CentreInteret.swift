//
//  CentreInteret.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class CentreInteret
{   var id = 0
    var libelle = ""
    
    init(id:Int,libelle:String) {
        self.id = id
        self.libelle = libelle
    }
    convenience init(json:JSON) {
        self.init(id:json["idCentreInteret"].intValue,libelle:json["libelle"].stringValue)
    }
    
}
extension CentreInteret:CentreInteretListable
{
    static func load(datasource: CentreInteretDataSource) {
        print("CentreInteret:CentreInteretListable:load")
        let webservice = WebServiceCentreInteret(commande: .LIST, entite: .CentreInteret, datasource: datasource)
        webservice.execute()
    }
    
}
