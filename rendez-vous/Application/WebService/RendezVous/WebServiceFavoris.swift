//
//  WebServiceFavoris.swift
//  rendez-vous
//
//  Created by Thierry BRU on 13/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON

class WebServiceFavoris:WebService
{
    private var dataSource:FavorisDataSource?
    
    init(commande:EnumCommandeWebService,entite:EnumEntityWebServiceTargeted,datasource:FavorisDataSource) {
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
                    self.dataSource!.favorisOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CREATE:
                            self.dataSource!.favorisOnCreated(ami: Favoris(json: json["data"]))
                        case .READ:
                            self.dataSource!.favorisOnLoaded(ami: Favoris(json: json["data"]))
                        case .DELETE:
                            self.dataSource!.favorisOnDeleted()
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
                            self.dataSource!.favorisOnLoaded(amis: ListeUtilisateursFavoris(json: json["data"]))
                            
                        }
                        
                    }
                    else
                    {
                        self.dataSource!.favorisOnNotFoundFavoris()
                    }
                    
                }
            }
        }
        
    }
    
}


