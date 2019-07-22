//
//  CentreInteretTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 09/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class CentreInteretTableViewCell: UITableViewCell {

    @IBOutlet weak var OrdrePreferenceLabel: UILabel!
    
    @IBOutlet weak var libelleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func update(centreInteret:CentreInteret)
    {
        self.OrdrePreferenceLabel.text = "\(centreInteret.order)"
        if centreInteret.order > 10
        {
            self.OrdrePreferenceLabel.isHidden = true
        }
        else
        {
            self.OrdrePreferenceLabel.isHidden = false
        }
        self.libelleLabel.text = centreInteret.libelle
    }

}
