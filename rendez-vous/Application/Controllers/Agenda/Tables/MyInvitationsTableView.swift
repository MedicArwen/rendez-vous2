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
    fileprivate var indiceSuscribedView = 0
}
extension MyInvitationsTableView:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard ListeRendezVousAsConvive.sharedInstance != nil else {
            print("MyInvitationsTableView:count - aucune liste ListeRendezVousAsConvive trouvée")
            return 0
        }
        print("MyInvitationsTableView:count - \(ListeRendezVousAsConvive.sharedInstance!.liste.count) invitation recue(s)")
        return ListeRendezVousAsConvive.sharedInstance!.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("MyInvitationsTableView: update the cell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRendezVousConviveCell", for: indexPath) as! MyInvitationsTableViewCell
        cell.update(rendezvous: ListeRendezVousAsConvive.sharedInstance!.liste[indexPath.row],controleur: self.currentControleur!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         print("MyRendezVousTableView: commit editingStyle")
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
             print("MyInvitationsTableView: editingStyle = .delete")
            ListeRendezVousAsConvive.remove(controleur: currentControleur!, indexPath: indexPath)
        }
    }
    
}
extension MyInvitationsTableView:WebServiceLinkable
{
    func refresh() {
        print("MyInvitationsTableView: refresh")
        self.reloadData()
    }
    var indice: Int {
        get {
            return indiceSuscribedView
        }
        set {
            indiceSuscribedView = newValue
        }
    }
    
}
