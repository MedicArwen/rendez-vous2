//
//  ListeRendezVousAsHote.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import Foundation
import SwiftyJSON
import SwiftHash

class ListeRendezVous {
    static var sharedInstance = ListeRendezVous()
    var liste = [RendezVous]()
    init()
    {
        print("ListeRendezVousAsHote:init()")
    }
    convenience init(json:JSON) {
        self.init()
        print("ListeRendezVousAsHote:init(json)")
        var i = 1
        print("-> ajout des \(json.arrayValue.count) rendez-vous à la liste")
        for item in json.arrayValue
        {
            let rendezVous = RendezVous(jRendezVous:item["Rendez-Vous"],jHote:item["Hote"],jRestau: item["Restaurant"])
            //rendezVous.restaurant = Restaurant(json: item["Restaurant"])
            for jUtilisateur in item["Invitations"]
            {
                let invitation = Invitation(jsonInvitation: jUtilisateur.1["Invitation"], jsonUtilisateur: jUtilisateur.1["Utilisateur"],jsonRendezVous: jUtilisateur.1["Rendez-Vous"])
                rendezVous.addInvitation(invitation: invitation)
            }
            self.liste.append(rendezVous)
            i += 1
        }
    }
    
}
extension ListeRendezVous:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeRendezVousAsHote:suscrobe")
        self.suscribedViews.append(vue)
        print("Il y a \(self.suscribedViews.count) vues abonnées à ListeRendezVousAsHote")
    }
    
    static func reloadViews()
    {
        print("ListeRendezVousAsHote:reloadViews")
        print("Il y a \(self.suscribedViews.count) vue(s) abonnée(s) à ListeRendezVousAsHote")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeRendezVousAsHote:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRendezVousAsHote")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeRendezVousAsHote")
    }
}
extension ListeRendezVous:RendezVousDataSource
{
    func rendezVousOnLoaded(rendezVous: RendezVous) {
        print("ListeRendezVousAsHote:RendezVousDataSource:rendezVousOnLoaded not implemented")
    }
    func rendezVousOnLoaded(lesRendezVous:ListeRendezVous)
    {
        print("ListeRendezVousAsHote:RendezVousDataSource:rendezVousOnLoaded not implemented")
    }
    func rendezVousOnUpdated() {
         print("ListeRendezVousAsHote:RendezVousDataSource:rendezVousOnUpdated not implemented")
    }
    
    func rendezVousOnDeleted() {
         print("ListeRendezVousAsHote:RendezVousDataSource:rendezVousOnDeleted not implemented")
    }
    
    func rendezVousOnCancelled() {
        print("ListeRendezVousAsHote:rendezVousOnCancelled:rendezVousOnCancelled annulation réussie")
    }
    
    func rendezVousOnCreated(rendezVous: RendezVous) {
         print("ListeRendezVousAsHote:RendezVousDataSource:rendezVousOnCreated")
        ListeRendezVous.reloadViews()
    }
    
    func rendezVousOnNotFoundRendezVous() {
         print("ListeRendezVousAsHote:RendezVousDataSource: not implemented")
    }
    
    func rendezVousOnWebServiceError(code: Int) {
         print("ListeRendezVousAsHote:RendezVousDataSource: not implemented")
    }
    
    
}
