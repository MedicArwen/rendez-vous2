//
//  RendezVousListable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol RendezVousListable {
    static func load(dataSource:RendezVousDataSource)
    static func append(rendezVous:RendezVous,dataSource:RendezVousDataSource)
    static func remove(indice:Int,dataSource:RendezVousDataSource)
    static func find(rendezVous:RendezVous)->Int
}
