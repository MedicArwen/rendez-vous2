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
}
extension RamonUser: RamonUserCrudable
{
    func create(datasource: RamonUserDataSource) {
        print("RamonUser: RamonUserCrudable:create - NOT IMPLEMENTED")
    }
    
    static func read(datasource: RamonUserDataSource) {
        print("RamonUser: RamonUserCrudable:read - NOT IMPLEMENTED")
       /* let webservice = WebServiceRamonUser(commande: .READ, entite: .Utilisateur, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "idUtilisateur", valeur: "\(idUtilisateur)"))
        webservice.execute()*/
    }
    
    static func read(datasource: RamonUserDataSource, idRamonUser: Int) {
        print("RamonUser: RamonUserCrudable:read(idRamonUser) - NOT IMPLEMENTED")
      /*  let webservice = WebServiceRamonUser(commande: .READ, entite: .Utilisateur, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "idRamonUser", valeur: "\(idRamonUser)"))
        webservice.execute()    */
    }
    
    func update(datasource: RamonUserDataSource) {
        print("RamonUser: RamonUserCrudable:update - NOT IMPLEMENTED")
    }
    
    func delete(datasource: RamonUserDataSource) {
        print("RamonUser: RamonUserCrudable:delete - NOT IMPLEMENTED")
    }
     static func login(datasource:RamonUserDataSource,courriel:String,motdepasse:String)
     {
        print("RamonUser: login:read(courriel+motdepasse)")
        let webservice = WebServiceRamonUser(commande: .CREDENTIALS, entite: .RamonUser, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "courriel", valeur: "\(courriel)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "idApplication", valeur: "2"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "motdepasse", valeur: "\(motdepasse)"))
       
        webservice.execute()
        
    }
}

