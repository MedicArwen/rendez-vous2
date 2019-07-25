//
//  MyInvitationsTableView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 25/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftHash
import SwiftyJSON

class MyInvitationsTableView: UITableView {
    var currentControleur : RamonViewController?
    
}
extension MyInvitationsTableView:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RendezVousApplication.getInvitationsRendezVous().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("update the cell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRendezVousConviveCell", for: indexPath) as! MyInvitationsTableViewCell
        cell.update(rendezvous: RendezVousApplication.getInvitationsRendezVous()[indexPath.row],controleur: self.currentControleur!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            ListeRendezVousAsConvive.remove(controleur: currentControleur!, indexPath: indexPath)
        }
    }
    
}
extension MyInvitationsTableView:WebServiceLinkable
{
    func refresh() {
        self.reloadData()
    }
    
    
}
