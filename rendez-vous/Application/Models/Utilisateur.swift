//
//  Utilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
import Foundation
import SwiftyJSON
import MapKit


class Utilisateur {
     var idUtilisateur = 0
    var numRamonUser = 0
    var urlImage = ""
    var uiImage : UIImage?
    var catchPhrase = ""
    var description = ""
    var pseudo = ""
    var latitude = 0.0
    var longitude = 0.0
    
   func construct(idUtilisateur: Int,numRamonUser:Int,urlImage:String,catchPhrase:String,description:String,pseudo: String,latitude:Double,longitude:Double) {
    print("Utilisateur:init pseudo:\(pseudo)")
     self.idUtilisateur = idUtilisateur
        self.numRamonUser = numRamonUser
        self.urlImage = urlImage
        self.catchPhrase = catchPhrase
        self.description = description
        self.pseudo = pseudo
        self.latitude = latitude
        self.longitude = longitude
        print("Instantiation de l'utilisateur \(self.pseudo) id:  \(self.idUtilisateur) num: \(self.numRamonUser)")

    }
    init(json:JSON) {
        self.construct(idUtilisateur:json["idUtilisateur"].intValue,
                  numRamonUser:json["libelle"].intValue,
                  urlImage:json["urlPhoto"].stringValue,
                  catchPhrase:json["catchPhrase"].stringValue,
                  description:json["description"].stringValue,
                  pseudo:json["pseudonyme"].stringValue,
                  latitude:json["latitude"].doubleValue,
                  longitude:json["longitude"].doubleValue
        )
    }
    func debugPrint()
    {
        print("idUtilisateur :\(self.idUtilisateur)")
        print("numRamonUser :\(self.numRamonUser)")
        print("urlImage :\(self.urlImage)")
        print("catchPhrase :\(self.catchPhrase)")
        
        print("description :\(self.description)")
        print("pseudo :\(self.pseudo)")
        print("pseudo :\(self.latitude)")
        print("longitude :\(self.longitude)")
    }

    
}

