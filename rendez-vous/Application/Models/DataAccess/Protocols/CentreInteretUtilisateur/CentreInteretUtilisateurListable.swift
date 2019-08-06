//
//  CentreInteretListable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import Foundation

protocol CentreInteretUtilisateurListable {
    static func load(datasource:CentreInteretUtilisateurDataSource)
    static func loadDefault(datasource:CentreInteretUtilisateurDataSource)
}
