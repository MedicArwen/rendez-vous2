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
    var currentControleur: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func update(rendezvous:RendezVous, controleur:UIViewController)
    {
        dateRendezVousLabel.text = rendezvous.getDay()
        heureRendezVousLabel.text = rendezvous.getHour()
        nomRestaurant.text = "\(rendezvous.restaurant!.raisonSociale)"
        nomHoteLabel.text = "\(rendezvous.hote.pseudo)"
        self.rendezVous = rendezvous
        self.currentControleur = controleur
        self.collectionGuestsCollectionView.delegate = self
        self.collectionGuestsCollectionView.dataSource = self
        self.collectionGuestsCollectionView.reloadData()
    }
    
    @IBAction func onClickCancel(_ sender: RoundButtonUIButton) {
    }
    
    @IBAction func onClickReject(_ sender: RoundButtonUIButton) {
    }
    @IBAction func onClickAccept(_ sender: RoundButtonUIButton) {
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
