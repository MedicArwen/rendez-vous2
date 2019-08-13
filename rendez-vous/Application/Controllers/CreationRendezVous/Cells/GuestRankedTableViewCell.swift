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
    var indice: Int = 0
    
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
    
    func update(rankedUtilisateur:RankedUtilisateur,controleur: CreateGroupViewController,indice: Int)
    {
        print("GuestRankedTableViewCell:update (id:\(rankedUtilisateur.idUtilisateur))")
        self.currentControleur = controleur
        self.utilisateur = rankedUtilisateur
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(rankedUtilisateur.urlImage)")!
        self.photoUtilisateur.af_setImage(withURL: url)
        self.photoUtilisateur.layer.cornerRadius = 50.0
        self.pseudoUtilisateur.text = rankedUtilisateur.pseudo
        self.scoreRanking.text = "\(trunc(rankedUtilisateur.ranking!*100))"
        self.indice = indice
    }
    @IBAction func onClickInvite(_ sender: RoundButtonUIButton) {
        guard self.utilisateur != nil else {
            print("GuestRankedTableViewCell:onClickInvite - aucun utilisateur trouvé")
            return
        }
        print("GuestRankedTableViewCell:onClickInvite (id:\(self.utilisateur!.idUtilisateur))")
       // let guest = self.utilisateur //as Utilisateur
       // let invitation = Invitation(numInvite:self.utilisateur!.idUtilisateur,numRendezVous:RendezVous.sharedInstance!.idRendezVous ,numStatusInvitation:1,utilisateur: utilisateur!)
        if let rdv = currentControleur!.currentRendezVous
        {
           // let invitation = Invitation(utilisateur: self.utilisateur!, rendezVous: RendezVous.sharedInstance!, numStatusInvitation: 1)
            let invitation = Invitation(utilisateur: self.utilisateur!, rendezVous: rdv, numStatusInvitation: 1)
            invitation.create(datasource: self)
            // let indice = currentControleur!.listeMesMatchs!.find(utilisateur: self.utilisateur!)
            currentControleur!.listeMesMatchs!.remove(indice:self.indice)
            currentControleur!.viewMatchingPeople.GuestRankedTable.refresh()
            currentControleur!.viewMatchingPeople.guestInvitedCollection.refresh()
        }
        
    }
    
}
extension GuestRankedTableViewCell:InvitationDataSource
{
    func invitationOnLoaded(invitation: Invitation) {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    func invitationOnLoaded(invitations: ListeInvitationsAsConvive) {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    
    func invitationOnUpdated() {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    
    func invitationOnDeleted() {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    
    func invitationOnCancelled() {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    
    func invitationOnRejected() {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    
    
    func invitationOnAccepted() {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    
    func invitationOnCreated(invitation:Invitation) {
        print("GuestRankedTableViewCell:InvitationDataSource:invitationOnCreated")
        print("->UtilisateurInvite")
        currentControleur!.currentRendezVous!.addInvitation(invitation: invitation)
        
       
    }
    
    func invitationOnNotFoundInvitation() {
        print("GuestRankedTableViewCell:InvitationDataSource: - not implemented")
    }
    
    func invitationOnWebServiceError(code: Int) {
        print("GuestRankedTableViewCell:InvitationDataSource:")
        AlerteBoxManager.sendAlertMessage(vc: self.currentControleur!, returnCode: code)
    }
    
    
}

