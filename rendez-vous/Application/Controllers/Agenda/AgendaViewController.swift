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

    @IBOutlet weak var tableRendezVousHosted: MyRendezVousHostedUITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableRendezVousHosted.currentControleur = self
        self.tableRendezVousHosted.delegate = self.tableRendezVousHosted
        self.tableRendezVousHosted.dataSource = self.tableRendezVousHosted
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

}
