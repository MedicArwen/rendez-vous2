//
//  RamonUserCrudable.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
protocol RamonUserCrudable {
    func create(datasource:RamonUserDataSource)
    static func read(datasource:RamonUserDataSource)
    static func read(datasource:RamonUserDataSource,idRamonUser:Int)
    func update(datasource:RamonUserDataSource)
    func delete(datasource:RamonUserDataSource)
    static func login(datasource:RamonUserDataSource,courriel:String,motdepasse:String)
}
