
//
//  Invitation.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHash

class Invitation{

    var numStatusInvitation:Int
    var utilisateur:Utilisateur
    var rendezVous:RendezVous
    
    init(utilisateur:Utilisateur,rendezVous:RendezVous,numStatusInvitation:Int) {
        print("Invitation:init")
        print("-> l'utilisateur \(utilisateur.pseudo)[\(utilisateur.idUtilisateur)] a ete invite au rendez-vous [\(rendezVous.idRendezVous)]")
        print("-> status de l'invitation: [\(numStatusInvitation)]")
        self.numStatusInvitation = numStatusInvitation
        self.utilisateur = utilisateur
        self.rendezVous = rendezVous
    }
    convenience init(jsonInvitation:JSON,jsonUtilisateur:JSON,jsonRendezVous:JSON) {
        self.init(utilisateur: Utilisateur(json: jsonUtilisateur),rendezVous: RendezVous(jRendezVous: jsonRendezVous["Rendez-Vous"], jHote: jsonRendezVous["Hote"], jRestau: jsonRendezVous["Restaurant"]),numStatusInvitation:jsonInvitation["numStatusInvitation"].intValue)
    }
    func getInviteID()->Int
    {
        return utilisateur.idUtilisateur
    }
    func getRendezVousID()->Int
    {
        return rendezVous.idRendezVous
    }
 
    func getStatusSymbol()->String
    {
        print("Invitation:getStatusSymbol")
        switch self.numStatusInvitation {
        case 1:
            return "?"
        case 2:
            return "A"
        case 3:
            return "X"
        default:
            return ""
        }
    }
}
extension Invitation:InvitationCrudable
{
    func reject(datasource: InvitationDataSource) {
         self.numStatusInvitation = 3
        let webservice = WebServiceInvitation(commande: .REJECT, entite: .Utilisateur_RendezVous, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "numInvite", valeur: "\(self.getInviteID())"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numRendezVous", valeur: "\(self.getRendezVousID())"))
        webservice.execute()
    }
    
    func accept(datasource: InvitationDataSource) {
        self.numStatusInvitation = 2
        let webservice = WebServiceInvitation(commande: .ACCEPT, entite: .Utilisateur_RendezVous, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "numInvite", valeur: "\(self.getInviteID())"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numRendezVous", valeur: "\(self.getRendezVousID())"))
        webservice.execute()
    }
    
    func create(datasource: InvitationDataSource) {
        print("Invitation:InvitationCrudable:create")
        let webservice = WebServiceInvitation(commande: .CREATE, entite: .Utilisateur_RendezVous, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "numInvite", valeur: "\(self.getInviteID())"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numRendezVous", valeur: "\(self.getRendezVousID())"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numStatusInvitation", valeur: "\(self.numStatusInvitation)"))
        webservice.execute()
    }
    
   static func read(datasource:InvitationDataSource,numRendezVous:Int,numInvite:Int)
   {
        print("Invitation:InvitationCrudable:read NOT IMPLEMENTED")
    }
    
    func update(datasource: InvitationDataSource) {
        print("Invitation:InvitationCrudable:update NOT IMPLEMENTED")
    }
    
    func delete(datasource: InvitationDataSource) {
        print("Invitation:InvitationCrudable:delete NOT IMPLEMENTED")
    }
    
    func cancel(datasource: InvitationDataSource) {
        print("Invitation:InvitationCrudable:cancel NOT IMPLEMENTED")
    }
    
    
}
extension Invitation:InvitationListable
{
    static func load(datasource: InvitationDataSource) {
        print("RendezVous:RendezVousListable:load (\(Utilisateur.sharedInstance!.pseudo)[\(Utilisateur.sharedInstance!.idUtilisateur)])")
        let webservice = WebServiceInvitation(commande: .LIST, entite: .Invitation, datasource: datasource)
        webservice.execute()
    }
    
    static func append(rendezVous: RendezVous,datasource: RendezVousDataSource) {
        guard ListeInvitationsAsConvive.sharedInstance != nil else {
            print("Invitation:InvitationListable:append- aucune liste ListeRendezVousAsConvive trouvée")
            return
        }
        print("-> il faut ajouter l'invitation'")
        ListeInvitationsAsConvive.sharedInstance!.liste.append(rendezVous)
        ListeInvitationsAsConvive.reloadViews()
    }
    
    static func remove(indice: Int,datasource: RendezVousDataSource) {
        guard ListeInvitationsAsConvive.sharedInstance != nil else {
            print("Invitation:InvitationListable:remove(indexPath) - aucune liste ListeRendezVousAsConvive trouvée")
            return
        }
        print("-> il faut annuler l'invitation'")
        ListeInvitationsAsConvive.sharedInstance!.liste[indice].cancel(datasource: datasource)
    }
    
    static func find(rendezVous: RendezVous) -> Int {
        print("Invitation:InvitationListable:find")
        var i = 0
        var indice = -1
        for item in ListeInvitationsAsConvive.sharedInstance!.liste
        {
            if item.idRendezVous == rendezVous.idRendezVous
            {
                indice = i
            }
            i += 1
        }
        print("-> indice trouvé: \(indice) (-1 = rien trouvé)")
        return indice
    }
    
    
}

