//
//  GuestHostedRendezVousUICollectionViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class GuestHostedRendezVousUICollectionViewCell: UICollectionViewCell {
    var currentControleur: UIViewController?
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
    func update(invitation:Invitation,controleur: UIViewController)
    {
        self.currentControleur = controleur
        self.invitation = invitation
        self.pseudoLabel.text = invitation.utilisateur.pseudo
        self.statusInvitationLabel.text = invitation.getStatusSymbol()
    }
}
