//
//  WebServiceCentreInteretUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON

class WebServiceCentreInteretUtilisateur:WebService
{
    private var dataSource:CentreInteretUtilisateurDataSource?
    init(commande:EnumCommandeWebService,entite:EnumEntityWebServiceTargeted,datasource:CentreInteretUtilisateurDataSource) {
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
                    self.dataSource!.centreInteretUtilisateurOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CREATE:
                            self.dataSource!.centreInteretUtilisateurOnCreated()
                        case .READ:
                            print("web service a implanter en vrai")
                            self.dataSource!.centreInteretUtilisateurOnLoaded(centreInteret: CentreInteretUtilisateur(json: json["data"]))
                            print("web service a implanter en vrai")
                        case .DELETE:
                            self.dataSource!.centreInteretUtilisateurOnDeleted()
                        case .UPDATE:
                            self.dataSource!.centreInteretUtilisateurOnUpdated()
                        case .CREDENTIALS:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .CANCEL:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .REJECT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .ACCEPT:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .LIST:
                            self.dataSource!.centreInteretUtilisateurOnLoaded(centresInterets: ListeCentreInteretUtilisateur(json: json["data"]))
                        }
                        
                    }
                    else
                    {
                        self.dataSource!.centreInteretUtilisateurOnNotFoundCentreInteret()
                    }
                    
                }
            }
        }
        
    }
    
}
