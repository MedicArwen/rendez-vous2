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
    override init(json:JSON) {
        print("RankedUtilisateur:init")
        super.init(json: json["Utilisateur"])
        ranking = json["Score"].doubleValue
    }
}
