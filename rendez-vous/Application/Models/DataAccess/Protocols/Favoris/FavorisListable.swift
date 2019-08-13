//
//  FavorisListable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 13/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol FavorisListable {
    static func load(datasource:FavorisDataSource)
    static func append(ami:Favoris,datasource:FavorisDataSource)
    static func remove(indice:Int,datasource:FavorisDataSource)
    static func find(ami:Favoris)->Int
}
