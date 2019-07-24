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

class MyRendezVousHostedUITableView: UITableView {
    var currentControleur : UIViewController?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension MyRendezVousHostedUITableView:UITableViewDelegate,UITableViewDataSource
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
           
            RendezVousApplication.sharedInstance.listeRendezVousCrees!.events[indexPath.row].cancel{ (json: JSON?, error: Error?) in
                guard error == nil else {
                    print("Une erreur est survenue")
                    return
                }
                if let json = json {
                    print(json)
                    if json["returnCode"].intValue != 200
                    {
                        AuthWebService.sendAlertMessage(vc: self.currentControleur!, returnCode: json["returnCode"].intValue)
                    }
                    else
                    {

                        RendezVousApplication.sharedInstance.listeRendezVousCrees!.events.remove(at: indexPath.row)
                        self.reloadData()
                    }
                }
            }
            
        }
    }
    
}
extension MyRendezVousHostedUITableView:WebServiceLinkable
{
    func refresh() {
        self.reloadData()
    }
    
    
}
