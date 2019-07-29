//
//  RestaurantCollectionViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 16/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import AlamofireImage
class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var raisonSociale: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var reduction: RoundUILabel!
    
    var restaurant:Restaurant?
    var parentController:UIViewController?
    
    func update(restaurant:Restaurant, controleur:UIViewController) {
        print("RestaurantCollectionViewCell:update (id resto:\(restaurant.idRestaurant))")
        self.restaurant = restaurant
        self.parentController = controleur
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/places/\(restaurant.urlPhoto)")!
        self.photoRestaurant.af_setImage(withURL: url)
        self.photoRestaurant.layer.cornerRadius = 10.0
        self.layer.cornerRadius = 10.0
        self.raisonSociale.text = restaurant.raisonSociale
        self.note.text = "8/10"
        self.reduction.text = "-\(restaurant.pourcentReduction)%"
    }
    
    @IBAction func onClickCall(_ sender: UIButton) {
        print("RestaurantCollectionViewCell:onClickCall (restaurant \(self.restaurant!.raisonSociale))")
    UIApplication.shared.open(URL(string:"tel://\(restaurant!.telephone)")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func onClickInfo(_ sender: UIButton) {
        print("RestaurantCollectionViewCell:onClickInfo  (restaurant \(self.restaurant!.raisonSociale))")
        self.parentController!.performSegue(withIdentifier: "showAboutRestaurant", sender: self.parentController!)
    }
    @IBAction func onClickInvite(_ sender: Any) {
        print("RestaurantCollectionViewCell:onClickInvite (restaurant \(self.restaurant!.raisonSociale))")
        self.parentController!.performSegue(withIdentifier: "showCreateGroup", sender: self.parentController!)
        
    }
    
}
