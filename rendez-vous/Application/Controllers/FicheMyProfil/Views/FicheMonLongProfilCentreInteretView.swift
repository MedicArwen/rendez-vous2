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
        print("FicheMonLongProfilCentreInteretView:update")
        centreInteretCollection.delegate = centreInteretCollection
        centreInteretCollection.dataSource = centreInteretCollection
       // ListeCentreInteretUtilisateur.load(controleur: controleur)
        CentreInteretUtilisateur.load(datasource: self)
        
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
extension FicheMonLongProfilCentreInteretView:CentreInteretUtilisateurDataSource
{
    func centreInteretUtilisateurOnLoaded(centreInteret: CentreInteretUtilisateur) {
        print("FicheMonLongProfilCentreInteretView:CentreInteretDataSource:centreInteretOnLoaded NOT IMPLEMENTED")
       
    }
    
    func centreInteretUtilisateurOnLoaded(centresInterets: ListeCentreInteretUtilisateur) {
        print("FicheMonLongProfilCentreInteretView:CentreInteretDataSource:centreInteretOnLoaded")
        ListeCentreInteretUtilisateur.sharedInstance = centresInterets
        ListeCentreInteretUtilisateur.reloadViews()
         print("centre d'interet chargés")
    }
    
    func centreInteretUtilisateurOnUpdated() {
        print("FicheMonLongProfilCentreInteretView:CentreInteretDataSource:centreInteretOnUpdated NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnDeleted() {
        print("FicheMonLongProfilCentreInteretView:CentreInteretDataSource:centreInteretOnDeleted NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnCreated() {
        print("FicheMonLongProfilCentreInteretView:CentreInteretDataSource:centreInteretOnCreated NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnNotFoundCentreInteret() {
        print("FicheMonLongProfilCentreInteretView:CentreInteretDataSource:centreInteretOnNotFoundCentreInteret NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnWebServiceError(code: Int) {
        print("FicheMonLongProfilCentreInteretView:CentreInteretDataSource:centreInteretOnWebServiceError")
        AlerteBoxManager.sendAlertMessage(vc: self.parentControleur!, returnCode: code)
    }
    
    
}
