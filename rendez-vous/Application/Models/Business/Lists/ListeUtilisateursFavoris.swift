//
//  ListeFavoris.swift
//  rendez-vous
//
//  Created by Thierry BRU on 08/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListeUtilisateursFavoris
{
    static var sharedInstance : ListeUtilisateursFavoris?
    var liste = [Utilisateur]()
    
    init(json:JSON) {
        print("ListeUtilisateursFavoris:init")
        for jUtilisateur in json {
            self.liste.append(Utilisateur(json:jUtilisateur.1))
        }
    }
}
