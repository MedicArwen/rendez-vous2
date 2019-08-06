//
//  UtilisateurDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol UtilisateurDataSource {
    func utilisateurOnLoaded(utilisateur:Utilisateur)
    func utilisateurOnLoaded(matchs:ListeMatchingUtilisateurs)
    func utilisateurOnUpdated()
    func utilisateurOnDeleted()
    func utilisateurOnCreated()
    func utilisateurOnNotFoundUtilisateur()
    func utilisateurOnWebServiceError(code:Int)
}

