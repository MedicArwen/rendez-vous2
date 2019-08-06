//
//  TypeCuisineViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class TypeCuisineViewController: RamonViewController {

    @IBOutlet weak var pseudoUILabel: UILabel!
    
    @IBOutlet var table: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.dragInteractionEnabled = true
        print("\(NewProfile.SharedInstance.typeCuisines.count)")
        RendezVousWebService.sharedInstance.listeTypeCuisine { (json: JSON?, error: Error?) in
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
                    NewProfile.SharedInstance.typeCuisines = StyleCuisineUtilisateur.getTypeCuisineList(json:json["data"])
                    // activer le bouton next!
                    print("\(NewProfile.SharedInstance.typeCuisines.count)")
                    self.table.reloadData()
                }
            }
        }
        table.setEditing(true, animated: true)
        RendezVousWebService.sharedInstance.registerCentreInteret { (json: JSON?, error: Error?) in
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
                    // activer le bouton next!
                }
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        pseudoUILabel.text = NewProfile.SharedInstance.pseudo
    }
}
extension TypeCuisineViewController:UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NewProfile.SharedInstance.typeCuisines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleCuisine", for: indexPath) as! StyleCuisineTableViewCell
        cell.update(typeCusine: NewProfile.SharedInstance.typeCuisines[indexPath.row])
        print("\(NewProfile.SharedInstance.typeCuisines[indexPath.row].libelle)")
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //liste[sourceIndexPath.row] =
        NewProfile.SharedInstance.typeCuisines.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        NewProfile.SharedInstance.typeCuisines[sourceIndexPath.row].order = sourceIndexPath.row + 1
        NewProfile.SharedInstance.typeCuisines[destinationIndexPath.row].order = destinationIndexPath.row + 1
        table.reloadData()
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Are you sure?"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            NewProfile.SharedInstance.typeCuisines.remove(at: indexPath.row)
            table.reloadData()
        }
    }

}
