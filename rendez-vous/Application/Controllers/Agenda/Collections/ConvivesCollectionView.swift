//
//  ConvivesCollectionViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class ConvivesCollectionView: UICollectionView {
    var currentControleur: AgendaViewController?
    private var indiceSuscribedView = 0
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    }
    extension ConvivesCollectionView:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard currentControleur!.selectedRendezVous != nil else {
                print("ConvivesCollectionView:count - aucun rendez-vous trouvé")
                return 0
            }
            print("ConvivesCollectionView:count - \(currentControleur!.selectedRendezVous!.invitationList.count) invitation(s)")
            return currentControleur!.selectedRendezVous!.invitationList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            print("ConvivesCollectionView:update the convive cell n°#\(indexPath.row)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conviveCollectionCell", for: indexPath) as! ConvivesCollectionViewCell
            cell.update(invitation: currentControleur!.selectedRendezVous!.invitationList[indexPath.row], controleur:  self.currentControleur!)
            return cell
        }
    }
    extension ConvivesCollectionView:WebServiceLinkable
    {
       
        func refresh() {
            print("ConvivesCollectionView:refresh")
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
