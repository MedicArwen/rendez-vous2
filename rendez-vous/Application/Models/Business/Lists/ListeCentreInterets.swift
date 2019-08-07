//
//  ListeCentreInterets.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListeCentreInterets
{
    static var sharedInstance : ListeCentreInterets?
    var liste = [CentreInteret]()
    
    init(json:JSON) {
        
        for jCentreInteret in json {
            self.liste.append(CentreInteret(json:jCentreInteret.1))
        }
    }
    func returnListDefaut()->[CentreInteretUtilisateur]
    {
        var liste =  [CentreInteretUtilisateur]()
        var i = 1
        for item in self.liste {
            liste.append(CentreInteretUtilisateur(id: item.id, libelle: item.libelle, order: i))
            i += 1
        }
        return liste
    }
}
