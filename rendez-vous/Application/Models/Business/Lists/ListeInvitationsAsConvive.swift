//
//  ListeRendezVousAsConvive.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
import Foundation
import Foundation
import SwiftyJSON
import SwiftHash

class ListeInvitationsAsConvive {
    static var sharedInstance : ListeInvitationsAsConvive?
    var liste = [RendezVous]()
    init(json:JSON) {
        print("ListeRendezVousAsConvive:init")
        var i = 1
        print("-> ajout des \(json.arrayValue.count) invitations reçues")
        for item in json.arrayValue
        {
            let rendezVous = RendezVous(jRendezVous:item["Rendez-Vous"],jHote:item["Hote"],jRestau: item["Restaurant"])
            for jUtilisateur in item["Invitations"]
            {
                let invitation = Invitation(jsonInvitation: jUtilisateur.1["Invitation"], jsonUtilisateur: jUtilisateur.1["Utilisateur"],jsonRendezVous: item)
                rendezVous.addInvitation(invitation: invitation)
            }
            liste.append(rendezVous)
            i += 1
        }
    }
    func find(rendezVous:RendezVous)->Int
    {
        print("ListeRendezVousAsConvive:find")
        var i = 0
        var indice = -1
        for item in self.liste
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
    func accept(controleur:RamonViewController,rendezVous:RendezVous)
    {
        print("ListeRendezVousAsConvive:accept")
        guard Utilisateur.sharedInstance != nil else {
            print("-> aucun utilisateur connecté reconnu")
            return
        }
        let utilisateur = Utilisateur.sharedInstance!
        print("-> utilisateur cherché:\(utilisateur.idUtilisateur)")
        let invitation = rendezVous.getInvitationOfOneUser(utilisateur: utilisateur)!
        invitation.accept(datasource: self)
    }
    func reject(controleur:RamonViewController,rendezVous:RendezVous)
    {
        print("ListeRendezVousAsConvive:reject")
        guard Utilisateur.sharedInstance != nil else {
            print("-> aucun utilisateur connecté reconnu")
            return
        }
        let utilisateur = Utilisateur.sharedInstance!
        print("-> utilisateur cherché:\(utilisateur.idUtilisateur)")
        let invitation = rendezVous.getInvitationOfOneUser(utilisateur: utilisateur)!
        invitation.reject(datasource: self)
        

    }
    
}
extension ListeInvitationsAsConvive:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeRendezVousAsConvive:subscribe")
        self.suscribedViews.append(vue)
        print("->\(self.suscribedViews.count) vue(s) abonnée(s) à ListeRendezVousAsConvive")
    }
    
    static func reloadViews()
    {
        print("ListeRendezVousAsConvive:reloadViews")
        print("-> \(self.suscribedViews.count) vue(s) abonnée(s) à ListeRendezVousAsConvive")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeRendezVousAsConvive:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRendezVousAsConvive")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRendezVousAsConvive")
    }
}
extension ListeInvitationsAsConvive:RendezVousDataSource
{
    func rendezVousOnLoaded(rendezVous: RendezVous) {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    func rendezVousOnLoaded(lesRendezVous:ListeRendezVous)
    {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    func rendezVousOnUpdated() {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func rendezVousOnDeleted() {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func rendezVousOnCancelled() {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func rendezVousOnCreated(rendezVous: RendezVous) {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func rendezVousOnNotFoundRendezVous() {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func rendezVousOnWebServiceError(code: Int) {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
}
extension ListeInvitationsAsConvive:InvitationDataSource
{
    func invitationOnLoaded(invitation: Invitation) {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    func invitationOnLoaded(invitations: ListeInvitationsAsConvive) {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func invitationOnUpdated() {
        print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func invitationOnDeleted() {
         print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func invitationOnCancelled() {
         print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func invitationOnRejected() {
        print("ListeRendezVousAsConvive:RendezVousDataSource:invitationOnRejected")
        print("-> rechargement de la liste des rendez-vous")
        ListeInvitationsAsConvive.reloadViews()
    }
    
    func invitationOnAccepted() {
        print("ListeRendezVousAsConvive:RendezVousDataSource:invitationOnAccepted")
        print("-> rechargement de la liste des rendez-vous")
        ListeInvitationsAsConvive.reloadViews()
    }
    
    func invitationOnCreated(invitation:Invitation) {
         print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func invitationOnNotFoundInvitation() {
         print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    func invitationOnWebServiceError(code: Int) {
         print("ListeRendezVousAsConvive:RendezVousDataSource: not implemented")
    }
    
    
}
