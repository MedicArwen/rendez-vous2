//
//  FicheUtilisateurViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class FicheUtilisateurViewController: RamonViewController {

    var currentUtilisateur: RankedUtilisateur?
    
    
    
    @IBOutlet weak var pseudoLabel: UILabel!
    
    @IBOutlet weak var photoView: RoundPortraitUIImageView!
    @IBOutlet weak var catchPhrase: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        guard currentUtilisateur != nil else {
            return
        }
        if let utilisateur = currentUtilisateur
        {
            pseudoLabel.text = utilisateur.pseudo
            catchPhrase.text = utilisateur.catchPhrase.removingPercentEncoding!
            descriptionText.text = utilisateur.description.removingPercentEncoding!
            let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(utilisateur.urlImage)")!
            photoView.af_setImage(withURL: url)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onClickClose(_ sender: RoundButtonUIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func onClickLikeDislike(_ sender: RoundButtonUIButton) {
    }
    @IBAction func onClickInvite(_ sender: Any) {
    }
    
}
