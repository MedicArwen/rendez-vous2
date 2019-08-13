//
//  GuestHostedRendezVousUICollectionView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class InvitesCollectionView: UICollectionView {
    var currentControleur: AgendaViewController?
    fileprivate var indiceSuscribedView = 0
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
extension InvitesCollectionView:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard currentControleur!.selectedRendezVous != nil else {
            print("InvitesCollectionView:count - aucun rendez-vous trouvé")
            return 0
        }
         print("InvitesCollectionView:count - \(currentControleur!.selectedRendezVous!.invitationList.count) invitations")
        return currentControleur!.selectedRendezVous!.invitationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("InvitesCollectionView: update the cell n°#\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guestCollectionCell", for: indexPath) as! ConvivesCollectionViewCell
        cell.update(invitation: currentControleur!.selectedRendezVous!.invitationList[indexPath.row], controleur:  self.currentControleur!)
        return cell
    }
}
extension InvitesCollectionView:WebServiceLinkable
{
    func refresh() {
        print("InvitesCollectionView:refresh")
        reloadData()
    }
    var indice: Int {
        get {
            return indiceSuscribedView
        }
        set {
            indiceSuscribedView = newValue
        }
    }
}
