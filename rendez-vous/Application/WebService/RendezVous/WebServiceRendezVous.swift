//
//  WebServiceRendezVous.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON

class WebServiceRendezVous:WebService
{
    private var dataSource:RendezVousDataSource?
    init(commande:EnumCommandeWebService,entite:EnumEntityWebServiceTargeted,datasource:RendezVousDataSource) {
        super.init(commande:commande,cible:entite)
        self.dataSource = datasource
        generateDefaultParams()
    }
    func callWebService(_ completion: @escaping ServiceResponse)
    {
        print(RendezVousWebService.sharedInstance.webServiceCalling(self.getHttpParams(), completion))
    }
    func execute()
    {
        guard dataSource != nil else {
            return
        }
        generateSignature()
        prepareExecution()
        callWebService { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    self.dataSource!.rendezVousOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CREATE:
                            self.dataSource!.rendezVousOnCreated()
                        case .READ:
                            self.dataSource!.rendezVousOnLoaded(rendezVous: RendezVous(jRendezVous:json["data"]["Rendez-Vous"],jHote:json["data"]["Hote"],jRestau: json["data"]["Restaurant"]))
                           
                        case .DELETE:
                            self.dataSource!.rendezVousOnDeleted()
                        case .UPDATE:
                            self.dataSource!.rendezVousOnUpdated()
                        case .CREDENTIALS:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .CANCEL:
                            self.dataSource!.rendezVousOnCancelled()
                        case .REJECT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .ACCEPT:
                           print("commande non gérée: \(String(describing: self.commande))")
                        case .LIST:
                            self.dataSource!.rendezVousOnLoaded(lesRendezVous: ListeRendezVous(json: json["data"]))
                        }
                        
                    }
                    else
                    {
                        self.dataSource!.rendezVousOnNotFoundRendezVous()
                    }
                    
                }
            }
        }
        
    }
    
}


