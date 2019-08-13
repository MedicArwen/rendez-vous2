//
//  FavoriteTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 13/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
//favoriteCell
    var currentControleur : MesFavorisViewController?
    var utilisateur: Utilisateur?
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var pseudo: UIButton!
    @IBOutlet weak var catchPhrase: UILabel!
    
    @IBOutlet weak var buttonInvit: RoundButtonUIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(utilisateur:Utilisateur,controleur:MesFavorisViewController)
    {
        self.utilisateur = utilisateur
        self.currentControleur = controleur
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(utilisateur.urlImage)")!
        self.photo.af_setImage(withURL: url)
        self.pseudo.setTitle("\(utilisateur.pseudo)", for: UIControl.State.normal)
        self.catchPhrase.text = utilisateur.catchPhrase.removingPercentEncoding!
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickInvite(_ sender: RoundButtonUIButton) {
    }
}
