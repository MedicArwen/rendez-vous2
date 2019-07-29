//
//  WebServiceListable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation

protocol WebServiceListable
{
    static func load(controleur: RamonViewController)
    static func remove(controleur:RamonViewController,indexPath:IndexPath)
    static func remove(controleur:RamonViewController,item:Any)
    static func append(controleur:RamonViewController,item:Any)
}
