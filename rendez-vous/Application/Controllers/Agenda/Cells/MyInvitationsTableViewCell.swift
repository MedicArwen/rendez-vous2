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
    var currentControleur: RamonViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func update(rendezvous:RendezVous, controleur:RamonViewController)
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
        ListeInvitationsAsConvive.sharedInstance!.reject(controleur: currentControleur!, rendezVous: rendezVous!)
    }
    
    @IBAction func onClickReject(_ sender: RoundButtonUIButton) {
        print("MyInvitationsTableViewCell:onClickReject ")
        ListeInvitationsAsConvive.sharedInstance!.reject(controleur: currentControleur!, rendezVous: rendezVous!)
    }
    @IBAction func onClickAccept(_ sender: RoundButtonUIButton) {
        print("MyInvitationsTableViewCell:onClickAccept ")
        ListeInvitationsAsConvive.sharedInstance!.accept(controleur: currentControleur!,rendezVous: rendezVous!)
        buttonAccept.isHidden = true
        buttonReject.isHidden = true
        buttonCancel.isHidden = false
    }
    @IBAction func onClickInvite(_ sender: Any) {
        print("MyRendezVousTableViewCellclick:onClickInvite (id rdv: \(self.rendezVous!.idRendezVous))")
        /* let vc = self.currentControleur as! AgendaViewController
         vc.currentRendezVous = rendezVous
         vc.currentRestaurant = rendezVous!.restaurant*/
        RendezVous.sharedInstance = self.rendezVous!
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
