//
//  RoundPortraitUIImageView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RoundPortraitUIImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
}
