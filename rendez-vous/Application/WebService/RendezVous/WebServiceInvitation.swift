//
//  WebServiceInvitation.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON

class WebServiceInvitation:WebService
{
    private var dataSource:InvitationDataSource?
    
    init(commande:EnumCommandeWebService,entite:EnumEntityWebServiceTargeted,datasource:InvitationDataSource) {
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
                    self.dataSource!.invitationOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CREATE:
                            self.dataSource!.invitationOnCreated()
                        case .READ:
                            self.dataSource!.invitationOnLoaded(invitation: Invitation(jsonInvitation: json["data"]["Invitation"], jsonUtilisateur: json["data"]["Utilisateur"],jsonRendezVous: json["data"]["Rendez-Vous"]))
                        case .DELETE:
                            self.dataSource!.invitationOnDeleted()
                        case .UPDATE:
                            self.dataSource!.invitationOnUpdated()
                        case .CREDENTIALS:
                            print("commande non gérée: \(String(describing: self.commande))")
                        case .CANCEL:
                            self.dataSource!.invitationOnCancelled()
                        case .REJECT:
                           self.dataSource!.invitationOnRejected()
                        case .ACCEPT:
                            self.dataSource!.invitationOnAccepted()
                        case .LIST:
                            self.dataSource!.invitationOnLoaded(invitations: ListeInvitationsAsConvive(json: json["data"]))
                            
                        }
                        
                    }
                    else
                    {
                        self.dataSource!.invitationOnNotFoundInvitation()
                    }
                    
                }
            }
        }
        
    }
    
}


