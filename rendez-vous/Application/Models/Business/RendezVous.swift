//
//  RendezVous.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHash
import UIKit

class RendezVous{
   // static var sharedInstance:RendezVous?
    var idRendezVous:Int
    var numUtilisateurSource:Int
    var date:String
    var numStatusRendezVous:Int
    var numRestaurant:Int
    var hote:Utilisateur
    var invitationList = [Invitation]()
    var restaurant : Restaurant?
    
    init(idRendezVous:Int,numUtilisateurSource:Int,date:String,numStatusRendezVous:Int,numRestaurant:Int,hote:Utilisateur,restau:Restaurant) {
        print("RendezVous:init - id rdv: \(idRendezVous)")
        self.idRendezVous = idRendezVous
        self.numUtilisateurSource = numUtilisateurSource
        self.date = date
        self.numStatusRendezVous = numStatusRendezVous
        self.numRestaurant = numRestaurant
        self.hote = hote
        self.restaurant = restau
    }
    convenience init(jRendezVous:JSON,jHote:JSON,jRestau:JSON) {
        self.init(idRendezVous:jRendezVous["idRendezVous"].intValue,numUtilisateurSource:jRendezVous["numUtilisateurSource"].intValue,date:jRendezVous["date"].stringValue,numStatusRendezVous:jRendezVous["numStatusRendezVous"].intValue,numRestaurant:jRendezVous["numRestaurant"].intValue,hote:Utilisateur(json: jHote),restau:Restaurant(json: jRestau))
        print("printdajason\(jRendezVous)")
    }
    func getDate()->Date
    {
        print("RendezVous:getDate(string: \(self.date))")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        print("\(String(describing: dateFormatter.date(from:self.date)))")
        guard dateFormatter.date(from:self.date) != nil else {
            print("-> date null ERROR")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.date(from:self.date)!
        }
        return dateFormatter.date(from:self.date)!
    }
 

    func getInvitationOfOneUser(utilisateur:Utilisateur)->Invitation?
    {
        print("RendezVous:getInvitationOfOneUser")
        for item in self.invitationList
        {
            print("\(item.getInviteID()) ?= \(utilisateur.idUtilisateur)")
            if item.getInviteID() == utilisateur.idUtilisateur
            {
                print("->trouvé")
                return item
            }
        }
        return nil
    }
   
    func addInvitation(invitation:Invitation)
    {
        print("RendezVous:addInvitation")
        self.invitationList.append(invitation)
        RendezVous.reloadViews()
        ListeInvitationsAsConvive.reloadViews()
        ListeRendezVous.reloadViews()
    }
    func getDay()->String
    {
        print("RendezVous:getDay")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let leJour = dateFormatter.string(from: self.getDate())
        print("-> \(leJour)")
        return leJour
    }
   func getHour()->String
   {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "fr_FR")
    dateFormatter.dateFormat = "hh:mm"
    let lHeure = dateFormatter.string(from: self.getDate())
    print("-> \(lHeure)")
    return lHeure
    }
    
}
extension RendezVous:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("RendezVous:subscribe")
        var lavue = vue
        lavue.indice = self.suscribedViews.count
        self.suscribedViews.append(lavue)
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à RendezVous")
    }
    
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("RendezVous:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à RendezVous")
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }

        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à RendezVous")
    }
    static func reloadViews()
    {
        print("RendezVous:reloadViews")
          print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à RendezVous")
        for vue in self.suscribedViews
        {
            print(vue)
            vue.refresh()
        }
    }
}
extension RendezVous:RendezVousCrudable
{
    func create(datasource: RendezVousDataSource) {
        let webservice = WebServiceRendezVous(commande: .CREATE, entite: .RendezVous, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "date", valeur: "\(self.date)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numRestaurant", valeur: "\(self.numRestaurant)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numStatusRendezVous", valeur: "1"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numUtilisateurSource", valeur:"\(self.numUtilisateurSource)" ))
        
        webservice.execute()
        RendezVous.reloadViews()
    }
    
    static func read(datasource: RendezVousDataSource,idRendezVous:Int) -> RendezVous? {
    //    let webservice = WebServiceRendezVous(commande: .READ, entite: .RendezVous, datasource: datasource)
        return nil
    }
    
    func update(datasource: RendezVousDataSource) {
        let webservice = WebServiceRendezVous(commande: .UPDATE, entite: .RendezVous, datasource: datasource)
       /* webservice.addParameter(parametre: WebServiceParametre(cle: "catchPhrase", valeur: self.catchPhrase.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
        webservice.addParameter(parametre: WebServiceParametre(cle: "idUtilisateur", valeur: "\(self.idUtilisateur)"))
*/
        webservice.execute()
        Utilisateur.reloadViews()
    }
    
    func delete(datasource: RendezVousDataSource) {
        print("DELETE NON IMPLEMENTE")
    }
    func cancel(datasource: RendezVousDataSource) {
        print("RendezVous:RendezVousCrudable:cancel")
        let webservice = WebServiceRendezVous(commande: .CANCEL, entite: .RendezVous, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "idRendezVous", valeur: "\(self.idRendezVous)"))
        webservice.execute()
        RendezVous.reloadViews()
    }
}
extension RendezVous:RendezVousListable
{
    static func load(dataSource: RendezVousDataSource) {
        print("RendezVous:RendezVousListable:load (\(Utilisateur.sharedInstance!.pseudo)[\(Utilisateur.sharedInstance!.idUtilisateur)]")
        let webservice = WebServiceRendezVous(commande: .LIST, entite: .RendezVous, datasource: dataSource)
        webservice.execute()
    }
    static func find(rendezVous:RendezVous)->Int
    {
        print("ListeMatchingUtilisateurs:find")
        var i = 0
        var indice = -1
        for item in ListeRendezVous.sharedInstance.liste
        {
            if item.idRendezVous == rendezVous.idRendezVous
            {
                indice = i
            }
            i += 1
        }
        print("-> indice trouvé: \(indice) (-1 = rien trouvé)")
        return indice
    }
    static func remove(indice:Int,dataSource:RendezVousDataSource)
    {
        print("ListeRendezVousAsHote:removein(dexPath) - il faut annuler le rendez-vous")
        print("rendez vous n° \(ListeRendezVous.sharedInstance.liste[indice].idRendezVous)")
        ListeRendezVous.sharedInstance.liste[indice].cancel(datasource:dataSource)
        ListeRendezVous.sharedInstance.liste.remove(at: indice)
        ListeRendezVous.reloadViews()
    }
    
    static func append(rendezVous:RendezVous,dataSource:RendezVousDataSource)
    {
        rendezVous.create(datasource: dataSource)
        ListeRendezVous.sharedInstance.liste.append(rendezVous)
        ListeRendezVous.reloadViews()
    }
    
}
