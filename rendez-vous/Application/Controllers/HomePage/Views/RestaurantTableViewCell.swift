//
//  RestaurantTableViewCell.swift
//  rendez-vous
//
//  Created by Thierry BRU on 18/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var raisonSociale: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var reduction: RoundUILabel!
    
    var restaurant:Restaurant?
    var parentController:UIViewController?
    
    func update(restaurant:Restaurant,controleur:UIViewController) {
        
        self.restaurant = restaurant
        self.parentController = controleur
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/places/\(restaurant.urlPhoto)")!
        //  print(url)
        self.photoRestaurant.af_setImage(withURL: url)
        self.photoRestaurant.layer.cornerRadius = 10.0
        self.layer.cornerRadius = 10.0
        self.raisonSociale.text = restaurant.raisonSociale
        self.note.text = "8/10"
        self.reduction.text = "-\(restaurant.pourcentReduction)%"
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowOffset = CGSize(width: 5, height: 5)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickCall(_ sender: UIButton) {
        print("click Call restaurant \(self.restaurant!.raisonSociale)")
        UIApplication.shared.open(URL(string:"tel://\(restaurant!.telephone)")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func onClickInfo(_ sender: UIButton) {
        print("click Info restaurant \(self.restaurant!.raisonSociale)")
        self.parentController!.performSegue(withIdentifier: "showAboutRestaurant", sender: self.parentController!)
    }
    @IBAction func onClickInvite(_ sender: Any) {
        print("click Invite au restaurant \(self.restaurant!.raisonSociale)")
        self.parentController!.performSegue(withIdentifier: "showCreateGroup", sender: self.parentController!)
    }
}
