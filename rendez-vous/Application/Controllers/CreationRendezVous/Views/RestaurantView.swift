//
//  RestaurantView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 26/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RestaurantView: RoundUIView {

    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var raisonSociale: UILabel!
    @IBOutlet weak var pourcentReduction: RoundUILabel!
    @IBOutlet weak var noteRestaurant: UILabel!
    @IBOutlet weak var adresseRestaurant: UILabel!
    @IBOutlet weak var codePostalRestaurant: UILabel!
    @IBOutlet weak var villeRestaurant: UILabel!
    @IBOutlet weak var telephoneRestaurant: UILabel!
    @IBOutlet weak var dateRendezVous: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func update(restaurant:Restaurant)
    {
        print("RestaurantView:update(\(restaurant.raisonSociale))")
        self.raisonSociale.text = restaurant.raisonSociale
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/places/\(restaurant.urlPhoto)")!
        self.photoRestaurant.af_setImage(withURL: url)
        self.photoRestaurant.layer.cornerRadius = 10.0
        self.pourcentReduction.text = "-\(restaurant.pourcentReduction)%"
        self.noteRestaurant.text = "9/10"
        self.adresseRestaurant.text = restaurant.adressse
        self.codePostalRestaurant.text = restaurant.codePostal
        self.villeRestaurant.text = restaurant.ville
        self.telephoneRestaurant.text = restaurant.telephone
    }
    func setDate(rendezVous:RendezVous)
    {
        print("RestaurantView:setDate(id: \(rendezVous.idRendezVous))")
        // quand on a un rendez-vous de créé, on cache le choix d'une date et on affiche la date du rendez-vous dans la fiche
        self.dateRendezVous.text = "\(rendezVous.getDay()) - \(rendezVous.getHour())"
        self.dateRendezVous.isHidden = false
    }
}
