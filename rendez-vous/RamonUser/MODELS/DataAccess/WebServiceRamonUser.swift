
//
//  WebServiceRamonUser.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftHash

class WebServiceRamonUser:WebService
{
    private var dataSource:RamonUserDataSource?
    init(commande:EnumCommandeWebService,entite:EnumEntityWebServiceTargeted,datasource:RamonUserDataSource) {
        super.init(commande:commande,cible:entite)
        self.dataSource = datasource
        generateDefaultParams()

    }
    func callWebService(_ completion: @escaping ServiceResponse)
    {
        print(AuthWebService.sharedInstance.webServiceCalling(self.getHttpParams(), completion))
    }
    func execute()
    {
        guard dataSource != nil else {
            return
        }
        generateSignature()
        prepareExecution()
        callWebService{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    self.dataSource!.ramonUserOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CREATE:
                            self.dataSource!.ramonUserOnCreated()
                        case .READ:
                            self.dataSource!.ramonUserOnLoaded(ramonUser: RamonUser(ramonUserJson: json["data"]))
                        case .CREDENTIALS:
                            self.dataSource!.ramonUserOnConnected(connectedRamonUser:ConnectedRamonUser(json: json["data"]))
                        case .DELETE:
                            self.dataSource!.ramonUserOnDeleted()
                        case .UPDATE:
                            self.dataSource!.ramonUserOnUpdated()
                        case .CANCEL:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .REJECT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .ACCEPT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .LIST:
                            print("commande non gérée: \(String(describing: self.commande))")
                        }
                    }
                    else
                    {
                        self.dataSource!.ramonUserOnNotFoundRamonUser()
                    }
                    
                }
            }
        }
        
    }
  
}
