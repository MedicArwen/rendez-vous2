//
//  NewProfile.swift
//  rendez-vous
//
//  Created by Thierry BRU on 09/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import UIKit
import SwiftHash

class NewProfile
{
    static var SharedInstance = NewProfile()
    var urlImage = ""
    var uiImage : UIImage?
    var catchPhrase = ""
    var description = ""
    var centresInterets = [CentreInteretUtilisateur]()
    var typeCuisines = [StyleCuisineUtilisateur]()
    var pseudo = ""
    var latitude = 0.0
    var longitude = 0.0
    func createUtilisateur(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = ConnectedRamonUser.sharedInstance!.apiKey
        params["CMD"] = "CREATE"
        params["ENTITY"] = "Utilisateur"
        params["NUMRAMONUSER"] = "\(ConnectedRamonUser.sharedInstance!.ramonUser.idRamonUser)"
        params["TIMESTAMP"] = timestamp
        params["catchPhrase"] = self.catchPhrase.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
        params["description"] = self.description.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
        params["latitude"] = "\(self.latitude)"
        params["longitude"] = "\(self.longitude)"
        params["numGenre"] = "\(ConnectedRamonUser.sharedInstance!.ramonUser.numGenre)"
        params["pseudonyme"] = ConnectedRamonUser.sharedInstance!.ramonUser.pseudonyme
        params["urlPhoto"] = self.urlImage
        
        
        
        
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["catchPhrase"]!)\(params["dateNaissance"]!)\(params["description"]!)\(params["latitude"]!)\(params["longitude"]!)\(params["numGenre"]!)\(params["pseudonyme"]!)\(params["urlPhoto"]!)onmangeensembleb20")
        print("registerRDVUtilisateur")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["catchPhrase"]!)\(params["dateNaissance"]!)\(params["description"]!)\(params["latitude"]!)\(params["longitude"]!)\(params["numGenre"]!)\(params["pseudonyme"]!)\(params["urlPhoto"]!)onmangeensembleb20")
        print(RendezVousWebService.sharedInstance.webServiceCalling(params, completion))
        
    }

}
