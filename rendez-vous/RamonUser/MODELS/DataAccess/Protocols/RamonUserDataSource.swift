//
//  RamonUserDataSource.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol RamonUserDataSource {
    func ramonUserOnLoaded(ramonUser:RamonUser)
    func ramonUserOnConnected(connectedRamonUser:ConnectedRamonUser)
    func ramonUserOnLoginError()
    func ramonUserOnUpdated()
    func ramonUserOnDeleted()
    func ramonUserOnCreated()
    func ramonUserOnNotFoundRamonUser()
    func ramonUserOnWebServiceError(code:Int)
}
