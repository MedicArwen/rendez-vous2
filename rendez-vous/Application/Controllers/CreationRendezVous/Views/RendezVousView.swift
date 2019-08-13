//
//  RendezVousView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 26/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class RendezVousView: UIView{
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    // datePicker permettant de choisir la date du rendez-vous pris dans le restaurant dont la fiche est visible
    @IBOutlet weak var datePicker : UIDatePicker!
    // fiche du restaurant sélectionné au préalable pour le rendez-vous
    @IBOutlet weak var fiche : RestaurantView!
    //vue contenant le choix de la date (cela permet de cacher cette vue)
    @IBOutlet weak var choixDateView : UIView!
    @IBOutlet weak var contrainteHauteur : NSLayoutConstraint!
    
    private var currentControleur : CreateGroupViewController?
    fileprivate var indiceSuscribedView = 0
    
    func update(restaurant:Restaurant, controleur:CreateGroupViewController)
    {
        print("RendezVousView:update (\(restaurant.raisonSociale))")
        fiche.update(restaurant: restaurant)
        currentControleur = controleur
        
    }
    func setRendezVous(rendezVous:RendezVous)
    {
        // quand on a un rendez-vous de créé, on cache le choix d'une date et on affiche la date du rendez-vous dans la fiche
        print("RendezVousView:setRendezVous(id: \(rendezVous.idRendezVous))")
        fiche.setDate(rendezVous:rendezVous)
        self.choixDateView.isHidden = true
        self.contrainteHauteur.constant = CGFloat(integerLiteral: 0)
    }
    
    
    @IBAction func onClickCreateGroupe(_ sender: UIButton) {
        print("RendezVousView:onClickCreateGroupe")
       // RendezVous.sharedInstance = RendezVous(idRendezVous: 0, numUtilisateurSource: Utilisateur.sharedInstance!.idUtilisateur, date: "\(datePicker.date)", numStatusRendezVous: 1, numRestaurant: Restaurant.sharedInstance!.idRestaurant,hote:Utilisateur.sharedInstance!,restau: Restaurant.sharedInstance!)
       // ListeRendezVousAsHote.append(rendezVous: RendezVous.sharedInstance!)
        let rdv = RendezVous(idRendezVous: 0, numUtilisateurSource: Utilisateur.sharedInstance!.idUtilisateur, date: "\(datePicker.date)", numStatusRendezVous: 1, numRestaurant: Restaurant.sharedInstance!.idRestaurant,hote:Utilisateur.sharedInstance!,restau: Restaurant.sharedInstance!)
        //RendezVous.sharedInstance = RendezVous(idRendezVous: 0, numUtilisateurSource: Utilisateur.sharedInstance!.idUtilisateur, date: "\(datePicker.date)", numStatusRendezVous: 1, numRestaurant: Restaurant.sharedInstance!.idRestaurant,hote:Utilisateur.sharedInstance!,restau: Restaurant.sharedInstance!)
        currentControleur!.currentRendezVous = rdv
        RendezVous.append(rendezVous:rdv ,dataSource: self)
    }
}
extension  RendezVousView:WebServiceLinkable {
    func refresh() {
        print("RendezVousView:refresh")
        guard currentControleur!.currentRendezVous != nil else {
            print("->rendez-vous is empty")
            return
        }
        if self.choixDateView.isHidden == false
        {
            print("-> first refresh")
            setRendezVous(rendezVous: currentControleur!.currentRendezVous!)
            currentControleur!.viewMatchingPeople.show(controleur: self.currentControleur!)
        }
        else
        {
            print("-> no refresh")
        }
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
extension RendezVousView:RendezVousDataSource
{
    func rendezVousOnLoaded(rendezVous: RendezVous) {
        print("RendezVousView:RendezVousDataSource:rendezVousOnLoaded - NOT IMPLEMENTED")
    }
    func rendezVousOnLoaded(lesRendezVous:ListeRendezVous)
    {
        print("ListeRendezVousAsHote:RendezVousDataSource:rendezVousOnLoaded not implemented")
    }
    func rendezVousOnUpdated() {
        print("RendezVousView:RendezVousDataSource:rendezVousOnUpdated - NOT IMPLEMENTED")
    }
    
    func rendezVousOnDeleted() {
        print("RendezVousView:RendezVousDataSource:rendezVousOnDeleted - NOT IMPLEMENTED")
    }
    
    func rendezVousOnCancelled()
    {
          print("RendezVousView:RendezVousDataSource:rendezVousOnCancelled - NOT IMPLEMENTED")
    }
    func rendezVousOnCreated(rendezVous: RendezVous) {
        print("RendezVousView:RendezVousDataSource:rendezVousOnCreated")
        currentControleur!.currentRendezVous = rendezVous
        setRendezVous(rendezVous: currentControleur!.currentRendezVous!)
        ListeSelectionUtilisateur.sharedInstance.autoInvitation(rendezVous: currentControleur!.currentRendezVous!, dataSource: self)
    }
    
    func rendezVousOnNotFoundRendezVous() {
        print("RendezVousView:RendezVousDataSource:rendezVousOnNotFoundRendezVous - NOT IMPLEMENTED")
    }
    
    func rendezVousOnWebServiceError(code: Int) {
        print("RendezVousView:RendezVousDataSource:rendezVousOnWebServiceError")
        AlerteBoxManager.sendAlertMessage(vc: self.currentControleur!, returnCode: code)
    }
    
}
extension RendezVousView:InvitationDataSource
{
    func invitationOnLoaded(invitation: Invitation) {
        print("RendezVousView:InvitationDataSource:invitationOnLoaded")
    }
    
    func invitationOnLoaded(invitations: ListeInvitationsAsConvive) {
        print("RendezVousView:InvitationDataSource:invitationOnLoaded")
    }
    
    func invitationOnUpdated() {
        print("RendezVousView:InvitationDataSource:invitationOnUpdated")
    }
    
    func invitationOnDeleted() {
        print("RendezVousView:InvitationDataSource:invitationOnDeleted")
    }
    
    func invitationOnCancelled() {
        print("RendezVousView:InvitationDataSource:invitationOnDeleted")
    }
    
    func invitationOnRejected() {
        print("RendezVousView:InvitationDataSource:invitationOnDeleted")
    }
    
    func invitationOnAccepted() {
        print("RendezVousView:InvitationDataSource:invitationOnDeleted")
    }
    
    func invitationOnCreated(invitation: Invitation) {
        print("RendezVousView:InvitationDataSource:invitationOnDeleted")
    }
    
    func invitationOnNotFoundInvitation() {
        print("RendezVousView:InvitationDataSource:invitationOnDeleted")
    }
    
    func invitationOnWebServiceError(code: Int) {
        print("RendezVousView:InvitationDataSource:invitationOnDeleted")
    }
    
    
}
