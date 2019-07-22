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

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.raisonSociale.text = currentRestaurant!.raisonSociale
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/places/\(currentRestaurant!.urlPhoto)")!
        //  print(url)
        self.photoRestaurant.af_setImage(withURL: url)
        self.photoRestaurant.layer.cornerRadius = 10.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickClose(_ sender: RoundButtonUIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
