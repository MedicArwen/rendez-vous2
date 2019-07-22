//
//  CatchPhraseViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class CatchPhraseViewController: UIViewController {

    @IBOutlet weak var pseudoLabel: UILabel!
    
    @IBOutlet weak var catchPhraseUITextField: UITextField!
    
    @IBOutlet weak var buttonNext: RoundButtonUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catchPhraseUITextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        pseudoLabel.text = NewProfile.SharedInstance.pseudo
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
        NewProfile.SharedInstance.catchPhrase = catchPhraseUITextField.text!
        performSegue(withIdentifier: "GoToPreview", sender: self)
    }
}
extension CatchPhraseViewController:UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
  
            let txtField = textField as! RamonUITextField
                if ((textField.text?.count)! + (string.count - range.length)) > txtField.maxLength {
                    print("le texte saisi est trop long")
                    return false
                }
                

            return true
        }
    
}
