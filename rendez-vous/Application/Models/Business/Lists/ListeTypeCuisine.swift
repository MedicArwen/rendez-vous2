//
//  ListeTypeCuisine.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListeTypeCuisine
{
    static var sharedInstance: ListeTypeCuisine?
    var liste = [TypeCuisine]()
    
    init(json:JSON) {
        print("ListeTypeCuisine:init")
        for jCuisine in json {
            self.liste.append(TypeCuisine(json:jCuisine.1))
        }
    }
    func returnListDefaut()->[TypeCuisineUtilisateur]
    {
        var liste =  [TypeCuisineUtilisateur]()
        var i = 1
        for item in self.liste {
            liste.append(TypeCuisineUtilisateur(id: item.id, libelle: item.libelle, order: i))
            i += 1
        }
        return liste
    }
    func register(datasource:TypeCuisineDataSource)
    {
        var listeCuisine = [Int] ()
        for item in self.liste {
            listeCuisine.append(item.id)
        }
        print("ListeCentreInteretUtilisateur::register")
        let webservice = WebServiceTypeCuisine(commande: .CREATE, entite: .Utilisateur_TypeCuisine, datasource:datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "liste", valeur: JSON(listeCuisine).rawString()!))
        webservice.execute()
    }
}
