
//
//  RendezVousCrudable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol RendezVousCrudable {
    func create(datasource:RendezVousDataSource)
    static func read(datasource:RendezVousDataSource,idRendezVous:Int)->RendezVous?
    func update(datasource:RendezVousDataSource)
    func delete(datasource:RendezVousDataSource)
    func cancel(datasource:RendezVousDataSource)
}
