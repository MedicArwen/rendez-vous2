//
//  RegisterVC.swift
//  rendez-vous
//
//  Created by Thierry BRU on 28/06/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftHash
import Alamofire

class RegisterVC: RamonViewController {
    var currentStep = 1
    var requiredChamps = 0
// champs du formulaire
    
    @IBOutlet weak var emailUITextField: RamonUserUITextField!
    @IBOutlet weak var passwordUITextField: RamonUserUITextField!
    @IBOutlet weak var repeatPasswordUITextField: RamonUserUITextField!
    
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordShortLabel: UILabel!
    @IBOutlet weak var errorPasswordCapitalLabel: UILabel!
    @IBOutlet weak var errorPasswordSpecialLabel: UILabel!
    @IBOutlet weak var errorRepeatPassword: UILabel!
    @IBOutlet weak var errorPasswordNumberLabel: UILabel!
    
    
    @IBOutlet weak var pseudonymeUITextField: RamonUserUITextField!
    @IBOutlet weak var firstNameUITextField: RamonUserUITextField!
    @IBOutlet weak var lastNameUITextField: RamonUserUITextField!
    
    
    @IBOutlet weak var birthDayUIDatePicker: UIDatePicker!
    @IBOutlet weak var genderUISegmentedControl: UISegmentedControl!
   
    @IBOutlet weak var viewContentDate: UIView!
    
    
    @IBOutlet weak var validationEmailCode: RamonUserUITextField!
    
    @IBOutlet weak var backNextUIStackView: UIStackView!
    @IBOutlet weak var confirmationMailUIStackView: UIStackView!
    
    
    
