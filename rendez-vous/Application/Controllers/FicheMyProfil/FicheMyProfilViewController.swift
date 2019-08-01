//
//  FicheMyProfilViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 30/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class FicheMyProfilViewController: RamonViewController {
//var listeCentreInteret = ListeCentreInteretUtilisateur.load(controleur: self)
    
    @IBOutlet weak var ficheUtilisateurShort: FicheMonShortProfilView!
    
    @IBOutlet weak var ficheLongCentreInteret: FicheMonLongProfilCentreInteretView!
    
    
    
    
    override func viewDidLoad() {
        print("FicheMyProfilViewController:viewDidLoad")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard RendezVousApplication.sharedInstance.connectedUtilisateur != nil else {
            print("Utilisateur non trouvé")
            return
        }
        self.ficheUtilisateurShort.update(controleur: self, utilisateur: RendezVousApplication.sharedInstance.connectedUtilisateur!)
        self.ficheLongCentreInteret.update(controleur:self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
          print("FicheMyProfilViewController:viewWillAppear")
        self.ficheLongCentreInteret.centreInteretCollection.refresh()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
