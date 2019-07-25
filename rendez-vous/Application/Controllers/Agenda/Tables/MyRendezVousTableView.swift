//
//  MyRendezVousHostedUITableView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftHash

class MyRendezVousTableView: UITableView {
    var currentControleur : RamonViewController?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension MyRendezVousTableView:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RendezVousApplication.getHostedRendezVous().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("update the cell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRendezVousHostedCell", for: indexPath) as! MyRendezVousTableViewCell
        cell.update(rendezvous: RendezVousApplication.getHostedRendezVous()[indexPath.row],controleur: self.currentControleur!)
        //cell.update(rankedUtilisateur: RendezVousApplication.getHostedRendezVous()[indexPath.row],controleur:self.currentControleur!)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
           ListeRendezVousAsHote.remove(controleur: currentControleur!, indexPath: indexPath)
        }
    }
    
}
extension MyRendezVousTableView:WebServiceLinkable
{
    func refresh() {
        self.reloadData()
    }
    
    
}
