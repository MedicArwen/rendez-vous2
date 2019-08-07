//
//  AuthentificationVC.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftHash
import CoreLocation

class AuthentificationVC: RamonViewController {
    @IBOutlet weak var emailUITextField: RamonUserUITextField!
    @IBOutlet weak var passwordUITextField: RamonUserUITextField!
    
    override func viewDidLoad() {
        
        self.codeController = "AuthentificationVC"
        LocationManager.SharedInstance.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("AuthentificationVC:viewWillAppear")
        ConnectedRamonUser.connectUtilisateurDefault()
        guard AuthWebService.sharedInstance.userName != nil else {
            print("username not found")
            return
        }
        guard AuthWebService.sharedInstance.password != nil else {
            print("pwd not found")
            return
        }
            tryConnect()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickLogin(_ sender: RamonUserUIButton) {
        AuthWebService.sharedInstance.userName = emailUITextField.text!
        AuthWebService.sharedInstance.password = MD5("\(passwordUITextField.text!)mercicaroleb20")
        tryConnect()
    }
    func tryConnect()
    {
        RamonUser.login(datasource: self, courriel: AuthWebService.sharedInstance.userName!, motdepasse: AuthWebService.sharedInstance.password!)
    /*  AuthWebService.sharedInstance.loginWithPassword { (json: JSON?, error: Error?) in
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
                    ConnectedRamonUser.sharedInstance = ConnectedRamonUser(json: json["data"])
                    ConnectedRamonUser.saveUserConnected(connectedRamonUser: ConnectedRamonUser.sharedInstance!)
                    if ConnectedRamonUser.sharedInstance!.isEmailValide()
                    {
                     Utilisateur.read(datasource: self)
                    }
                    else
                    {
                        self.performSegue(withIdentifier: "goregister", sender: self)
                    }
                   
                }
            }
        }*/
    }

}
extension AuthentificationVC:UITextFieldDelegate
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
        print("champ saisis:\(NewAccount.SharedInstance.nbChamps)")
        return true
    }
}
extension AuthentificationVC:CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("position found:\(locations[0])")
        NewProfile.SharedInstance.latitude = locations[0].coordinate.latitude
        NewProfile.SharedInstance.longitude = locations[0].coordinate.longitude
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            print("update changement autorisation")
        }
    }
}
extension AuthentificationVC:RamonUserDataSource
{
    func ramonUserOnConnected(connectedRamonUser: ConnectedRamonUser) {
         print("AuthentificationVC:RamonUserDataSource:ramonUserOnConnected")
        ConnectedRamonUser.sharedInstance = connectedRamonUser
        ConnectedRamonUser.saveUserConnected(connectedRamonUser: ConnectedRamonUser.sharedInstance!)
        if ConnectedRamonUser.sharedInstance!.isEmailValide()
        {
            Utilisateur.read(datasource: self,idRamonUser:ConnectedRamonUser.sharedInstance!.ramonUser.idRamonUser )
        }
        else
        {
            self.performSegue(withIdentifier: "goregister", sender: self)
        }
    }
    
    func ramonUserOnLoginError() {
         print("AuthentificationVC:RamonUserDataSource:ramonUserOnLoginError non implementé ")
    }
    
    func ramonUserOnLoaded(ramonUser: RamonUser) {
         print("AuthentificationVC:RamonUserDataSource:onUpdated non implementé ")
        
    }
    
    func ramonUserOnRegistered(ramonUser:RamonUser)
    {
        print("AuthentificationVC:RamonUserDataSource:ramonUserOnRegistered non implementé ")
    }
    func ramonUserOnMailAsked()
    {
        print("AuthentificationVC:RamonUserDataSource:ramonUserOnMailAsked non implementé ")
    }
    func ramonUserOnCodeChecked()
    {print("AuthentificationVC:RamonUserDataSource:ramonUserOnCodeChecked non implementé ")
        
    }
    func ramonUserOnUpdated() {
        print("AuthentificationVC:RamonUserDataSource:onUpdated non implementé ")
    }
    
    func ramonUserOnDeleted() {
        print("AuthentificationVC:RamonUserDataSource:ramonUserOnDeleted non implementé ")
    }
    
    func ramonUserOnCreated() {
        print("AuthentificationVC:RamonUserDataSource:ramonUserOnCreated non implementé ")
    }
    
    func ramonUserOnNotFoundRamonUser() {
        print("AuthentificationVC:RamonUserDataSource:ramonUserOnNotFoundRamonUser non implementé ")
    }
    
    func ramonUserOnWebServiceError(code: Int) {
        print("AuthentificationVC:RamonUserDataSource:ramonUserOnWebServiceError non implementé ")
    }
    
    
}
extension AuthentificationVC:UtilisateurDataSource
{
    func utilisateurOnUpdated() {
        print("AuthentificationVC:UtilisateurDataSource:onUpdated non implementé ")
    }
    
    func utilisateurOnDeleted() {
        print("AuthentificationVC:UtilisateurDataSource:onDeleted non implementé ")
    }
    
    func utilisateurOnCreated() {
        print("AuthentificationVC:UtilisateurDataSource:onCreated non implementé ")
    }
    
    func  utilisateurOnLoaded(utilisateur: Utilisateur) {

        if  utilisateur.idUtilisateur == 0
        {
            self.performSegue(withIdentifier: "GoToCreateProfile", sender: self)
        }
        else
        {
            Utilisateur.sharedInstance = utilisateur
            self.performSegue(withIdentifier: "GoToHomePage", sender: self)
        }
        
    }
    func  utilisateurOnLoaded(matchs:ListeMatchingUtilisateurs) {
        print("AuthentificationVC:UtilisateurDataSource:utilisateurOnLoaded(list) non implementé ")
    }
    func utilisateurOnNotFoundUtilisateur() {
         self.performSegue(withIdentifier: "GoToCreateProfile", sender: self)
    }
    
    func utilisateurOnWebServiceError(code: Int) {
        AuthWebService.sendAlertMessage(vc: self, returnCode: code)
    }
}
