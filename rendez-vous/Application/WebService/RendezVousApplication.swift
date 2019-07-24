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
    /*
     Informations sur la connection de l'utilisateur
     il est connecté en RamonUser (commun à toutes les applications
    et en Utilisateur(spécifique à RendezVous)
     */
    var connectedUtilisateur: Utilisateur?
    var connectedRamonUser: ConnectedRamonUser?
   
    // liste des utilisateurs qui matchent (notion de distance, calcul d'un score de match)
    var listeUtilisateursMatch:ListeMatchingUtilisateurs?
    // liste des restaurants proches de l'utilisateur ou de la position indiquée
    var listeRestaurantsProches: ListeRestaurants?
    // liste des rendez-vous créés par l'utilisateur
    var listeRendezVousCrees:AgendaEventHosted?

    static var sharedInstance = RendezVousApplication()

    static func getHostedRendezVous()->[RendezVous]
    {
        return RendezVousApplication.sharedInstance.listeRendezVousCrees!.events
    }
    static func getListeMatching()->[RankedUtilisateur]
    {
        
        return RendezVousApplication.sharedInstance.listeUtilisateursMatch!.liste
        
    }
    static func getListeRestaurants()->[Restaurant]
    {
        if let listeRestaurant = RendezVousApplication.sharedInstance.listeRestaurantsProches
        {
            return listeRestaurant.liste
        }
    return [Restaurant]()
    }
    static func isRestaurantListReady()->Bool
    {
    return !(RendezVousApplication.sharedInstance.listeRestaurantsProches == nil)
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
