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

        // Do any additional setup after loading the view.
        AgendaEventHosted.loadHostedRendezVous{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: self, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    RendezVousApplication.sharedInstance.listeRendezVousCrees = AgendaEventHosted(json:json["data"])
                    self.tableRendezVousHosted.delegate = self.tableRendezVousHosted
                    self.tableRendezVousHosted.dataSource = self.tableRendezVousHosted
                    self.tableRendezVousHosted.reloadData()
                }
            }
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

}
