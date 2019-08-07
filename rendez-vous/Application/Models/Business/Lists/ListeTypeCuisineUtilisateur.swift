//
//  ListeTypeCuisineUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListeTypeCuisineUtilisateur
{
    static var sharedInstance : ListeTypeCuisineUtilisateur?
    var liste : [TypeCuisineUtilisateur]
    
    init()
    {
        self.liste = [TypeCuisineUtilisateur]()
    }
    convenience init(json:JSON) {
        print("ListeTypeCuisineUtilisateur:init")
        self.init()
        var i = 1
        for jCentreInteret in json {
            self.liste.append(TypeCuisineUtilisateur(json: jCentreInteret.1, ordre: i))
            i += 1
        }
    }
    convenience init(typesCuisine:ListeTypeCuisine) {
        var i = 1
        self.init()
        for item in typesCuisine.liste{
            self.liste.append(TypeCuisineUtilisateur(id: item.id, libelle: item.libelle, order: i))
            i += 1
        }
    }
    func register(datasource:TypeCuisineUtilisateurDataSource)
    {
        var listeInteret = [Int] ()
        for item in self.liste {
            listeInteret.append(item.id)
        }
        print("ListeCentreInteretUtilisateur::register")
        let webservice = WebServiceTypeCuisineUtilisateur(commande: .CREATE, entite: .Utilisateur_TypeCuisine, datasource:datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "liste", valeur: JSON(listeInteret).rawString()!))
        webservice.execute()
    }
}
