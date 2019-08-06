//
//  EditProfileViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 31/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class EditProfileViewController: RamonViewController {

    @IBOutlet weak var pseudonymeTextField: RamonUITextField!
    
    @IBOutlet weak var catchPhraseTextField: RamonUITextField!
    
    @IBOutlet weak var descriptionTextViews: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.catchPhraseTextField.text = Utilisateur.sharedInstance!.catchPhrase.removingPercentEncoding!
        self.pseudonymeTextField.text = Utilisateur.sharedInstance!.pseudo.removingPercentEncoding!
        self.descriptionTextViews.text = Utilisateur.sharedInstance!.description.removingPercentEncoding!
    }
    
    @IBAction func onClickClose(_ sender: RoundButtonUIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickSave(_ sender: RoundButtonUIButton) {
        Utilisateur.sharedInstance!.catchPhrase = self.catchPhraseTextField.text!
        Utilisateur.sharedInstance!.pseudo = self.pseudonymeTextField.text!
        Utilisateur.sharedInstance!.description = self.descriptionTextViews.text!
        Utilisateur.sharedInstance!.update(datasource: self)
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
extension EditProfileViewController:UtilisateurDataSource
{
    func utilisateurOnLoaded(utilisateur: Utilisateur) {
        print("EditProfileViewController:utilisateurOnLoaded:utilisateurOnLoaded non implementé ")
    }
    func utilisateurOnLoaded(matchs: ListeMatchingUtilisateurs) {
        print("FicheMonShortProfilView:UtilisateurDataSource:utilisateurOnLoaded (LIST) non impmlemùente")
    }
    func utilisateurOnUpdated() {
        print("EditProfileViewController:UtilisateurDataSource:utilisateurOnUpdated ")
        self.dismiss(animated: true, completion: nil)
    }
    
    func utilisateurOnDeleted() {
        print("EditProfileViewController:UtilisateurDataSource:utilisateurOnDeleted non implementé ")
    }
    
    func utilisateurOnCreated() {
        print("EditProfileViewController:UtilisateurDataSource:utilisateurOnCreated non implementé ")
    }
    
    func utilisateurOnNotFoundUtilisateur() {
        print("EditProfileViewController:UtilisateurDataSource:utilisateurOnNotFoundUtilisateur non implementé ")
    }
    
    func utilisateurOnWebServiceError(code: Int) {
        AuthWebService.sendAlertMessage(vc: self, returnCode: code)
    }
    
    
}
extension EditProfileViewController:UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        let saisie = textField as! RamonUserUITextField
        
        // iconCheckUserName.isHidden = !saisie.checkTextField()UIButton* overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saisie.setIcon(validity: saisie.checkTextField())
        print("verification de: \(saisie.typeSaisie)")
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case pseudonymeTextField:
            catchPhraseTextField.becomeFirstResponder()
        case catchPhraseTextField:
            descriptionTextViews.becomeFirstResponder()
        case descriptionTextViews:
            pseudonymeTextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
}
