//
//  GuestRankedTableView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class GuestRankedTableView: UITableView {
    var currentControleur:CreateGroupViewController?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension GuestRankedTableView:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RendezVousApplication.getListeMatching().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("update the cell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestRankedCell", for: indexPath) as! GuestRankedTableViewCell
        cell.update(rankedUtilisateur: RendezVousApplication.getListeMatching()[indexPath.row],controleur:self.currentControleur!)
        return cell
    }
  
}
extension GuestRankedTableView:WebServiceLinkable
{
    func refresh() {
        self.reloadData()
    }
    
    
}
