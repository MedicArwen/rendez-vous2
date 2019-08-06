//
//  UtilisateurCrudable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol UtilisateurCrudable {
    static func create(datasource:UtilisateurDataSource)
    static func read(datasource:UtilisateurDataSource,idUtilisateur:Int)
    static func read(datasource:UtilisateurDataSource)
    func update(datasource:UtilisateurDataSource)
    func delete(datasource:UtilisateurDataSource)
}
