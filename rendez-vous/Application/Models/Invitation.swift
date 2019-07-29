
//
//  Invitation.swift
//  rendez-vous
//
//  Created by Thierry BRU on 22/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHash

class Invitation{
    //numInvite     numRendezVous     numStatusInvitation
    
    var numInvite:Int
    var numRendezVous:Int
    var numStatusInvitation:Int
    var utilisateur:Utilisateur
    
    init(numInvite:Int,numRendezVous:Int,numStatusInvitation:Int,utilisateur:Utilisateur) {
        print("Invitation:init - num invite:\(numInvite), num rdv: \(numRendezVous)")
        self.numInvite = numInvite
        self.numRendezVous = numRendezVous
        self.numStatusInvitation = numStatusInvitation
        self.utilisateur = utilisateur
    }
    convenience init(jsonInvitation:JSON,jsonUtilisateur:JSON) {
        self.init(numInvite:jsonInvitation["numInvite"].intValue,numRendezVous:jsonInvitation["numRendezVous"].intValue,numStatusInvitation:jsonInvitation["numStatusInvitation"].intValue,utilisateur: Utilisateur(json: jsonUtilisateur))
    }
    func Save(_ completion: @escaping ServiceResponse) {
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "CREATE"
        params["ENTITY"] = "Utilisateur_RendezVous"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = String(NSDate().timeIntervalSince1970)
        params["numInvite"] = "\(self.numInvite)"
        params["numRendezVous"] = "\(self.numRendezVous)"
        params["numStatusInvitation"] = "\(self.numStatusInvitation)"
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["numInvite"]!)\(params["numRendezVous"]!)\(params["numStatusInvitation"]!)onmangeensembleb20")
        print("enregistrement des types de cuisine")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["numInvite"]!)\(params["numRendezVous"]!)\(params["numStatusInvitation"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    func accept(_ completion: @escaping ServiceResponse) {
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "UPDATE"
        params["ENTITY"] = "InvitationAccept"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = String(NSDate().timeIntervalSince1970)
        params["numInvite"] = "\(self.numInvite)"
        params["numRendezVous"] = "\(self.numRendezVous)"
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["numInvite"]!)\(params["numRendezVous"]!)onmangeensembleb20")
        print("enregistrement des types de cuisine")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["numInvite"]!)\(params["numRendezVous"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    func reject(_ completion: @escaping ServiceResponse) {
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "UPDATE"
        params["ENTITY"] = "InvitationReject"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = String(NSDate().timeIntervalSince1970)
        params["numInvite"] = "\(self.numInvite)"
        params["numRendezVous"] = "\(self.numRendezVous)"
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["numInvite"]!)\(params["numRendezVous"]!)onmangeensembleb20")
        print("enregistrement des types de cuisine")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["numInvite"]!)\(params["numRendezVous"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }
    func getStatusSymbol()->String
    {
        print("Invitation:getStatusSymbol")
        switch self.numStatusInvitation {
        case 1:
            return "?"
        case 2:
            return "A"
        case 3:
            return "X"
        default:
            return ""
        }
    }
}
