//
//  RamonUITextField.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RamonUITextField: UITextField {


    private var maxLengths:Int = 0

    
    @IBInspectable var maxLength: Int {
        get {
                return maxLengths
            }
        
        set {
            maxLengths = newValue
        }
    }
    
}
