//
//  FavoriteTableView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 13/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class FavoriteTableView: UITableView {
    var currentControleur : MesFavorisViewController?
}
extension FavoriteTableView:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard Utilisateur.sharedInstance!.friendList != nil else {
            return 0
        }
        return Utilisateur.sharedInstance!.friendList!.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("update FavoriteTableViewCell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.update(utilisateur: Utilisateur.sharedInstance!.friendList!.liste[indexPath.row],controleur:self.currentControleur!)
        return cell
    }
    
    
}
