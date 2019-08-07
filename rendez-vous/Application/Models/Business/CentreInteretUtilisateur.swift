//
//  CentreInteret.swift
//  rendez-vous
//
//  Created by Thierry BRU on 09/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class CentreInteretUtilisateur:CentreInteret
{

    var order = 0
    init(id:Int,libelle:String, order:Int) {
        print("CentreInteretUtilisateur:init - Creation centre interet: N°\(order) - \(libelle)")
        super.init(id: id, libelle: libelle)
        self.order = order
    }
    convenience init(json:JSON,ordre:Int) {
        self.init(id:json["idCentreInteret"].intValue,libelle:json["libelle"].stringValue,order:ordre)
    }
    convenience init(json:JSON) {
        self.init(id:json["idCentreInteret"].intValue,libelle:json["libelle"].stringValue,order:json["ordre"].intValue)
    }

}
extension CentreInteretUtilisateur:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("CentreInteret:subscribe")
        var lavue = vue
        lavue.indice = self.suscribedViews.count
        self.suscribedViews.append(lavue)
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à CentreInteret")
    }
    
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("CentreInteret:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à CentreInteret")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à CentreInteret")
    }
    static func reloadViews()
    {
        print("CentreInteret:reloadViews")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à CentreInteret")
        for vue in self.suscribedViews
        {
            print(vue)
            vue.refresh()
        }
    }

}
extension CentreInteretUtilisateur:CentreInteretUtilisateurCrudable
{
    
    func create(datasource: CentreInteretUtilisateurDataSource) {
        print("CentreInteret:CentreInteretCrudable:create")
        print("NON IMPLEMENTE")
    }
    
    static func read(datasource: CentreInteretUtilisateurDataSource, numUtilisateur: Int, numCentreInteret: Int) {
        print("CentreInteret:CentreInteretCrudable:read")
        print("NON IMPLEMENTE")
    }
    
    func update(datasource: CentreInteretUtilisateurDataSource) {
        print("CentreInteret:CentreInteretCrudable:update")
        let webservice = WebServiceCentreInteretUtilisateur(commande: .UPDATE, entite: .Utilisateur_CentreInteret, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "numCentreInteret", valeur: "\(self.id)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numUtilisateur", valeur: "\(Utilisateur.sharedInstance!.idUtilisateur)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "ordre", valeur: "\(self.order)"))
        webservice.execute()
        Utilisateur.reloadViews()
    }
    
    func delete(datasource: CentreInteretUtilisateurDataSource) {
        print("CentreInteret:CentreInteretCrudable:delete")
        print("NON IMPLEMENTE")
    }
   
}
extension CentreInteretUtilisateur:CentreInteretUtilisateurListable
{
    static func load(datasource: CentreInteretUtilisateurDataSource) {
        print("CentreInteret:CentreInteretListable:load")
        let webservice = WebServiceCentreInteretUtilisateur(commande: .LIST, entite: .Utilisateur_CentreInteret, datasource: datasource)
        webservice.execute()
    }    
    
}
