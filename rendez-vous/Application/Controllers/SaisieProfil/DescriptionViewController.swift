//
//  DescriptionViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var descriptionUITextView: UITextView!
    
    @IBOutlet weak var buttonNext: RoundButtonUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        NewProfile.SharedInstance.description = descriptionUITextView.text!
        performSegue(withIdentifier: "GoToCatchPhrase", sender: self)
    }
}
extension DescriptionViewController:UITextViewDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

    let txtField = textView  as! RamonUITextView
        if ((textView.text?.count)! + (text.count - range.length)) > txtField.maxLength {
            print("le texte saisi est trop long")
            return false
        }
        
        
        return true
    }
}
