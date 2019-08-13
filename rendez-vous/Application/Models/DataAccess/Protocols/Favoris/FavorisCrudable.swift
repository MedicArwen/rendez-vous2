//
//  FavorisCrudable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 13/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol FavorisCrudable {
    func create(datasource:InvitationDataSource)
    static func read(datasource:InvitationDataSource,numRendezVous:Int,numInvite:Int)
    func delete(datasource:InvitationDataSource)
}

