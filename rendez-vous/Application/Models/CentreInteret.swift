//
//  CentreInteret.swift
//  rendez-vous
//
//  Created by Thierry BRU on 09/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class CentreInteret
{
    var id = 0
    var libelle = ""
    var order = 0
    init(id:Int,libelle:String, order:Int) {
        print("creation centre interet: N°\(order) - \(libelle)")
        self.id = id
        self.libelle = libelle
        self.order = order
    }
    convenience init(json:JSON,ordre:Int) {
        self.init(id:json["idCentreInteret"].intValue,libelle:json["libelle"].stringValue,order:ordre)
    }
    static func getCentreInteretList(json:JSON)->[CentreInteret]
    {
        var list = [CentreInteret]()
        var i = 1
        for jCentreInteret in json {
            list.append(CentreInteret(json:jCentreInteret.1,ordre:i))
            i += 1
        }
        return list
    }
}


