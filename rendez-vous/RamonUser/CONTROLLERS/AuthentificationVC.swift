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
    
      /*  RendezVousApplication.sharedInstance.connectedRamonUser = ConnectedRamonUser.connectUtilisateurDefault()
        RendezVousApplication.sharedInstance.connectedUtilisateur = Utilisateur.connectUtilisateurDefault()
        guard RendezVousApplication.sharedInstance.connectedRamonUser == nil else {
            print("RamonUser chargé depuis les préférences")
            guard RendezVousApplication.sharedInstance.connectedUtilisateur == nil else {
                print("Utilisateur chargé depuis les préférences")
                self.performSegue(withIdentifier: "GoToHomePage", sender: self)
                return
            }
            tryLoadProfile()
            return
        }
    */
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
        
      AuthWebService.sharedInstance.loginWithPassword { (json: JSON?, error: Error?) in
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
                    RendezVousApplication.sharedInstance.connectedRamonUser = ConnectedRamonUser(json: json["data"])
                    ConnectedRamonUser.saveUserConnected(connectedRamonUser: RendezVousApplication.sharedInstance.connectedRamonUser!)
                    if RendezVousApplication.sharedInstance.connectedRamonUser!.isEmailValide()
                    {
                      self.tryLoadProfile()
                    }
                    else
                    {
                        self.performSegue(withIdentifier: "goregister", sender: self)
                    }
                   
                }
            }
        }
    }

  func tryLoadProfile()
  {
    
    RendezVousApplication.sharedInstance.connectedRamonUser!.loadProfile { (json: JSON?, error: Error?) in
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
                if json["data"] != "null"
                {
                    RendezVousApplication.sharedInstance.connectedUtilisateur = Utilisateur(json: json["data"])
                    
                    self.performSegue(withIdentifier: "GoToHomePage", sender: self)
                }
                else
                {
                    self.performSegue(withIdentifier: "GoToCreateProfile", sender: self)
                }
                
            }
        }
    }
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
