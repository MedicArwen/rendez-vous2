//
//  FicheMonLongProfilCentreInteretView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 31/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class FicheMonLongProfilCentreInteretView: UIView {
   
    var parentControleur : RamonViewController?
    @IBOutlet weak var centreInteretCollection: CentreInteretUtilisateurCollectionView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func update(controleur:RamonViewController)
    {
        centreInteretCollection.delegate = centreInteretCollection
        centreInteretCollection.dataSource = centreInteretCollection
        ListeCentreInteretUtilisateur.load(controleur: controleur)
        ListeCentreInteretUtilisateur.subscribe(vue: centreInteretCollection)
        centreInteretCollection.parentControleur = controleur
        self.parentControleur = controleur
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressPhotoCollectionView(sender:)))
        longPress.minimumPressDuration = 0.1
        self.centreInteretCollection.addGestureRecognizer(longPress)
    }
    @objc func longPressPhotoCollectionView(sender: UILongPressGestureRecognizer) {
print("longPressPhotoCollectionView!")
        let controleur = parentControleur as! FicheMyProfilViewController
        let point = sender.location(in: controleur.ficheLongCentreInteret)
        switch sender.state {
        case .began:
             print("->began")
            guard let indexPath = centreInteretCollection.indexPathForItem(at: point) else {
                return
            }
            let isS = centreInteretCollection.beginInteractiveMovementForItem(at: indexPath)
            print(isS)
        case .changed:
            print("->changed")
            centreInteretCollection.updateInteractiveMovementTargetPosition(point)
        case .ended:
             print("->ended")
            centreInteretCollection.endInteractiveMovement()
            
        default:
            centreInteretCollection.cancelInteractiveMovement()
        }
        
    }
}
