//
//  CentreInteretUtilisateurCollectionViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 31/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

//centreInteretCollCell

class CentreInteretUtilisateurCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roundedViewConteneur: RoundUIView!
    @IBOutlet weak var centreInteretLabel: UILabel!
    @IBOutlet weak var centreInteretOrdreLabel: UILabel!
    @IBOutlet weak var cercleOrdre: RoundUIView!
    
    func update(centreInteret:CentreInteretUtilisateur)
    {
        self.centreInteretLabel.text = centreInteret.libelle
        self.centreInteretOrdreLabel.text = "\(centreInteret.order)"
        cercleOrdre.layer.cornerRadius = CGFloat(integerLiteral: 21)
        if centreInteret.order > 10
        {
            centreInteretOrdreLabel.isHidden = true
            cercleOrdre.isHidden = true
        }
        else
        {
           
            centreInteretOrdreLabel.isHidden = false
            cercleOrdre.isHidden = false
        }
         roundedViewConteneur.layer.backgroundColor = getcolorOrder(ordre: centreInteret.order)
    }
    func getcolorOrder(ordre:Int)->CGColor
    {
        switch ordre {
        case 1:
            return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case 2:
            return #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        case 3:
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case 4:
            return #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case 5:
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 6:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case 7:
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 8:
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case 9:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case 10:
            return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        default:
             return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
    }
    
}
