//
//  CentreInteretCrudable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation

protocol CentreInteretUtilisateurCrudable {
    func create(datasource:CentreInteretUtilisateurDataSource)
    static func read(datasource:CentreInteretUtilisateurDataSource,numUtilisateur:Int,numCentreInteret:Int)
    func update(datasource:CentreInteretUtilisateurDataSource)
    func delete(datasource:CentreInteretUtilisateurDataSource)
}
