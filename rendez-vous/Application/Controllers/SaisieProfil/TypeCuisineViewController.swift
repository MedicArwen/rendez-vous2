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
        TypeCuisine.load(datasource: self)
        table.setEditing(true, animated: true)
        ListeCentreInteretUtilisateur.sharedInstance!.register(datasource: self)
        
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
        guard ListeTypeCuisineUtilisateur.sharedInstance != nil else {
            return 0
        }
        return ListeTypeCuisineUtilisateur.sharedInstance!.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleCuisine", for: indexPath) as! StyleCuisineTableViewCell
        cell.update(typeCusine: ListeTypeCuisineUtilisateur.sharedInstance!.liste[indexPath.row])
        print("\(ListeTypeCuisineUtilisateur.sharedInstance!.liste[indexPath.row].libelle)")
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
        ListeTypeCuisineUtilisateur.sharedInstance!.liste.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        ListeTypeCuisineUtilisateur.sharedInstance!.liste[sourceIndexPath.row].order = sourceIndexPath.row + 1
        ListeTypeCuisineUtilisateur.sharedInstance!.liste[destinationIndexPath.row].order = destinationIndexPath.row + 1
        table.reloadData()
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Are you sure?"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            ListeTypeCuisineUtilisateur.sharedInstance!.liste.remove(at: indexPath.row)
            table.reloadData()
        }
    }

}
extension TypeCuisineViewController:TypeCuisineDataSource{
    func typeCuisineOnLoaded(typeCuisines: ListeTypeCuisine) {
        print("typeCuisineViewController:TypeCuisineDataSource:typeCuisineOnLoaded")
        ListeTypeCuisineUtilisateur.sharedInstance = ListeTypeCuisineUtilisateur(typesCuisine: typeCuisines)
        // activer le bouton next!
        print("\(ListeTypeCuisineUtilisateur.sharedInstance!.liste.count)")
        self.table.reloadData()
    }
    
    func typeCuisineOnLoaded(typeCuisine: TypeCuisine) {
        print("typeCuisineViewController:TypeCuisineDataSource:typeCuisine NOT IMPLANTED")
    }
    
    func typeCuisineOnNotFoundTypeCuisine() {
        print("typeCuisineViewController:TypeCuisineDataSource:typeCuisineOnNotFoundTypeCuisine NOT IMPLANTED")
    }
    
    func typeCuisineOnWebServiceError(code: Int) {
        print("typeCuisineViewController:TypeCuisineDataSource:typeCuisineOnWebServiceError NOT IMPLANTED")
    }
    
    
}
extension TypeCuisineViewController:CentreInteretUtilisateurDataSource
{
    func centreInteretUtilisateurOnLoaded(centreInteret: CentreInteretUtilisateur) {
        print("TypeCuisineViewController:CentreInteretUtilisateurDataSource:centreInteretUtilisateurOnLoaded NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnLoaded(centresInterets: ListeCentreInteretUtilisateur) {
        print("TypeCuisineViewController:CentreInteretUtilisateurDataSource:centreInteretUtilisateurOnLoaded NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnUpdated() {
        print("TypeCuisineViewController:CentreInteretUtilisateurDataSource:centreInteretUtilisateurOnUpdated NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnDeleted() {
        print("TypeCuisineViewController:CentreInteretUtilisateurDataSource:centreInteretUtilisateurOnDeleted NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnCreated() {
        print("TypeCuisineViewController:CentreInteretUtilisateurDataSource:centreInteretUtilisateurOnCreated")
        print("enregistrement des centres d'interet")
    }
    
    func centreInteretUtilisateurOnNotFoundCentreInteret() {
        print("TypeCuisineViewController:CentreInteretUtilisateurDataSource:centreInteretUtilisateurOnNotFoundCentreInteret NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnWebServiceError(code: Int) {
        print("TypeCuisineViewController:CentreInteretUtilisateurDataSource:centreInteretUtilisateurOnWebServiceError NOT IMPLEMENTED")
    }
    
    
}
