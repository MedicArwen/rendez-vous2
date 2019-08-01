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
    static var sharedInstance:RendezVous?
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
    }
    func getDate()->Date
    {
        print("RendezVous:getDate")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        guard dateFormatter.date(from:self.date) != nil else {
            return Date()
        }
        return dateFormatter.date(from:self.date)!
    }
    func save(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "CREATE"
        params["ENTITY"] = "RendezVous"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        //numUtilisateurSource     date          numStatusRendezVous     numRestaurant
        params["date"] = "\(self.date)"
        params["numRestaurant"] = "\(self.numRestaurant)"
        params["numStatusRendezVous"] = "1"
        params["numUtilisateurSource"] = "\(self.numUtilisateurSource)"
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["date"]!)\(params["numRestaurant"]!)\(params["numStatusRendezVous"]!)\(params["numUtilisateurSource"]!)onmangeensembleb20")
        print("enregistrement d un rendez vous")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["date"]!)\(params["numRestaurant"]!)\(params["numStatusRendezVous"]!)\(params["numUtilisateurSource"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    
    func cancel(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "UPDATE"
        params["ENTITY"] = "RendezVousCancel"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        params["idRendezVous"] = "\(self.idRendezVous)"
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(self.idRendezVous)onmangeensembleb20")
        print("Annulation d'un rendez vous")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(self.idRendezVous)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    func getInvitationOfOneUser(utilisateur:Utilisateur)->Invitation?
    {
        print("RendezVous:getInvitationOfOneUser")
        for item in self.invitationList
        {
            print("\(item.numInvite) ?= \(utilisateur.idUtilisateur)")
            if item.numInvite == utilisateur.idUtilisateur
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
        ListeRendezVousAsConvive.reloadViews()
        ListeRendezVousAsHote.reloadViews()
    }
   /* func addGuest(utilisateur:Utilisateur)
    {
        self.guestList.append(utilisateur)
    }*/
    func getDay()->String
    {
        print("RendezVous:getDay")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        print("Dateobj: \(dateFormatter.string(from: self.getDate()))")
        return dateFormatter.string(from: self.getDate())
    }
   func getHour()->String
   {
    print("RendezVous:getHour")
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "fr_FR")
    dateFormatter.dateFormat = "hh:mm"
    print("Dateobj: \(dateFormatter.string(from: self.getDate()))")
    return dateFormatter.string(from: self.getDate())
    }
    
    static func create(controleur: RamonViewController, rendezVous: RendezVous)
    {
        print("CREATE: RendezVous")
        rendezVous.save { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: controleur, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    let item = json["data"]
                    RendezVous.sharedInstance = RendezVous(jRendezVous:item["Rendez-Vous"],jHote:item["Hote"],jRestau:item["Restaurant"])
                    ListeRendezVousAsHote.append(controleur: controleur, item: RendezVous.sharedInstance!)
                    self.reloadViews()
        
                }
            }
        }
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
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
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
