//
//  Favoris.swift
//  rendez-vous
//
//  Created by Thierry BRU on 13/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class Favoris:Utilisateur {
    /*var idUtilisateur = 0
    var numRamonUser = 0
    var urlImage = ""
    var catchPhrase = ""
    var description = ""
    var pseudo = ""
    var latitude = 0.0
    var longitude = 0.0*/
    
    init(rankedUtilisateur:RankedUtilisateur) {
super.init(idUtilisateur: rankedUtilisateur.idUtilisateur, numRamonUser: rankedUtilisateur.numRamonUser, urlImage: rankedUtilisateur.urlImage, catchPhrase: rankedUtilisateur.catchPhrase, description: rankedUtilisateur.description, pseudo: rankedUtilisateur.pseudo, latitude: rankedUtilisateur.latitude, longitude: rankedUtilisateur.longitude)
       /* self.idUtilisateur = rankedUtilisateur.idUtilisateur
        self.numRamonUser = rankedUtilisateur.numRamonUser
        self.urlImage = rankedUtilisateur.urlImage
        self.catchPhrase = rankedUtilisateur.catchPhrase
        self.description = rankedUtilisateur.description
        self.pseudo = rankedUtilisateur.pseudo
        self.latitude = rankedUtilisateur.latitude
        self.longitude = rankedUtilisateur.longitude*/
    }
     init(json:JSON) {
       super.init(idUtilisateur:json["idUtilisateur"].intValue,
                   numRamonUser:json["libelle"].intValue,
                   urlImage:json["urlPhoto"].stringValue,
                   catchPhrase:json["catchPhrase"].stringValue,
                   description:json["description"].stringValue,
                   pseudo:json["pseudonyme"].stringValue,
                   latitude:json["latitude"].doubleValue,
                   longitude:json["longitude"].doubleValue)
    }
}

extension Favoris:FavorisListable
{
    static func load(datasource: FavorisDataSource) {
        print("Favoris:FavorisListable:load - \(Utilisateur.sharedInstance!.pseudo)[\(Utilisateur.sharedInstance!.idUtilisateur)]")
        let webservice = WebServiceFavoris(commande: .LIST, entite: .Favoris, datasource: datasource)
        webservice.execute()
    }
    
    static func append(ami: Favoris, datasource: FavorisDataSource) {
        print("Favoris:FavorisListable:append - \(Utilisateur.sharedInstance!.pseudo)[\(Utilisateur.sharedInstance!.idUtilisateur)]")
        let webservice = WebServiceFavoris(commande: .CREATE, entite: .Favoris, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "numUtilisateurCible", valeur: "\(ami.idUtilisateur)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numUtilisateurSource", valeur: "\(Utilisateur.sharedInstance!.idUtilisateur)"))
        
        webservice.execute()
    }
    
    static func remove(indice: Int, datasource: FavorisDataSource) {
        print("Favoris:FavorisListable:remove - \(Utilisateur.sharedInstance!.pseudo)[\(Utilisateur.sharedInstance!.idUtilisateur)]")
        let webservice = WebServiceFavoris(commande: .DELETE, entite: .Favoris, datasource: datasource)
        webservice.execute()
    }
    
    static func find(ami: Favoris) -> Int {
        print("Favoris:FavorisListable:find")
        var i = 0
        var indice = -1
        for item in ListeUtilisateursFavoris.sharedInstance!.liste
        {
            if item.idUtilisateur == ami.idUtilisateur
            {
                indice = i
            }
            i += 1
        }
        print("-> indice trouvé: \(indice) (-1 = rien trouvé)")
        return indice
    }
    
}
