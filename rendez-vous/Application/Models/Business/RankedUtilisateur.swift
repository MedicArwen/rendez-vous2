//
//  RankedUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON


class RankedUtilisateur: Utilisateur {
    var ranking: Double?
    init(json:JSON) {
        print("RankedUtilisateur:init")
        //super.init(json: json["Utilisateur"])
       //
        super.init(idUtilisateur:json["Utilisateur"]["idUtilisateur"].intValue,
                  numRamonUser:json["Utilisateur"]["libelle"].intValue,
                  urlImage:json["Utilisateur"]["urlPhoto"].stringValue,
                  catchPhrase:json["Utilisateur"]["catchPhrase"].stringValue,
                  description:json["Utilisateur"]["description"].stringValue,
                  pseudo:json["Utilisateur"]["pseudonyme"].stringValue,
                  latitude:json["Utilisateur"]["latitude"].doubleValue,
                  longitude:json["Utilisateur"]["longitude"].doubleValue)
        ranking = json["Utilisateur"]["Score"].doubleValue
    }
    
}

