//
//  StyleCuisineTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class StyleCuisineTableViewCell: UITableViewCell {

        
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
        public func update(typeCusine:StyleCuisineUtilisateur)
        {
            self.OrdrePreferenceLabel.text = "\(typeCusine.order)"

            self.libelleLabel.text = typeCusine.libelle
        }
        
}
