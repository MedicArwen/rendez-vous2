//
//  PreviewViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftHash
import SwiftyJSON

class PreviewViewController: UIViewController {

    @IBOutlet weak var PictureUIImage: RoundPortraitUIImageView!
    
    @IBOutlet weak var pseudoUILabel: UILabel!
    @IBOutlet weak var catchPhraseUILabel: UILabel!
    
    @IBOutlet weak var descriptionUILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /* NewProfile.SharedInstance.createUtilisateur { (json: JSON?, error: Error?) in
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
        }*/
        Utilisateur.create(datasource: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        PictureUIImage.image = NewProfile.SharedInstance.uiImage
        pseudoUILabel.text = NewProfile.SharedInstance.pseudo
        catchPhraseUILabel.text = "\"\(NewProfile.SharedInstance.catchPhrase)\""
        descriptionUILabel.text = NewProfile.SharedInstance.description
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickNext(_ sender: RoundButtonUIButton) {
        performSegue(withIdentifier: "GoToInterets", sender: self)
    }
    
}
extension PreviewViewController:UtilisateurDataSource
{
    func utilisateurOnLoaded(utilisateur: Utilisateur) {
        print("PreviewViewController:UtilisateurDataSource:utilisateurOnLoaded - not implemented")
    }
    
    func utilisateurOnLoaded(matchs: ListeMatchingUtilisateurs) {
         print("PreviewViewController:UtilisateurDataSource:utilisateurOnLoaded - not implemented")
    }
    
    func utilisateurOnUpdated() {
         print("PreviewViewController:UtilisateurDataSource:utilisateurOnUpdated - not implemented")
    }
    
    func utilisateurOnDeleted() {
         print("PreviewViewController:UtilisateurDataSource:utilisateurOnDeleted - not implemented")
    }
    
    func utilisateurOnCreated() {
         print("PreviewViewController:UtilisateurDataSource:utilisateurOnCreated")
        print("Utilisateur bien créé")
    }
    
    func utilisateurOnNotFoundUtilisateur() {
         print("PreviewViewController:UtilisateurDataSource:utilisateurOnNotFoundUtilisateur - not implemented")
    }
    
    func utilisateurOnWebServiceError(code: Int) {
         print("PreviewViewController:UtilisateurDataSource:utilisateurOnWebServiceError - not implemented")
    }
    
    
}
