//
//  InvitationDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol InvitationDataSource {
    func invitationOnLoaded(invitation:Invitation)
    func invitationOnLoaded(invitations:ListeInvitationsAsConvive)
    func invitationOnUpdated()
    func invitationOnDeleted()
    func invitationOnCancelled()
    func invitationOnRejected()
    func invitationOnAccepted()
    func invitationOnCreated()
    func invitationOnNotFoundInvitation()
    func invitationOnWebServiceError(code:Int)
}
