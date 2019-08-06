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
    var liste = [CentreInteretUtilisateur]()
    
    init(json:JSON) {
        var i = 1
        for jCentreInteret in json {
            self.liste.append(CentreInteretUtilisateur(json:jCentreInteret.1,ordre:i))
            i += 1
        }
    }
}
