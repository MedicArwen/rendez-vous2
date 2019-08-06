//
//  CentreInteretDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol CentreInteretUtilisateurDataSource {
    func centreInteretUtilisateurOnLoaded(centreInteret:CentreInteretUtilisateur)
    func centreInteretUtilisateurOnLoaded(centresInterets:ListeCentreInteretUtilisateur)
    func centreInteretUtilisateurOnUpdated()
    func centreInteretUtilisateurOnDeleted()
    func centreInteretUtilisateurOnCreated()
    func centreInteretUtilisateurOnNotFoundCentreInteret()
    func centreInteretUtilisateurOnWebServiceError(code:Int)
}
