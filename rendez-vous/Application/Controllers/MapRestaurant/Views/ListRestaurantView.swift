//
//  ListRestaurantUIView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 18/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class ListRestaurantView: UIView {

    var currentControleur: UIViewController?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension ListRestaurantView:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("je compte les restaurants")
        if RendezVousApplication.isRestaurantListReady()
        {
            return RendezVousApplication.getListeRestaurants().count
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("update the cell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantTableCell", for: indexPath) as! RestaurantTableViewCell
        cell.update(restaurant: RendezVousApplication.getListeRestaurants()[indexPath.row],controleur:self.currentControleur!)
        return cell
    }
    
    
}
