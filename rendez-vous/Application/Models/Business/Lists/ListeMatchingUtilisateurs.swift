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
  //  static var sharedInstance : ListeMatchingUtilisateurs?
    var liste = [RankedUtilisateur]()
    
    init(json:JSON)
    {
       
        print("ListeMatchingUtilisateurs:init")
        for jUtilisateur in json {
           liste.append(RankedUtilisateur(json:jUtilisateur.1))
        }
       
    }
    // retourne l'indice de l'utilisateur
  
    func getPurgedList(rendezVous:RendezVous,hote:Utilisateur)
 {
    print("getPurgedList()")
   /* var listePurgee = [RankedUtilisateur]()
    for rankedUtilisateur in self.liste
        {
            let utilisateur = rankedUtilisateur as Utilisateur
            if !isHote(utilisateur: utilisateur) && !inInvitationList(utilisateur: utilisateur)
            {
                listePurgee.append(rankedUtilisateur)
                self.liste.remo
            }
        }
    self.liste = listePurgee*/
    //phrase.removeAll(where: { vowels.contains($0) })
    var tempo = [Utilisateur]()
    for item in ListeSelectionUtilisateur.sharedInstance.listeInvites
    {
        tempo.append(item)
    }
    tempo.append(hote)
        for item in rendezVous.invitationList
        {
            tempo.append(item.utilisateur)
        }
    
    liste.removeAll(where: { tempo.contains($0) })
    }
    
    /*func isHote(utilisateur:Utilisateur)->Bool
    {
        guard RendezVous.sharedInstance != nil else {
            return false
        }
        return utilisateur == RendezVous.sharedInstance!.hote
    }*/
    /*func inInvitationList(utilisateur:Utilisateur)->Bool
    {
        var found = false
        guard RendezVous.sharedInstance != nil else {
            return false
        }
        for item in RendezVous.sharedInstance!.invitationList
        {
            if item.utilisateur == utilisateur
            {
                found = true
            }
        }
        return found
    }*/
    func find(utilisateur:Utilisateur)->Int
    {
        print("ListeMatchingUtilisateurs:find")
        var i = 0
        var indice = -1
        for item in self.liste
        {
            if item.idUtilisateur == utilisateur.idUtilisateur
            {
                indice = i
            }
            i += 1
        }
        print("-> indice trouvé: \(indice) (-1 = rien trouvé)")
        return indice
    }
    func remove(indice: Int) {
        print("ListeMatchingUtilisateurs:remove(indexPath) - indice:\(indice) ")
        self.liste.remove(at: indice)
       // ListeMatchingUtilisateurs.reloadViews()
        
    }
    
    
    func append(utilisateur:RankedUtilisateur)
    {
        print("ListeMatchingUtilisateurs:append - id utilisateur: \(utilisateur.idUtilisateur)")
        self.liste.append(utilisateur)
       // ListeMatchingUtilisateurs.reloadViews()
    }
}
/*extension ListeMatchingUtilisateurs:WebServiceSubscribable
{
    private var suscribedViews = [WebServiceLinkable]()
    
    func subscribe(vue:WebServiceLinkable)
    {
        print("ListeMatchingUtilisateurs:subscribe")
        self.suscribedViews.append(vue)
        print("Il y a \(self.suscribedViews.count) vues abonnées à ListeMatchingUtilisateurs")
    }
    
    func reloadViews()
    {
        print("ListeMatchingUtilisateurs:reloadView")
        print("Il y a \(self.suscribedViews.count) vues abonnée(s) à ListeMatchingUtilisateurs")
        print (" il faut afficher les \(self.liste.count) utilisateurs qui matchent")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    func unsuscribe(vue:WebServiceLinkable)
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
}*/
