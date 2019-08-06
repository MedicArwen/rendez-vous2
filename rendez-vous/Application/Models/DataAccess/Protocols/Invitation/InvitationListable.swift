//
//  InvitationListable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol InvitationListable {
    static func load(datasource:InvitationDataSource)
    static func append(rendezVous:RendezVous)
    static func remove(indice:Int)
    static func find(rendezVous:RendezVous)->Int
}