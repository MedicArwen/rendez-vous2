//
//  CentreInteretDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation

protocol CentreInteretDataSource {
    func centreInteretOnLoaded(centresInterets:ListeCentreInterets)
    func centreInteretOnLoaded(centreInteret:CentreInteret)
    func centreInteretOnNotFoundCentreInteret()
    func centreInteretOnWebServiceError(code:Int)
}
