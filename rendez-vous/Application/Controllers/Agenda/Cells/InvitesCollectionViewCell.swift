//
//  GuestHostedRendezVousUICollectionViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class InvitesCollectionViewCell: UICollectionViewCell {
    var currentControleur: RamonViewController?
    var invitation:Invitation?
    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var statusInvitationLabel: UILabel!
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    func update(invitation:Invitation,controleur: RamonViewController)
    {
        print("InvitesCollectionViewCell: update (num rdv:\(invitation.getRendezVousID()), num invite:\(invitation.getInviteID()))")
        self.currentControleur = controleur
        self.invitation = invitation
        self.pseudoLabel.text = invitation.utilisateur.pseudo
        self.statusInvitationLabel.text = invitation.getStatusSymbol()
    }
}
