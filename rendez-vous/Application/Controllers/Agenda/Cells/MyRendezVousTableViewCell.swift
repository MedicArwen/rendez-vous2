//
//  MyRendezVousTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class MyRendezVousTableViewCell: UITableViewCell {

    @IBOutlet weak var dateRendezVousLabel: UILabel!
    
    @IBOutlet weak var heureRendezVousLabel: UILabel!
    @IBOutlet weak var statusRendezVousLabel: UILabel!
    
    @IBOutlet weak var collectionGuestsCollectionView: GuestUICollectionView!
    
    @IBOutlet weak var nomRestaurant: UILabel!
    
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
        statusRendezVousLabel.text = "\(rendezvous.numStatusRendezVous)"
        nomRestaurant.text = "\(rendezvous.restaurant!.raisonSociale)"
        self.rendezVous = rendezvous
        self.currentControleur = controleur
        self.collectionGuestsCollectionView.delegate = self
        self.collectionGuestsCollectionView.dataSource = self
        self.collectionGuestsCollectionView.reloadData()
    }

}
extension MyRendezVousTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  return self.rendezVous!.guestList.count
        return self.rendezVous!.invitationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("update the collectionGuestsCollectionView n°#\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guestCollectionCell", for: indexPath) as! GuestHostedRendezVousUICollectionViewCell
       cell.update(invitation: self.rendezVous!.invitationList[indexPath.row], controleur: self.currentControleur!)
      
        return cell
    }
    
    
}
