//
//  WebServiceUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON

class WebServiceUtilisateur:WebService
{
    private var dataSource:UtilisateurDataSource?
    init(commande:EnumCommandeWebService,entite:EnumEntityWebServiceTargeted,datasource:UtilisateurDataSource) {
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
                    self.dataSource!.utilisateurOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CREATE:
                            self.dataSource!.utilisateurOnCreated()
                        case .READ:
                            self.dataSource!.utilisateurOnLoaded(utilisateur: Utilisateur(json: json["data"]))
                        case .DELETE:
                            self.dataSource!.utilisateurOnDeleted()
                        case .UPDATE:
                            self.dataSource!.utilisateurOnUpdated()
                        case .CREDENTIALS:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .CANCEL:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .REJECT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .ACCEPT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .LIST:
                             self.dataSource!.utilisateurOnLoaded(matchs:ListeMatchingUtilisateurs(json: json["data"]))
                        }
                        
                    }
                    else
                    {
                        self.dataSource!.utilisateurOnNotFoundUtilisateur()
                    }
                    
                }
            }
        }
        
    }
    
}


