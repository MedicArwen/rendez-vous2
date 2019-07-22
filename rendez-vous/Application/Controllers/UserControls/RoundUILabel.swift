//
//  RoundUILabel.swift
//  rendez-vous
//
//  Created by Thierry BRU on 17/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RoundUILabel:UILabel
{
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
}
