//
//  ListeSelectionUtilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 08/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
class ListeSelectionUtilisateur
{
    static var sharedInstance = ListeSelectionUtilisateur()
    var listeInvites = [RankedUtilisateur]()
    
    func addToSelection(utilisateur:RankedUtilisateur)
    {
        print("ListeMatchingUtilisateur:addToSelection")
        
        self.listeInvites.append(utilisateur)
        print("-> il y a \(self.listeInvites.count) utilisateurs invités")
    }
    func inSelection(utilisateur:RankedUtilisateur)->Bool
    {
        var found = false
        for item in ListeSelectionUtilisateur.sharedInstance.listeInvites
        {
            if item == utilisateur
            {
                found = true
            }
        }
        return found
    }
    func autoInvitation(rendezVous:RendezVous, dataSource:InvitationDataSource)
    {
        var invitation: Invitation?
        for item in self.listeInvites
        {
            let utilisateur = item as Utilisateur
            invitation = Invitation(utilisateur: utilisateur, rendezVous: rendezVous, numStatusInvitation: 1)
            invitation!.create(datasource: dataSource)
            rendezVous.addInvitation(invitation: invitation!)
        }
        self.listeInvites.removeAll()
    }
}
