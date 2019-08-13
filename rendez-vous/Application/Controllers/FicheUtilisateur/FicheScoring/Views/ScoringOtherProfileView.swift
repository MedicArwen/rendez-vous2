//
//  ScoringOtherProfileView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 08/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class ScoringOtherProfileView: UIView {
    var currentControler: FicheScoringUtilisateurViewController?
    var currentUtilisateur: RankedUtilisateur?
    
    @IBOutlet weak var pseudoLabel: UIButton!
    @IBOutlet weak var photoView: RoundPortraitUIImageView!
    @IBOutlet weak var catchPhrase: UILabel!
    
    
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var buttonInvite: UIButton!
    @IBOutlet weak var labelIsInvited: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func update (utilisateur: RankedUtilisateur, controleur:FicheScoringUtilisateurViewController)
    {
        pseudoLabel.setTitle(utilisateur.pseudo,for: UIControl.State.normal)
        catchPhrase.text = utilisateur.catchPhrase.removingPercentEncoding!.removingPercentEncoding!
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(utilisateur.urlImage)")!
        photoView.af_setImage(withURL: url)
        currentUtilisateur = utilisateur
        currentControler = controleur
        
        if ListeSelectionUtilisateur.sharedInstance.inSelection(utilisateur: utilisateur)
        {
            buttonInvite.isHidden = true
            labelIsInvited.isHidden = false
        }
        else
        {
            buttonInvite.isHidden = false
            labelIsInvited.isHidden = true
        }
    }
    
    
    
    @IBAction func onClickPseudo(_ sender: UIButton) {
        currentControler!.currentUtilisateur = self.currentUtilisateur
        currentControler!.performSegue(withIdentifier: "showProfile", sender: self.currentControler)
    }
    @IBAction func onClickButtonInvite(_ sender: RoundButtonUIButton) {
        ListeSelectionUtilisateur.sharedInstance.addToSelection(utilisateur: self.currentUtilisateur!)
        buttonInvite.isHidden = true
        labelIsInvited.isHidden = false
        currentControler!.parentView!.reloadData()
    }
    @IBAction func onClickButtonFavorite(_ sender: UIButton)
    {
        //let tempAmi = self.currentUtilisateur! as Utilisateur
        let nouvelAmi = Favoris(rankedUtilisateur: self.currentUtilisateur!)
        Favoris.append(ami: nouvelAmi, datasource: self)
    }
}
extension ScoringOtherProfileView:FavorisDataSource
{
func favorisOnLoaded(ami: Favoris) {
    print("ScoringOtherProfileView:FavorisDataSource:favorisOnLoaded NOT IMPLEMENTED")
}

func favorisOnLoaded(amis: ListeUtilisateursFavoris) {
    print("ScoringOtherProfileView:FavorisDataSource:favorisOnLoaded NOT IMPLEMENTED")
}

func favorisOnDeleted() {
    print("ScoringOtherProfileView:FavorisDataSource:favorisOnDeleted NOT IMPLEMENTED")
}

func favorisOnCreated(ami: Favoris) {
    print("ScoringOtherProfileView:FavorisDataSource:favorisOnCreated")
    Utilisateur.sharedInstance!.friendList!.liste.append(ami)
}

func favorisOnNotFoundFavoris() {
    print("ScoringOtherProfileView:FavorisDataSource:favorisOnNotFoundFavoris NOT IMPLEMENTED")
}

func favorisOnWebServiceError(code: Int) {
    print("ScoringOtherProfileView:FavorisDataSource:favorisOnWebServiceError NOT IMPLEMENTED")
}
}
