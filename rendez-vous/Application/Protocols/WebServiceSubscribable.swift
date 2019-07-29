//
//  WebServiceSubscribable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol WebServiceSubscribable {
    static func subscribe(vue:WebServiceLinkable)
    static func reloadViews()
}
