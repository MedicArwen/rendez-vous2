//
//  FavorisDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 13/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol FavorisDataSource {
    func favorisOnLoaded(ami:Favoris)
    func favorisOnLoaded(amis:ListeUtilisateursFavoris)
    func favorisOnDeleted()
    func favorisOnCreated(ami:Favoris)
    func favorisOnNotFoundFavoris()
    func favorisOnWebServiceError(code:Int)
}
