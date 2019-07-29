//
//  MatchingPeopleView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 26/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import UIKit

class MatchingPeopleView: UIView
{
    var parentControleur : RamonViewController?
    
    @IBOutlet weak var GuestRankedTable: GuestRankedTableView!
    // liste des invités dans le groupe
    @IBOutlet weak var guestInvitedCollection: GuestCollectionView!
    
    func show(controleur:RamonViewController)
    {
        print("MatchingPeopleView:show")
        self.isHidden = false
        self.parentControleur = controleur
        self.GuestRankedTable.currentControleur = (controleur as! CreateGroupViewController)
        self.guestInvitedCollection.currentControleur = (controleur as! CreateGroupViewController)
        
    // création du lien entre la collection des invités et la source de données des invités
    self.guestInvitedCollection.delegate = self.guestInvitedCollection
    self.guestInvitedCollection.dataSource = self.guestInvitedCollection
  
    
    // création du lien entre la liste des gens pouvant être invité et la table permettant de les choisir
    self.GuestRankedTable.delegate = self.GuestRankedTable
    self.GuestRankedTable.dataSource = self.GuestRankedTable
    
    ListeMatchingUtilisateurs.subscribe(vue: self.GuestRankedTable)
    ListeMatchingUtilisateurs.load(controleur: controleur)
    }
    
}
