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
    @IBOutlet weak var collectionGuestsCollectionView: GuestCollectionView!
    @IBOutlet weak var nomRestaurant: UILabel!
    
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
        print("MyRendezVousTableViewCell: update (id rdv:\(rendezvous.idRendezVous)")
        self.dateRendezVousLabel.text = rendezvous.getDay()
        self.heureRendezVousLabel.text = rendezvous.getHour()
        self.statusRendezVousLabel.text = "\(rendezvous.numStatusRendezVous)"
        self.nomRestaurant.text = "\(rendezvous.restaurant!.raisonSociale)"
        self.rendezVous = rendezvous
        self.currentControleur = controleur
        self.collectionGuestsCollectionView.delegate = self
        self.collectionGuestsCollectionView.dataSource = self
        self.collectionGuestsCollectionView.reloadData()
    }
    @IBAction func onClickInvite(_ sender: Any) {
        print("MyRendezVousTableViewCellclick:onClickInvite (id rdv: \(self.rendezVous!.idRendezVous))")
       /* let vc = self.currentControleur as! AgendaViewController
        vc.currentRendezVous = rendezVous
        vc.currentRestaurant = rendezVous!.restaurant*/
       // RendezVous.sharedInstance = self.rendezVous!
        currentControleur!.selectedRendezVous = self.rendezVous!
        Restaurant.sharedInstance = self.rendezVous!.restaurant!
        self.currentControleur!.performSegue(withIdentifier: "showUpdateGroup", sender: self.currentControleur!)
    }
    
}
extension MyRendezVousTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard rendezVous != nil else {
            print("MyRendezVousTableViewCell:count - rendez-vous non trouvé")
            return 0
        }
        print("MyRendezVousTableViewCell:count - \(self.rendezVous!.invitationList.count) invitation(s)")
        return self.rendezVous!.invitationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("MyRendezVousTableViewCell:update cell n°#\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guestCollectionCell", for: indexPath) as! InvitesCollectionViewCell
        cell.update(invitation: self.rendezVous!.invitationList[indexPath.row], controleur: self.currentControleur!)
        
        return cell
    }
    
}
