//
//  InvitationCrudable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation

protocol InvitationCrudable {
    func create(datasource:InvitationDataSource)
    static func read(datasource:InvitationDataSource,numRendezVous:Int,numInvite:Int)
    func update(datasource:InvitationDataSource)
    func delete(datasource:InvitationDataSource)
    func cancel(datasource:InvitationDataSource)
    func reject(datasource:InvitationDataSource)
    func accept(datasource:InvitationDataSource)
}
