//
//  FicheScoringUtilisateurViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 08/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class FicheScoringUtilisateurViewController: RamonViewController {
    
  var currentUtilisateur: RankedUtilisateur?
    var score : String?
    var parentView: MesMatchsTableView?
    
    @IBOutlet weak var scoringMyProfile: ScoringMyProfileView!
    
    @IBOutlet weak var scoringOtherProfile: ScoringOtherProfileView!
    
   
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        guard currentUtilisateur != nil else {
            return
        }
       scoringMyProfile.update(controleur: self)
        scoringOtherProfile.update(utilisateur: self.currentUtilisateur!, controleur: self)
        scoreLabel.text = score!
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "showProfile"
        {
            let dest = segue.destination as! FicheUtilisateurViewController
            dest.currentUtilisateur = currentUtilisateur!
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
}
