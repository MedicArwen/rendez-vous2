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

        // Do any additional setup after loading the view.
        print("\(String(describing: NewProfile.SharedInstance.centresInterets.count))")
        print("\(String(describing: NewProfile.SharedInstance.typeCuisines.count))")
        print("\(NewProfile.SharedInstance.catchPhrase)")
        print("\(NewProfile.SharedInstance.description)")
        print("\(String(describing: NewProfile.SharedInstance.urlImage))")
        RendezVousWebService.sharedInstance.registerTypeCuisine{ (json: JSON?, error: Error?) in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
