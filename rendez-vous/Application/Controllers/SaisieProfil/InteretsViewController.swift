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
        CentreInteret.load(datasource: self)
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
        guard ListeCentreInteretUtilisateur.sharedInstance != nil else {
            return 0
        }
        return ListeCentreInteretUtilisateur.sharedInstance!.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleInteret", for: indexPath) as! CentreInteretTableViewCell
        cell.update(centreInteret: ListeCentreInteretUtilisateur.sharedInstance!.liste[indexPath.row])
        print("\(ListeCentreInteretUtilisateur.sharedInstance!.liste[indexPath.row].libelle)")
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
        ListeCentreInteretUtilisateur.sharedInstance!.liste.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        ListeCentreInteretUtilisateur.sharedInstance!.liste[sourceIndexPath.row].order = sourceIndexPath.row + 1
        ListeCentreInteretUtilisateur.sharedInstance!.liste[destinationIndexPath.row].order = destinationIndexPath.row + 1
        table.reloadData()
    }
}
extension InteretsViewController:CentreInteretDataSource
{
    func centreInteretOnNotFoundCentreInteret() {
         print("InteretsViewController:CentreInteretUtilisateurDataSource:centreInteretOnNotFoundCentreInteret NOT IMPLEMENTED ")
    }
    
    func centreInteretOnWebServiceError(code: Int) {
         print("InteretsViewController:CentreInteretUtilisateurDataSource:centreInteretOnWebServiceError NOT IMPLEMENTED ")
    }
    
    func centreInteretOnLoaded(centreInteret:CentreInteret) {
        print("InteretsViewController:CentreInteretUtilisateurDataSource:centreInteretrOnLoaded NOT IMPLEMENTED ")
    }
    
    func centreInteretOnLoaded(centresInterets:ListeCentreInterets) {
        ListeCentreInteretUtilisateur.sharedInstance = ListeCentreInteretUtilisateur(centreInterets: centresInterets)
        // activer le bouton next!
        print("-> il y a \(ListeCentreInteretUtilisateur.sharedInstance!.liste.count) centres d'intérêts disponibles")
        self.table.reloadData()
    }  
}
