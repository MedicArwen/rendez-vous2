//
//  CentreInteretUtilisateurCollectionView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 31/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class CentreInteretUtilisateurCollectionView: UICollectionView {
    var parentControleur:RamonViewController?
    fileprivate var indiceSuscribedView = 0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CentreInteretUtilisateurCollectionView:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard ListeCentreInteretUtilisateur.sharedInstance != nil else {
            print("CentreInteretUtilisateurCollectionView:count - no current ListeCentreInteretUtilisateur")
            return 0
        }
        print("CentreInteretUtilisateurCollectionView:count - \(ListeCentreInteretUtilisateur.sharedInstance!.liste.count) centres interets(s)")
        return ListeCentreInteretUtilisateur.sharedInstance!.liste.count
    }
    //func collection
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("SWAP \(sourceIndexPath.row) to \(destinationIndexPath)")
        ListeCentreInteretUtilisateur.swap(source:sourceIndexPath.row,dest:destinationIndexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("CentreInteretUtilisateurCollectionView n°#\(indexPath.row) updated")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "centreInteretCollCell", for: indexPath) as! CentreInteretUtilisateurCollectionViewCell
        cell.update(centreInteret: ListeCentreInteretUtilisateur.sharedInstance!.liste[indexPath.row])
        return cell
    }
    
}
extension CentreInteretUtilisateurCollectionView:WebServiceLinkable
{
    func refresh() {
        print("CentreInteretUtilisateurCollectionView:refresh")
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
