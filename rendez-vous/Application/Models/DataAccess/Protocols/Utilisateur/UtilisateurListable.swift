//
//  UtilisateurListable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol UtilisateurListable {
    static func load(datasource:UtilisateurDataSource,latitude:Double,longitude:Double,range:Int)
}
