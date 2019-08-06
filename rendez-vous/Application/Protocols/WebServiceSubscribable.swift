//
//  WebServiceSubscribable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
// A implementer sur la classe qui défini l'objet statique aux mises à jour duquel les vues s'abonnent
import Foundation
protocol WebServiceSubscribable {
    static func subscribe(vue:WebServiceLinkable)
    static func unsuscribe(vue:WebServiceLinkable)
    static func reloadViews()
}
