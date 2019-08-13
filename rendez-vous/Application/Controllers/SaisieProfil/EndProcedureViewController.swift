//
//  EndProcedureViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class EndProcedureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ListeTypeCuisineUtilisateur.sharedInstance!.register(datasource: self)
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
extension EndProcedureViewController:TypeCuisineUtilisateurDataSource
{
    func typeCuisineUtilisateurOnLoaded(typeCuisines: ListeTypeCuisineUtilisateur) {
        print("EndProcedureViewController:TypeCuisineUtilisateurDataSource:typeCuisineUtilisateurOnLoaded NOT IMPLEMENTED")
    }
    
    func typeCuisineUtilisateurOnUpdated() {
        print("EndProcedureViewController:TypeCuisineUtilisateurDataSource:typeCuisineUtilisateurOnUpdated NOT IMPLEMENTED")
    }
    
    func typeCuisineUtilisateurOnCreated() {
        print("EndProcedureViewController:TypeCuisineUtilisateurDataSource:typeCuisineUtilisateurOnCreated")
        print("Creation des types cuisines utilisateurs réussie")
    }
    
    func typeCuisineUtilisateurOnNotFoundTypeCuisine() {
        print("EndProcedureViewController:TypeCuisineUtilisateurDataSource:typeCuisineUtilisateurOnNotFoundTypeCuisine NOT IMPLEMENTED")
    }
    
    func typeCuisineUtilisateurOnWebServiceError(code: Int) {
        print("EndProcedureViewController:TypeCuisineUtilisateurDataSource:typeCuisineUtilisateurOnWebServiceError")
        AlerteBoxManager.sendAlertMessage(vc: self, returnCode: code)
    }
    
    
}
