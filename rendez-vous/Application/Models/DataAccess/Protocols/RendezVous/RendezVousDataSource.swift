//
//  RendezVousDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol RendezVousDataSource {
    func rendezVousOnLoaded(rendezVous:RendezVous)
    func rendezVousOnLoaded(lesRendezVous:ListeRendezVous)
    func rendezVousOnUpdated()
    func rendezVousOnDeleted()
    func rendezVousOnCancelled()
    func rendezVousOnCreated()
    func rendezVousOnNotFoundRendezVous()
    func rendezVousOnWebServiceError(code:Int)
}
