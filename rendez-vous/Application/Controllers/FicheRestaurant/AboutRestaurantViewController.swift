//
//  AboutRestaurantViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 18/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import AlamofireImage

class AboutRestaurantViewController: UIViewController {
    var currentRestaurant : Restaurant?
    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var raisonSociale: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("AboutRestaurantViewController - viewWillAppear")
        self.raisonSociale.text = currentRestaurant!.raisonSociale
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/places/\(currentRestaurant!.urlPhoto)")!
        //  print(url)
        self.photoRestaurant.af_setImage(withURL: url)
        self.photoRestaurant.layer.cornerRadius = 10.0
    }

    @IBAction func onClickClose(_ sender: RoundButtonUIButton) {
        print("AboutRestaurantViewController - onClickClose")
        self.dismiss(animated: true, completion: nil)
    }
    
}
