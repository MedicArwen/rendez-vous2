//
//  MesMatchsTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 07/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class MesMatchsTableViewCell: UITableViewCell {
    var currentControleur: RamonViewController?
    var utilisateur: RankedUtilisateur?
    
    @IBOutlet weak var photoUtilisateur: RoundPortraitUIImageView!
    @IBOutlet weak var pseudoUtilisateur: UIButton!
    @IBOutlet weak var scoreRanking: UILabel!
    
    @IBOutlet weak var labelIsInvited: RoundUILabel!
    
    @IBOutlet weak var buttonInvitation: RoundButtonUIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    func update(rankedUtilisateur:RankedUtilisateur,controleur: RamonViewController)
    {
        print("GuestRankedTableViewCell:update (id:\(rankedUtilisateur.idUtilisateur))")
        self.currentControleur = controleur
        self.utilisateur = rankedUtilisateur
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(rankedUtilisateur.urlImage)")!
        self.photoUtilisateur.af_setImage(withURL: url)
        self.photoUtilisateur.layer.cornerRadius = 50.0
        self.pseudoUtilisateur.setTitle(rankedUtilisateur.pseudo, for: UIControl.State.normal)
        self.scoreRanking.text = "\(trunc(rankedUtilisateur.ranking!*100))%"
        if ListeSelectionUtilisateur.sharedInstance.inSelection(utilisateur: rankedUtilisateur)
        {
            buttonInvitation.isHidden = true
            labelIsInvited.isHidden = false
        }
        else
        {
            buttonInvitation.isHidden = false
            labelIsInvited.isHidden = true
        }
    }

    @IBAction func onClickPseudo(_ sender: UIButton) {
        let crtParent = self.currentControleur as! MesMatchsViewController
            crtParent.currentUtilisateur = self.utilisateur
            crtParent.currentScore = "\(trunc(utilisateur!.ranking!*100))%"
            crtParent.performSegue(withIdentifier: "showScoring", sender: self.currentControleur!)
    }
    
    @IBAction func onClickInvite(_ sender: RoundButtonUIButton) {
        ListeSelectionUtilisateur.sharedInstance.addToSelection(utilisateur: self.utilisateur!)
        buttonInvitation.isHidden = true
        labelIsInvited.isHidden = false
    }
}
