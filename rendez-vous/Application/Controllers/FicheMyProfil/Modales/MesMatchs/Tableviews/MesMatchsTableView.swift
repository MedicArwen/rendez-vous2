//
//  MesMatchsTableView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 07/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class MesMatchsTableView: UITableView {
    var currentControleur:RamonViewController?
    var mesMatchs : ListeMatchingUtilisateurs?
    fileprivate var indiceSuscribedView = 0
}
extension MesMatchsTableView:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard mesMatchs != nil else {
            print("MesMatchsTableView:Count - mesMatchs = nil")
            return 0
        }
        print("MesMatchsTableView:Count - mesMatchs != nil")
        return mesMatchs!.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("update MesMatchsTableViewCell n°#\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMatchCell", for: indexPath) as! MesMatchsTableViewCell
        cell.update(rankedUtilisateur: mesMatchs!.liste[indexPath.row],controleur:self.currentControleur!)
        return cell
    }
    
}
extension MesMatchsTableView:WebServiceLinkable
{
    func refresh() {
        print("MesMatchsTableView:refresh")
        print(" il y a \(mesMatchs!.liste.count) personne(s) qui matche(nt)")
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