    @IBOutlet weak var cancelButton: RamonUserUIButton!
    @IBOutlet weak var buttonBack: RamonUserUIButton!
    @IBOutlet weak var buttonNext: RamonUserUIButton!
    
    
    
    
    override func viewDidLoad() {
        self.codeController = "RegisterVC"
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailUITextField.delegate = self
        passwordUITextField.delegate = self
        repeatPasswordUITextField.delegate = self
        pseudonymeUITextField.delegate = self
        firstNameUITextField.delegate = self
        lastNameUITextField.delegate = self
        validationEmailCode.delegate = self
        if AuthWebService.sharedInstance.ramonUser != nil
        {
            currentStep = 4
            emailUITextField.isHidden = true
            passwordUITextField.isHidden = true
            repeatPasswordUITextField.isHidden = true
            self.askEmail()
        }
        passwordUITextField.textContentType = .password
        passwordUITextField.isSecureTextEntry = true
        passwordUITextField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper;required: lower, required: [-().&@?'#,/&quot;+] ; minlength: 6;")
    }
    override func viewWillAppear(_ animated: Bool) {
        changeStepShow()
        
    }
    private func checkForm() -> Bool
    {
        
        if (emailUITextField.isHidden == false)&&(!emailUITextField.checkTextField())
        {
            errorEmailLabel.isHidden = false
            return false
        }
        else
        {
            errorEmailLabel.isHidden = true
        }
        if (passwordUITextField.isHidden == false)&&(!passwordUITextField.checkTextField())
        {
        switch passwordUITextField.isValidPassword()
        {
            case 1: errorPasswordShortLabel.isHidden = false
                    errorPasswordCapitalLabel.isHidden = true
                    errorPasswordSpecialLabel.isHidden = true
                    errorPasswordNumberLabel.isHidden = true
            
        case 2: errorPasswordShortLabel.isHidden = true
        errorPasswordCapitalLabel.isHidden = false
        errorPasswordSpecialLabel.isHidden = true
        errorPasswordNumberLabel.isHidden = true
            
        case 4: errorPasswordShortLabel.isHidden = true
        errorPasswordCapitalLabel.isHidden = true
        errorPasswordSpecialLabel.isHidden = false
        errorPasswordNumberLabel.isHidden = true
        
        case 5: errorPasswordShortLabel.isHidden = true
        errorPasswordCapitalLabel.isHidden = true
        errorPasswordSpecialLabel.isHidden = true
        errorPasswordNumberLabel.isHidden = false
            
        default:
                errorPasswordShortLabel.isHidden = true
                errorPasswordCapitalLabel.isHidden = true
                errorPasswordSpecialLabel.isHidden = true
                errorPasswordNumberLabel.isHidden = true
            }
            return false
        }
        else{
            errorPasswordShortLabel.isHidden = true
            errorPasswordCapitalLabel.isHidden = true
            errorPasswordSpecialLabel.isHidden = true
            errorPasswordNumberLabel.isHidden = true
        }
        
        if (repeatPasswordUITextField.isHidden == false)&&(!repeatPasswordUITextField.checkTextField())
        {
            errorRepeatPassword.isHidden = false
            return false
        }
        else
        {
            errorRepeatPassword.isHidden = true
        }
        if (pseudonymeUITextField.isHidden == false)&&(!pseudonymeUITextField.checkTextField())
        {
            return false
        }
        if (firstNameUITextField.isHidden == false)&&(!firstNameUITextField.checkTextField())
        {
            return false
        }
        if (lastNameUITextField.isHidden == false)&&(!lastNameUITextField.checkTextField())
        {
            return false
        }
        if (validationEmailCode.isHidden == false)&&(!validationEmailCode.checkTextField())
        {
            return false
        }
        return true
        
    }
    private func changeStepShow()
{
    print("etape: \(self.currentStep)")
        switch (self.currentStep)
        {
        case 1:
            cancelButton.isHidden = false
            emailUITextField.isHidden = false
            passwordUITextField.isHidden = false
            repeatPasswordUITextField.isHidden = false
            
            buttonBack.isHidden = true
            pseudonymeUITextField.isHidden = true
            firstNameUITextField.isHidden = true
            lastNameUITextField.isHidden = true
            requiredChamps = 3
            
        case 2:
            cancelButton.isHidden = true
            emailUITextField.isHidden = true
            passwordUITextField.isHidden = true
            repeatPasswordUITextField.isHidden = true
            
            pseudonymeUITextField.isHidden = false
            firstNameUITextField.isHidden = false
            lastNameUITextField.isHidden = false
            buttonBack.isHidden =  false
            backNextUIStackView.isHidden = false
            
            birthDayUIDatePicker.isHidden = true
            genderUISegmentedControl.isHidden = true
            requiredChamps = 6

            
        case 3:
            
            pseudonymeUITextField.isHidden = true
            firstNameUITextField.isHidden = true
            lastNameUITextField.isHidden = true
            
            birthDayUIDatePicker.isHidden = false
            genderUISegmentedControl.isHidden = false
            backNextUIStackView.isHidden = false
            
            validationEmailCode.isHidden = true
            confirmationMailUIStackView.isHidden = true
            requiredChamps = 6

        case 4:
            birthDayUIDatePicker.isHidden = true
            genderUISegmentedControl.isHidden = true
            
            backNextUIStackView.isHidden = true
            
            self.validationEmailCode.isHidden = false
            self.confirmationMailUIStackView.isHidden = false
            requiredChamps = 7
        default:
            performSegue(withIdentifier: "goFinish", sender: self)
        }
viewContentDate.isHidden = birthDayUIDatePicker.isHidden
    self.buttonNext.isEnabled =  checkForm()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClickBack(_ sender: RamonUserUIButton) {
        if self.currentStep > 1
        {
            self.currentStep -= 1
            changeStepShow()
        }
    }
    
    @IBAction func onClickNext(_ sender: RamonUserUIButton) {
        if self.currentStep == 3
        {
            tryRegister()
        }
        if self.currentStep < 6
        {
            currentStep += 1
            changeStepShow()
        }
    }
      
    
    @IBAction func onClickRequestCode(_ sender: RamonUserUIButton) {
    }
  
    @IBAction func onClickValidate(_ sender: RamonUserUIButton) {
        checkEmail()
        
    }
    
 
    func tryRegister()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: birthDayUIDatePicker.date)
        
        AuthWebService.sharedInstance.ramonUser = RamonUser(idRamonUser: 0, courriel: emailUITextField.text!, motdepasse: MD5("\(passwordUITextField.text!)mercicaroleb20"), dateNaissance: date, pseudonyme: pseudonymeUITextField.text!, prenom: firstNameUITextField.text!, nom: lastNameUITextField.text!, codeValidation: "", estCompteValide: 0, numGenre: genderUISegmentedControl.selectedSegmentIndex + 1)
        
        AuthWebService.sharedInstance.register { (json: JSON?, error: Error?) in
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
                    AuthWebService.sharedInstance.ramonUser = RamonUser(ramonUserJson: json["data"])
                     self.askEmail()
                    
                }
            }
        }
    }
    //askValidationCode
    func askEmail()
    {
        AuthWebService.sharedInstance.askValidationCode { (json: JSON?, error: Error?) in
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
                    AuthWebService.sendAlertMessage(vc: self, returnCode: 1)
                }
            }
        }
    }
    func checkEmail()
    {
        AuthWebService.sharedInstance.checkValidationCode { (json: JSON?, error: Error?) in
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
                    self.currentStep += 1
                    self.changeStepShow()
                }
            }
        }
    }
}
extension RegisterVC:UITextFieldDelegate
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
        self.buttonNext.isEnabled =  checkForm()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailUITextField:
            passwordUITextField.becomeFirstResponder()
        case passwordUITextField:
            repeatPasswordUITextField.becomeFirstResponder()
        case repeatPasswordUITextField:
            firstNameUITextField.becomeFirstResponder()
        case firstNameUITextField:
            lastNameUITextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }

}
