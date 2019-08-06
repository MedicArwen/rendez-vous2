//
//  WebServiceLinkable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
// A implémenter sur la vue qui affiche l'objet statique devant être abonnée aux changements sur celui-ci
import Foundation
protocol WebServiceLinkable {
    func refresh()
    var indice: Int { get set}
}
