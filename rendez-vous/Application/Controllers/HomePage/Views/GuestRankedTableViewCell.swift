//
//  GuestRankedTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class GuestRankedTableViewCell: UITableViewCell {
    var currentControleur: CreateGroupViewController?
    var utilisateur: RankedUtilisateur?
    
    @IBOutlet weak var photoUtilisateur: RoundPortraitUIImageView!
    
    @IBOutlet weak var pseudoUtilisateur: UILabel!
    
    @IBOutlet weak var scoreRanking: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(rankedUtilisateur:RankedUtilisateur,controleur: CreateGroupViewController)
    {
        self.currentControleur = controleur
        self.utilisateur = rankedUtilisateur
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(rankedUtilisateur.urlImage)")!
        self.photoUtilisateur.af_setImage(withURL: url)
        self.photoUtilisateur.layer.cornerRadius = 50.0
        self.pseudoUtilisateur.text = rankedUtilisateur.pseudo
        self.scoreRanking.text = "\(trunc(rankedUtilisateur.ranking!*100))"
    }
    @IBAction func onClickInvite(_ sender: RoundButtonUIButton) {
        let invitation = Invitation(numInvite:self.utilisateur!.idUtilisateur,numRendezVous:RendezVousApplication.sharedInstance.currentRendezVous!.idRendezVous ,numStatusInvitation:1)
        let utilisateur = self.utilisateur as Utilisateur?
        invitation.Save { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: self.currentControleur!, returnCode: json["returnCode"].intValue)
                }
                else
                {
                print("UtilisateurInvite")
                    RendezVousApplication.sharedInstance.currentRendezVous!.addInvitation(invitation: invitation)
                    RendezVousApplication.sharedInstance.currentRendezVous!.addGuest(utilisateur: utilisateur! )
                    RendezVousApplication.sharedInstance.matchList!.remove(rankedUser: utilisateur!)
                    self.currentControleur!.guestInvitedCollection.reloadData()
                    self.currentControleur!.GuestRankedTable.reloadData()
                  
                }
            }
        }
    }
    
}

