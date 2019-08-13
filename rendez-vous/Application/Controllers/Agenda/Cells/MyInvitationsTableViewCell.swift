//
//  MyInvitationsTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class MyInvitationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateRendezVousLabel: UILabel!
    @IBOutlet weak var heureRendezVousLabel: UILabel!
    @IBOutlet weak var collectionGuestsCollectionView: GuestCollectionView!
    @IBOutlet weak var nomRestaurant: UILabel!
    @IBOutlet weak var nomHoteLabel: UILabel!
    
    @IBOutlet weak var buttonCancel: RoundButtonUIButton!
    @IBOutlet weak var buttonReject: RoundButtonUIButton!
    @IBOutlet weak var buttonAccept: RoundButtonUIButton!
    
    var rendezVous:RendezVous?
    var currentControleur: AgendaViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func update(rendezvous:RendezVous, controleur:AgendaViewController)
    {
        print("MyInvitationsTableViewCell:update (id rdv:\(rendezvous.idRendezVous))")
        self.dateRendezVousLabel.text = rendezvous.getDay()
        self.heureRendezVousLabel.text = rendezvous.getHour()
        self.nomRestaurant.text = "\(rendezvous.restaurant!.raisonSociale)"
        self.nomHoteLabel.text = "\(rendezvous.hote.pseudo)"
        self.rendezVous = rendezvous
        self.currentControleur = controleur
        self.collectionGuestsCollectionView.delegate = self
        self.collectionGuestsCollectionView.dataSource = self
        self.collectionGuestsCollectionView.reloadData()
        if rendezvous.getInvitationOfOneUser(utilisateur: Utilisateur.sharedInstance!)!.numStatusInvitation == 2
        {
            print("MyInvitationsTableViewCell:update - le rendez-vous a le statut 2")
            self.buttonAccept.isHidden = true
            self.buttonReject.isHidden = true
            self.buttonCancel.isHidden = false
        }
    }
    
    @IBAction func onClickCancel(_ sender: RoundButtonUIButton) {
        print("MyInvitationsTableViewCell:onClickCancel ")
        ListeInvitationsAsConvive.sharedInstance!.reject(controleur: currentControleur!, rendezVous: rendezVous!, dataSource: self)
    }
    
    @IBAction func onClickReject(_ sender: RoundButtonUIButton) {
        print("MyInvitationsTableViewCell:onClickReject ")
        ListeInvitationsAsConvive.sharedInstance!.reject(controleur: currentControleur!, rendezVous: rendezVous!,dataSource: self)
    }
    @IBAction func onClickAccept(_ sender: RoundButtonUIButton) {
        print("MyInvitationsTableViewCell:onClickAccept ")
        ListeInvitationsAsConvive.sharedInstance!.accept(controleur: currentControleur!,rendezVous: rendezVous!,dataSource: self)
        buttonAccept.isHidden = true
        buttonReject.isHidden = true
        buttonCancel.isHidden = false
    }
    @IBAction func onClickInvite(_ sender: Any) {
        print("MyRendezVousTableViewCellclick:onClickInvite (id rdv: \(self.rendezVous!.idRendezVous))")
        /* let vc = self.currentControleur as! AgendaViewController
         vc.currentRendezVous = rendezVous
         vc.currentRestaurant = rendezVous!.restaurant*/
        currentControleur!.selectedRendezVous = self.rendezVous!
        Restaurant.sharedInstance = self.rendezVous!.restaurant!
        self.currentControleur!.performSegue(withIdentifier: "showUpdateGroup", sender: self.currentControleur!)
    }
}
extension MyInvitationsTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  return self.rendezVous!.guestList.count
        return self.rendezVous!.invitationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("update the collectionGuestsCollectionView n°#\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conviveCollectionCell", for: indexPath) as! ConvivesCollectionViewCell
        cell.update(invitation: self.rendezVous!.invitationList[indexPath.row], controleur: self.currentControleur!)
        
        return cell
    }
    
    
}
extension MyInvitationsTableViewCell:InvitationDataSource
{
    func invitationOnLoaded(invitation: Invitation) {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnLoaded NOT IMPLEMENTED")
    }
    
    func invitationOnLoaded(invitations: ListeInvitationsAsConvive) {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnLoaded NOT IMPLEMENTED")
    }
    
    func invitationOnUpdated() {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnUpdated NOT IMPLEMENTED")
    }
    
    func invitationOnDeleted() {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnDeleted NOT IMPLEMENTED")
    }
    
    func invitationOnCancelled() {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnCancelled NOT IMPLEMENTED")
    }
    
    func invitationOnRejected() {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnRejected NOT IMPLEMENTED")
    }
    
    func invitationOnAccepted() {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnAccepted NOT IMPLEMENTED")
    }
    
    func invitationOnCreated(invitation: Invitation) {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnCreated NOT IMPLEMENTED")
    }
    
    func invitationOnNotFoundInvitation() {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnNotFoundInvitation NOT IMPLEMENTED")
    }
    
    func invitationOnWebServiceError(code: Int) {
        print("MyInvitationsTableViewCell:InvitationDataSource:invitationOnWebServiceError")
        AlerteBoxManager.sendAlertMessage(vc: self.currentControleur!, returnCode: code)
    }
    
    
}
