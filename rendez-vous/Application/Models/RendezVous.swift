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

class RendezVous{
    var idRendezVous:Int
    var numUtilisateurSource:Int
    var date:String
    var numStatusRendezVous:Int
    var numRestaurant:Int
    var hote:Utilisateur
  //  var guestList = [Utilisateur]()
    var invitationList = [Invitation]()
    var restaurant : Restaurant?
    
    init(idRendezVous:Int,numUtilisateurSource:Int,date:String,numStatusRendezVous:Int,numRestaurant:Int,hote:Utilisateur) {
        self.idRendezVous = idRendezVous
        self.numUtilisateurSource = numUtilisateurSource
        self.date = date
        self.numStatusRendezVous = numStatusRendezVous
        self.numRestaurant = numRestaurant
        self.hote = hote
    }
    convenience init(jRendezVous:JSON,jHote:JSON) {
        self.init(idRendezVous:jRendezVous["idRendezVous"].intValue,numUtilisateurSource:jRendezVous["numUtilisateurSource"].intValue,date:jRendezVous["date"].stringValue,numStatusRendezVous:jRendezVous["numStatusRendezVous"].intValue,numRestaurant:jRendezVous["numRestaurant"].intValue,hote:Utilisateur(json: jHote))
    }
    func getDate()->Date
    {
        let dateFormatter = DateFormatter()
        
        // dateFormatter.locale = Locale(identifier: "en_EN") // edited
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
       // print(" la timezone: \(String(describing: dateFormatter.timeZone))")
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
    
    func addInvitation(invitation:Invitation)
    {
        self.invitationList.append(invitation)
    }
   /* func addGuest(utilisateur:Utilisateur)
    {
        self.guestList.append(utilisateur)
    }*/
    func getDay()->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "fr_FR")
        dateFormatter.dateFormat = "MM-dd-yyyy"
        print("Dateobj: \(dateFormatter.string(from: self.getDate()))")
        return dateFormatter.string(from: self.getDate())
    }
   func getHour()->String
   {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "fr_FR")
    dateFormatter.dateFormat = "hh:mm"
    print("Dateobj: \(dateFormatter.string(from: self.getDate()))")
    return dateFormatter.string(from: self.getDate())
    }
}
