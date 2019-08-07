//
//  ListeCentreInteretUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 31/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON
import MapKit


class ListeCentreInteretUtilisateur
{
    static var sharedInstance : ListeCentreInteretUtilisateur?
    var liste : [CentreInteretUtilisateur]
    
    init() {
        self.liste = [CentreInteretUtilisateur]()
    }
    convenience init(json:JSON) {
        print("ListeCentreInteretUtilisateur:init")
        self.init()
       // self.liste = [CentreInteretUtilisateur]()
        var i = 1
        for jCentreInteret in json {
            self.liste.append(CentreInteretUtilisateur(json: jCentreInteret.1, ordre: i))
            i += 1
        }
    }
    convenience init(centreInterets:ListeCentreInterets) {
        self.init()
        var i = 1
        for item in centreInterets.liste{
            self.liste.append(CentreInteretUtilisateur(id: item.id, libelle: item.libelle, order: i))
            i += 1
        }
    }
    func register(datasource:CentreInteretUtilisateurDataSource)
    {
        var listeInteret = [Int] ()
        for item in self.liste {
            listeInteret.append(item.id)
        }
        print("ListeCentreInteretUtilisateur::register")
        let webservice = WebServiceCentreInteretUtilisateur(commande: .CREATE, entite: .Utilisateur_CentreInteret, datasource:datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "liste", valeur: JSON(listeInteret).rawString()!))
        webservice.execute()
    }
    static func remove(controleur: RamonViewController, indexPath: IndexPath) {
        print("ListeCentreInteretUtilisateur:remove - pas implanté ")
    }
    
    static func remove(controleur: RamonViewController, item: Any) {
        print("ListeCentreInteretUtilisateur:remove - pas implanté ")
    }
    
    static func append(controleur: RamonViewController, item: Any) {
        print("ListeCentreInteretUtilisateur:append - pas implanté ")
    }
    static func swap(source:Int,dest:Int)
    {
        ListeCentreInteretUtilisateur.sharedInstance!.liste.swapAt(source, dest)
        var i = 1
        for item in ListeCentreInteretUtilisateur.sharedInstance!.liste
        {
            item.order = i
            print ("item \(item.order) - \(item.libelle)")
            i += 1
            if item.order == source + 1 || item.order == dest + 1
            {
                print("->update to db")
                item.update(datasource: ListeCentreInteretUtilisateur.sharedInstance!)
            }
        }
        ListeCentreInteretUtilisateur.reloadViews()
        
    }
}
extension ListeCentreInteretUtilisateur:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("ListeCentreInteretUtilisateur:subscribe")
        self.suscribedViews.append(vue)
        print("->\(self.suscribedViews.count) vue(s) abonnée(s) à ListeCentreInteretUtilisateur")
    }
    
    static func reloadViews()
    {
        print("ListeCentreInteretUtilisateur:reloadViews")
        print("-> \(self.suscribedViews.count) vue(s) abonnée(s) à ListeCentreInteretUtilisateur")
        for vue in self.suscribedViews
        {
            vue.refresh()
        }
    }
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("ListeCentreInteretUtilisateur:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeCentreInteretUtilisateur")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à ListeCentreInteretUtilisateur")
    }
}
extension ListeCentreInteretUtilisateur:CentreInteretUtilisateurDataSource
{
    func centreInteretUtilisateurOnLoaded(centreInteret: CentreInteretUtilisateur) {
        print("ListeCentreInteretUtilisateur:CentreInteretDataSource:centreInteretOnLoaded  NOT IMPLEMENTED")
    }
    func centreInteretUtilisateurOnLoaded(centresInterets: ListeCentreInteretUtilisateur) {
        print("ListeCentreInteretUtilisateur:CentreInteretDataSource:centreInteretOnLoaded  NOT IMPLEMENTED")
    }
    func centreInteretUtilisateurOnUpdated() {
        print("ListeCentreInteretUtilisateur:CentreInteretDataSource:centreInteretOnUpdated")
        ListeCentreInteretUtilisateur.reloadViews()
    }
    
    func centreInteretUtilisateurOnDeleted() {
        print("ListeCentreInteretUtilisateur:CentreInteretDataSource:centreInteretOnDeleted  NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnCreated() {
        print("ListeCentreInteretUtilisateur:CentreInteretDataSource:centreInteretOnCreated  NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnNotFoundCentreInteret() {
        print("ListeCentreInteretUtilisateur:CentreInteretDataSource:centreInteretOnNotFoundCentreInteret  NOT IMPLEMENTED")
    }
    
    func centreInteretUtilisateurOnWebServiceError(code: Int) {
        print("ListeCentreInteretUtilisateur:CentreInteretDataSource:centreInteretOnWebServiceError  NOT IMPLEMENTED")
    }
    
    
}
