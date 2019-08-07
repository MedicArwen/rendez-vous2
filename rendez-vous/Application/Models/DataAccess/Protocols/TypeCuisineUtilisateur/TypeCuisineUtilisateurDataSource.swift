//
//  TypeCuisineUtilisateurDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol TypeCuisineUtilisateurDataSource {
    func typeCuisineUtilisateurOnLoaded(typeCuisines:ListeTypeCuisineUtilisateur)
    func typeCuisineUtilisateurOnUpdated()
    func typeCuisineUtilisateurOnCreated()
    func typeCuisineUtilisateurOnNotFoundTypeCuisine()
    func typeCuisineUtilisateurOnWebServiceError(code:Int)
}
