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
    fileprivate var indiceSuscribedView = 0
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
        guard ListeRendezVous.sharedInstance != nil else {
            print("MyRendezVousTableView: count - aucune liste ListeRendezVousAsHote trouvée")
            return 0
        }
        print("MyRendezVousTableView: count - \(ListeRendezVous.sharedInstance!.liste.count) rendez-vous créé(s)")
        return ListeRendezVous.sharedInstance!.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("MyRendezVousTableView: update cellune n°#\(indexPath.row) du tableau de mes rendez-vous")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRendezVousHostedCell", for: indexPath) as! MyRendezVousTableViewCell
        cell.update(rendezvous: ListeRendezVous.sharedInstance!.liste[indexPath.row],controleur: self.currentControleur!)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("MyRendezVousTableView: commit editingStyle")
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            print("MyRendezVousTableView: editingStyle == .delete")
            //Utilisateur.remove(indice: indexPath.row)
            RendezVous.remove(indice: indexPath.row)
        }
    }
    
}
extension MyRendezVousTableView:WebServiceLinkable
{
    func refresh() {
          print("MyRendezVousTableView:refresh")
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
