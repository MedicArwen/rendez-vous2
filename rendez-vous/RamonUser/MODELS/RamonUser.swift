//
//  RamonUser.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON


class RamonUser{
    var idRamonUser: Int
    var courriel: String
    var motdepasse: String
    var dateNaissance: String
    var pseudonyme: String
    var prenom: String
    var nom: String
    var codeValidation: String
    var estCompteValide: Int
    var numGenre: Int
    
    init(idRamonUser: Int, courriel: String, motdepasse: String, dateNaissance: String, pseudonyme: String, prenom: String, nom: String, codeValidation: String, estCompteValide: Int, numGenre: Int) {
        self.idRamonUser = idRamonUser
        self.courriel = courriel
        self.motdepasse = motdepasse
        self.dateNaissance = dateNaissance
        self.pseudonyme = pseudonyme
        self.prenom = prenom
        self.nom = nom
        self.codeValidation = codeValidation
            self.estCompteValide = estCompteValide

        self.numGenre = numGenre
    }
    convenience init(ramonUserJson:JSON) {
        self.init(idRamonUser:Int(ramonUserJson["idRamonUser"].stringValue)!,courriel:ramonUserJson["courriel"].stringValue,motdepasse:ramonUserJson["motdepasse"].stringValue,dateNaissance:ramonUserJson["dateNaissance"].stringValue,pseudonyme:ramonUserJson["pseudonyme"].stringValue,prenom:ramonUserJson["prenom"].stringValue, nom: ramonUserJson["nom"].stringValue,codeValidation: ramonUserJson["codeValidation"].stringValue,estCompteValide:Int(ramonUserJson["estCompteValide"].stringValue)!,numGenre:Int(ramonUserJson["numGenre"].stringValue)!)
        
    }
    func print() {
     /*   print(self.idRamonUser)
        print(self.courriel)
        print(self.motdepasse)
        print(self.dateNaissance)
        print(self.pseudonyme)
    
        print(self.prenom)
        print(self.nom)
        print(self.codeValidation)
        print(self.estCompteValide)
        print(self.numGenre)*/
    }
}

