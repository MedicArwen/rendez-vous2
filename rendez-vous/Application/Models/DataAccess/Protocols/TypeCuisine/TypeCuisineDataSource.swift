//
//  TypeCuisineDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol TypeCuisineDataSource {
    func typeCuisineOnLoaded(typeCuisines:ListeTypeCuisine)
    func typeCuisineOnLoaded(typeCuisine:TypeCuisine)
    func typeCuisineOnNotFoundTypeCuisine()
    func typeCuisineOnWebServiceError(code:Int)
}
