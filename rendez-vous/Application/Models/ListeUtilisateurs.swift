//
//  ListeUtilisateurs.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListeUtilisateurs
{
    var liste = [Utilisateur]()
    init(json:JSON) {
        for jUtilisateur in json {
            self.liste.append(Utilisateur(json:jUtilisateur.1))
        }
    }
}
