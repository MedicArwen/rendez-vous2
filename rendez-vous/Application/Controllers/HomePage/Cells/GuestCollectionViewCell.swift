//
//  GuestCollectionViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class GuestCollectionViewCell: UICollectionViewCell {
    var currentControleur: UIViewController?
    var invitation:Invitation?
    @IBOutlet weak var pseudoLabel: UILabel!
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
    }
}


