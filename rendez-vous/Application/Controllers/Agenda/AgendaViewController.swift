//
//  AgendaViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class AgendaViewController: RamonViewController {

    @IBOutlet weak var tableRendezVousHosted: MyRendezVousTableView!
    @IBOutlet weak var tableInvitationsReceived: MyInvitationsTableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // on affiche la vue des rendez-vous créés par défaut
        tableRendezVousHosted.isHidden = false
        tableInvitationsReceived.isHidden = true
        
        //confifuration de la table des rendez-vous créés
        self.tableRendezVousHosted.currentControleur = self
        self.tableRendezVousHosted.delegate = self.tableRendezVousHosted
        self.tableRendezVousHosted.dataSource = self.tableRendezVousHosted
        ListeRendezVousAsHote.subscribe(vue: self.tableRendezVousHosted)
        ListeRendezVousAsHote.load(controleur: self)
        //Configuration de la table des invitations recues.
        self.tableInvitationsReceived.currentControleur = self
        self.tableInvitationsReceived.delegate = self.tableInvitationsReceived
        self.tableInvitationsReceived.dataSource = self.tableInvitationsReceived
        ListeRendezVousAsConvive.subscribe(vue: self.tableInvitationsReceived)
        ListeRendezVousAsConvive.load(controleur: self)
        
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onChangedTab(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            print("Afficher les invitations envoyées")
            tableRendezVousHosted.isHidden = false
            tableInvitationsReceived.isHidden = true
            ListeRendezVousAsHote.load(controleur: self)
        }
        else
        {
            print("Afficher les invitations recue")
            tableRendezVousHosted.isHidden = true
            tableInvitationsReceived.isHidden = false
            ListeRendezVousAsConvive.load(controleur: self)
        }
    }
}
