
//
//  WebServiceTypeCuisineUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON

class WebServiceTypeCuisineUtilisateur:WebService
{
    private var dataSource:TypeCuisineUtilisateurDataSource?
    init(commande:EnumCommandeWebService,entite:EnumEntityWebServiceTargeted,datasource:TypeCuisineUtilisateurDataSource) {
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
                    self.dataSource!.typeCuisineUtilisateurOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CREATE:
                            self.dataSource!.typeCuisineUtilisateurOnCreated()
                        case .READ:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .DELETE:
                           print("commande non gérée: \(String(describing: self.commande))")
                        case .UPDATE:
                           print("commande non gérée: \(String(describing: self.commande))")
                        case .CREDENTIALS:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .CANCEL:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .REJECT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .ACCEPT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .LIST:
                            self.dataSource!.typeCuisineUtilisateurOnLoaded(typeCuisines: ListeTypeCuisineUtilisateur(json: json["data"]))
                        }
                        
                    }
                    else
                    {
                        self.dataSource!.typeCuisineUtilisateurOnNotFoundTypeCuisine()
                    }
                    
                }
            }
        }
        
    }
    
}
