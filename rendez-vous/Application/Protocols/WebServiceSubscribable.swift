//
//  WebServiceSubscribable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 24/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
class WebServiceSubscribable {
   private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("inscription d'une vue...")
        self.suscribedViews.append(vue)
    }
    
    static func reloadViews()
    {
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }

}
