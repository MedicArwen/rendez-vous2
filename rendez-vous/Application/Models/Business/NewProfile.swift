//
//  NewProfile.swift
//  rendez-vous
//
//  Created by Thierry BRU on 09/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import UIKit
import SwiftHash

class NewProfile
{
    static var SharedInstance = NewProfile()
    var urlImage = ""
    var uiImage : UIImage?
    var catchPhrase = ""
    var description = ""
    //var centresInterets = ListeCentreInteretUtilisateur()
   // var typeCuisines = ListeTypeCuisineUtilisateur()
    var pseudo = ""
    var latitude = 0.0
    var longitude = 0.0
}
