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
    fileprivate var indiceSuscribedView = 0
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
        guard currentControleur!.listeMesMatchs != nil else {
            print("GuestRankedTableView:Count - currentControleur!.listeMesMatchs  = nil")
            return 0
        }
        print("GuestRankedTableView:Count - currentControleur!.listeMesMatchs  != nil")
        return currentControleur!.listeMesMatchs!.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("update GuestRankedTableViewCell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestRankedCell", for: indexPath) as! GuestRankedTableViewCell
        cell.update(rankedUtilisateur: currentControleur!.listeMesMatchs!.liste[indexPath.row],controleur:self.currentControleur!,indice:indexPath.row)
        return cell
    }
  
}
extension GuestRankedTableView:WebServiceLinkable
{
    func refresh() {
        print("GuestRankedTableView:refresh")
        guard currentControleur!.listeMesMatchs != nil else {
            print("-> liste des personnes qui matchent non  chargée")
            return
        }
        print("->il y a \(currentControleur!.listeMesMatchs!.liste.count) personne(s) qui matche(nt)")
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
