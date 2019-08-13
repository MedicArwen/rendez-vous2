//
//  GuestUICollectionView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class GuestCollectionView: UICollectionView {
    var currentControleur: CreateGroupViewController?
    fileprivate var indiceSuscribedView = 0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension GuestCollectionView:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       /*
        guard RendezVous.sharedInstance != nil else {
             print("GuestCollectionView:count - no currentRendezvousFound")
            return 0
        }
         print("GuestCollectionView:count - \(RendezVous.sharedInstance!.invitationList.count) invitation(s)")
        return RendezVous.sharedInstance!.invitationList.count*/
        guard currentControleur!.currentRendezVous != nil else {
            print("GuestCollectionView:count - no currentRendezvousFound")
            return 0
        }
        print("GuestCollectionView:count - \(currentControleur!.currentRendezVous!.invitationList.count) invitation(s)")
        return currentControleur!.currentRendezVous!.invitationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("GuestCollectionViewCell n°#\(indexPath.row) updated")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guestCollectionCell", for: indexPath) as! GuestCollectionViewCell
        cell.update(invitation: currentControleur!.currentRendezVous!.invitationList[indexPath.row],controleur:self.currentControleur!)
        return cell
    }
}
extension GuestCollectionView:WebServiceLinkable
{
    func refresh() {
        print("GuestCollectionView:refresh")
        self.reloadData()
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
