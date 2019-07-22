//
//  CentreInteretsViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 09/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class InteretsViewController: UIViewController {
    
    @IBOutlet weak var pseudoUILabel: UILabel!
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.dragInteractionEnabled = true
        
        RendezVousWebService.sharedInstance.listeCentreInteret { (json: JSON?, error: Error?) in
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
                    NewProfile.SharedInstance.centresInterets = CentreInteret.getCentreInteretList(json:json["data"])
                    // activer le bouton next!
                    print("\(NewProfile.SharedInstance.centresInterets.count)")
                    self.table.reloadData()
                }
            }
        }
        
        
        table.setEditing(true, animated: true)
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        pseudoUILabel.text = NewProfile.SharedInstance.pseudo
    }
}
extension InteretsViewController:UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NewProfile.SharedInstance.centresInterets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleInteret", for: indexPath) as! CentreInteretTableViewCell
        cell.update(centreInteret: NewProfile.SharedInstance.centresInterets[indexPath.row])
        print("\(NewProfile.SharedInstance.centresInterets[indexPath.row].libelle)")
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //liste[sourceIndexPath.row] =
        NewProfile.SharedInstance.centresInterets.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        NewProfile.SharedInstance.centresInterets[sourceIndexPath.row].order = sourceIndexPath.row + 1
        NewProfile.SharedInstance.centresInterets[destinationIndexPath.row].order = destinationIndexPath.row + 1
        table.reloadData()
    }
}
