//
//  ScoringMyProfileView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 08/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class ScoringMyProfileView: UIView {
    var currentControler: FicheScoringUtilisateurViewController?
    @IBOutlet weak var pseudoSelfLabel: UILabel!
    @IBOutlet weak var photoSelfView: RoundPortraitUIImageView!
    @IBOutlet weak var catchSelfPhrase: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func update(controleur:FicheScoringUtilisateurViewController)
    {
        if let selfUtilisateur = Utilisateur.sharedInstance
        {
            pseudoSelfLabel.text = selfUtilisateur.pseudo
            catchSelfPhrase.text = selfUtilisateur.catchPhrase.removingPercentEncoding!
            let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(selfUtilisateur.urlImage)")!
            photoSelfView.af_setImage(withURL: url)
        }
    }
}
