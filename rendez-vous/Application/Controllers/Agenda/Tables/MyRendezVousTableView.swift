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

        print("MyRendezVousTableView: count - \(ListeRendezVous.sharedInstance.liste.count) rendez-vous créé(s)")
        return ListeRendezVous.sharedInstance.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("MyRendezVousTableView: update cellune n°#\(indexPath.row) du tableau de mes rendez-vous")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRendezVousHostedCell", for: indexPath) as! MyRendezVousTableViewCell
        cell.update(rendezvous: ListeRendezVous.sharedInstance.liste[indexPath.row],controleur: self.currentControleur!)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("MyRendezVousTableView: commit editingStyle")
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            print("MyRendezVousTableView: editingStyle == .delete")
            //Utilisateur.remove(indice: indexPath.row)
            RendezVous.remove(indice: indexPath.row, dataSource: self)
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
extension MyRendezVousTableView:RendezVousDataSource
{
    func rendezVousOnLoaded(rendezVous: RendezVous) {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnLoaded NOT IMPLEMENTED")
    }
    
    func rendezVousOnLoaded(lesRendezVous: ListeRendezVous) {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnLoaded NOT IMPLEMENTED")
    }
    
    func rendezVousOnUpdated() {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnUpdated NOT IMPLEMENTED")
    }
    
    func rendezVousOnDeleted() {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnDeleted NOT IMPLEMENTED")
    }
    
    func rendezVousOnCancelled() {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnCancelled NOT IMPLEMENTED")
    }
    
    func rendezVousOnCreated(rendezVous: RendezVous) {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnCreated NOT IMPLEMENTED")
    }
    
    func rendezVousOnNotFoundRendezVous() {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnNotFoundRendezVous NOT IMPLEMENTED")
    }
    
    func rendezVousOnWebServiceError(code: Int) {
        print("yInvitationsTableView:RendezVousDataSource:rendezVousOnWebServiceError NOT IMPLEMENTED")
    }
}

