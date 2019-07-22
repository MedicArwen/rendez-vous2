//
//  RendezVousApplication.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
class RendezVousApplication
{
    var connectedUtilisateur: Utilisateur?
    var connectedRamonUser: ConnectedRamonUser?
    var listeRestaurants: ListeRestaurants?
    var currentRendezVous: RendezVous?
    var currentRestaurant: Restaurant?
    var matchList:ListeMatchingUtilisateurs?
    
    
    
    static var sharedInstance = RendezVousApplication()

    static func getListeMatching()->[RankedUtilisateur]
    {
        
        return RendezVousApplication.sharedInstance.matchList!.liste
        
    }
    static func getListeRestaurants()->[Restaurant]
    {
        
    return RendezVousApplication.sharedInstance.listeRestaurants!.liste
    
    }
    static func isRestaurantListReady()->Bool
    {
    return !(RendezVousApplication.sharedInstance.listeRestaurants == nil)
    }
    
    func isProfileLoad()->Bool
    {
        return (!(connectedUtilisateur == nil))
    }
    func isConnected()->Bool
    {
        return (!(connectedRamonUser == nil))
    }
    static func getApiKey()->String
    {
        return RendezVousApplication.sharedInstance.connectedRamonUser!.apiKey!
    }
    static func getRamonUserId()->Int
    {
        return RendezVousApplication.sharedInstance.connectedRamonUser!.ramonUser.idRamonUser
    }
    static func getUtilisateurId()->Int
    {
        return RendezVousApplication.sharedInstance.connectedUtilisateur!.idUtilisateur
    }
    static func getDateNaissance()->String
    {
        return RendezVousApplication.sharedInstance.connectedRamonUser!.ramonUser.dateNaissance
    }
    static func getNumGenre()->Int
    {
        return RendezVousApplication.sharedInstance.connectedRamonUser!.ramonUser.numGenre
    }
    static func getPseudo()->String
    {
        return RendezVousApplication.sharedInstance.connectedRamonUser!.ramonUser.pseudonyme
    }
}
