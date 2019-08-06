//
//  MatchListe.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHash

class ListeMatchingUtilisateurs
{
    static var sharedInstance : ListeMatchingUtilisateurs?
    var liste = [RankedUtilisateur]()
    
    init(json:JSON)
    {
       
        print("ListeMatchingUtilisateurs:init")
        for jUtilisateur in json {
           liste.append(RankedUtilisateur(json:jUtilisateur.1))
        }
        self.liste = self.getPurgedList()
    }
    // retourne l'indice de l'utilisateur
  
 func getPurgedList()-> [RankedUtilisateur]
 {
    var liste = [RankedUtilisateur]()
    for rankedUtilisateur in self.liste
        {
            let utilisateur = rankedUtilisateur as Utilisateur
            if !isHote(utilisateur: utilisateur) && !inInvitationList(utilisateur: utilisateur)
            {
                liste.append(rankedUtilisateur)
            }
        }
    return liste
    }
    
    func isHote(utilisateur:Utilisateur)->Bool
    {
        return utilisateur == RendezVous.sharedInstance!.hote
    }
    func inInvitationList(utilisateur:Utilisateur)->Bool
    {
        var found = false
        for item in RendezVous.sharedInstance!.invitationList
        {
            if item.utilisateur == utilisateur
            {
                found = true
            }
        }
        return found
    }
    
}
extension ListeMatchingUtilisateurs:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeMatchingUtilisateurs:subscribe")
        self.suscribedViews.append(vue)
        print("Il y a \(self.suscribedViews.count) vues abonnées à ListeMatchingUtilisateurs")
    }
    
    static func reloadViews()
    {
        print("ListeMatchingUtilisateurs:reloadView")
        print("Il y a \(self.suscribedViews.count) vues abonnée(s) à ListeMatchingUtilisateurs")
        print (" il faut afficher les \(ListeMatchingUtilisateurs.sharedInstance!.liste.count) utilisateurs qui matchent")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeMatchingUtilisateurs:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeMatchingUtilisateurs")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeMatchingUtilisateurs")
    }
}
