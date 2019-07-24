//
//  GuestHostedRendezVousUICollectionView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class GuestHostedRendezVousUICollectionView: UICollectionView {
    var currentControleur: CreateGroupViewController?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
extension GuestHostedRendezVousUICollectionView:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentControleur!.currentRendezVous == nil
        {return 0}
        
        return currentControleur!.currentRendezVous!.invitationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("update the cell n°#\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guestCollectionCell", for: indexPath) as! GuestCollectionViewCell
        //cell.update(utilisateur: (RendezVousApplication.sharedInstance.currentRendezVous!.guestList[indexPath.row]),controleur:self.currentControleur!)
        cell.update(invitation: currentControleur!.currentRendezVous!.invitationList[indexPath.row], controleur:  self.currentControleur!)
        return cell
    }
}
