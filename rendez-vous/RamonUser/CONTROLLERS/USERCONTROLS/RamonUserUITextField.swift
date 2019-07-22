//
//  RamonUser.swift
//  rendez-vous
//
//  Created by Thierry BRU on 28/06/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
@IBDesignable
class RamonUserUITextField: UITextField
{
@IBInspectable
var bgColor : UIColor?
{
    get {
        return self.backgroundColor
    }
    set {
        self.backgroundColor = newValue
    }
}
@IBInspectable
var txtColor: UIColor?
{
    get {
        return self.textColor
    }
    set {
        self.textColor = newValue
    }
}
@IBInspectable
var borderWidth: CGFloat
{
    get {
        return self.layer.borderWidth
    }
    set {
        self.layer.borderWidth = newValue
    }
}
    
@IBInspectable
var borderColor: UIColor
{
    get {
        return UIColor(cgColor:self.layer.borderColor!)
    }
    set {
        self.layer.borderColor = newValue.cgColor
    }
}
    
@IBInspectable
var cornerRadius: CGFloat
{
    get {
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
    }
}
private var typeDataAttendu: String = ""

@IBInspectable
var typeSaisie:String
{
    get { return self.typeDataAttendu}
    set {
        self.typeDataAttendu = newValue
    }
}

/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */
    func isValidPassword() -> Int {
        return RegExp.checkPasswordComplexity(password: NewAccount.SharedInstance.motdepasse, length: 5, patternsToEscape: ["soleil"], caseSensitivty: true, numericDigits: true)
    }
    
    func checkTextField()->Bool
{
    switch typeSaisie {
    case "pseudonyme": NewAccount.SharedInstance.pseudonyme = self.text!
    if self.text!.count > 2
    {return true}
    case "motdepasse": NewAccount.SharedInstance.motdepasse = self.text!
    if self.text!.count > 5 && isValidPassword() == 0// 6 char dont une maj et un caractere special
    {return true}
    case "repeat": NewAccount.SharedInstance.repeterMotdepasse = self.text!
    if self.text! == NewAccount.SharedInstance.motdepasse && self.text!.count > 0
    {return true}
    case "nom": NewAccount.SharedInstance.nom = self.text!
    if self.text!.count > 0
    {return true}
    case "prenom": NewAccount.SharedInstance.prenom = self.text!
    if self.text!.count > 0
    {return true}
    case "courriel": NewAccount.SharedInstance.courriel = self.text! //email valide
    if self.text!.count > 5 && isValidEmail(emailID:NewAccount.SharedInstance.courriel)
    {return true}
    case "code": NewAccount.SharedInstance.codeValidation = self.text!
    if self.text!.count == 6
    {return true}
    default:
        return false
    }
    return false
}
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    func setIcon(validity:Bool)
    {
        var urlImage = ""
        if validity
        {
            urlImage = "iconTextFieldOK"
        }
        else
        {
            urlImage = "iconTextFieldKO"
        }
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let icone = UIImage(imageLiteralResourceName: urlImage)
        image.image = icone
        self.rightView = image
        self.rightViewMode = UITextField.ViewMode.always
    }
  
}

