//
//  AgendaViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 23/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class AgendaViewController: RamonViewController {
    var selectedRendezVous : RendezVous?
    @IBOutlet weak var tableRendezVousHosted: MyRendezVousTableView!
    @IBOutlet weak var tableInvitationsReceived: MyInvitationsTableView!
    
  /*  var currentRendezVous:RendezVous?
    var currentRestaurant:Restaurant?*/
    
    
    
    
    override func viewDidLoad() {
        print("AgendaViewController:viewDidLoad")
        super.viewDidLoad()
        // on affiche la vue des rendez-vous créés par défaut
        tableRendezVousHosted.isHidden = false
        tableInvitationsReceived.isHidden = true
        
        //confifuration de la table des rendez-vous créés
        self.tableRendezVousHosted.currentControleur = self
        self.tableRendezVousHosted.delegate = self.tableRendezVousHosted
        self.tableRendezVousHosted.dataSource = self.tableRendezVousHosted
        ListeRendezVous.subscribe(vue: self.tableRendezVousHosted)
        
        //Configuration de la table des invitations recues.
        self.tableInvitationsReceived.currentControleur = self
        self.tableInvitationsReceived.delegate = self.tableInvitationsReceived
        self.tableInvitationsReceived.dataSource = self.tableInvitationsReceived
        ListeInvitationsAsConvive.subscribe(vue: self.tableInvitationsReceived)
       // ListeRendezVousAsConvive.load(controleur: self)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("AgendaViewController:WillAppear")
        //ListeRendezVousAsHote.load(controleur: self)
        RendezVous.load(dataSource: self)
        //Invitation.load(datasource: self)
        // Do any additional setup after loading the view.
    }
    //
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onChangedTab(_ sender: UISegmentedControl) {
        print("AgendaViewController:onChangedTab")
        if sender.selectedSegmentIndex == 0
        {
            print("-> Afficher les invitations envoyées")
            tableRendezVousHosted.isHidden = false
            tableInvitationsReceived.isHidden = true
            //ListeRendezVousAsHote.load(controleur: self)
            RendezVous.load(dataSource: self)
        }
        else
        {
            print("-> Afficher les invitations recue")
            tableRendezVousHosted.isHidden = true
            tableInvitationsReceived.isHidden = false
           // ListeRendezVousAsConvive.load(controleur: self)
            Invitation.load(datasource: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("AgendaViewController:prepare")
        if segue.identifier == "showUpdateGroup"
        {
            let dest = segue.destination as! CreateGroupViewController
            print("AgendaViewController:prepare (segue.identifier = showUpdateGroup)")
            print("-> rendez vous selectionné: \(self.selectedRendezVous!.idRendezVous)")
            dest.currentRendezVous = self.selectedRendezVous!
            dest.mode = "update"
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("MapRestaurantViewController:viewWillDisappear")
        print(self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("MapRestaurantViewController:viewDidDisappear")
        print(self)
    }
}
extension AgendaViewController:RendezVousDataSource
{
    func rendezVousOnLoaded(rendezVous: RendezVous) {
        print("AgendaViewController:RendezVousDataSource:rendezVousOnLoaded - NOT IMPLEMENTED")
    }
    
    func rendezVousOnLoaded(lesRendezVous: ListeRendezVous) {
        print("AgendaViewController:RendezVousDataSource:rendezVousOnLoaded(LIST")
        ListeRendezVous.sharedInstance = lesRendezVous
        ListeRendezVous.reloadViews()
    }
    
    func rendezVousOnUpdated() {
        print("AgendaViewController:RendezVousDataSource:rendezVousOnUpdated - NOT IMPLEMENTED")
    }
    
    func rendezVousOnDeleted() {
        print("AgendaViewController:RendezVousDataSource:rendezVousOnDeleted - NOT IMPLEMENTED")
    }
    
    func rendezVousOnCancelled() {
        print("AgendaViewController:RendezVousDataSource:rendezVousOnCancelled - NOT IMPLEMENTED")
    }
    
    func rendezVousOnCreated(rendezVous: RendezVous) {
        print("AgendaViewController:RendezVousDataSource:AgendaViewController - NOT IMPLEMENTED")
    }
    
    func rendezVousOnNotFoundRendezVous() {
        print("AgendaViewController:RendezVousDataSource:rendezVousOnLoaded")
    }
    
    func rendezVousOnWebServiceError(code: Int) {
        print("AgendaViewController:RendezVousDataSource:rendezVousOnLoaded")
    }
    
    
}
extension AgendaViewController:InvitationDataSource
{
    func invitationOnLoaded(invitation: Invitation) {
        print("AgendaViewController:InvitationDataSource::invitationOnLoaded")
        ListeInvitationsAsConvive.reloadViews()
    }
    func invitationOnLoaded(invitations: ListeInvitationsAsConvive) {
        print("GuestRankedTableViewCell:InvitationDataSource:invitationOnLoaded(LIST) ")
        ListeInvitationsAsConvive.sharedInstance = invitations
        ListeInvitationsAsConvive.reloadViews()
    }
    func invitationOnUpdated() {
        print("AgendaViewController:InvitationDataSource:invitationOnUpdated - NOT IMPLEMENTED")
    }
    
    func invitationOnDeleted() {
        print("AgendaViewController:InvitationDataSource:invitationOnDeleted - NOT IMPLEMENTED")
    }
    
    func invitationOnCancelled() {
        print("AgendaViewController:InvitationDataSource:invitationOnCancelled - NOT IMPLEMENTED")
    }
    
    func invitationOnRejected() {
        print("AgendaViewController:InvitationDataSource:invitationOnRejected - NOT IMPLEMENTED")
    }
    
    func invitationOnAccepted() {
        print("AgendaViewController:InvitationDataSource:invitationOnAccepted - NOT IMPLEMENTED")
    }
    
    func invitationOnCreated(invitation:Invitation) {
        print("AgendaViewController:InvitationDataSource:invitationOnCreated - NOT IMPLEMENTED")
    }
    
    func invitationOnNotFoundInvitation() {
        print("AgendaViewController:InvitationDataSource:invitationOnNotFoundInvitation - NOT IMPLEMENTED")
    }
    
    func invitationOnWebServiceError(code: Int) {
        print("AgendaViewController:InvitationDataSource:invitationOnWebServiceError")
        AlerteBoxManager.sendAlertMessage(vc: self, returnCode: code)
    }
    
    
}
