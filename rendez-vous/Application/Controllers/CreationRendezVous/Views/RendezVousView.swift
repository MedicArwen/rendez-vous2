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
    
    private var parentControleur : RamonViewController?
    fileprivate var indiceSuscribedView = 0
    
    func update(restaurant:Restaurant, controleur:RamonViewController)
    {
        print("RendezVousView:update (\(restaurant.raisonSociale))")
        fiche.update(restaurant: restaurant)
        parentControleur = controleur
        
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
        RendezVous.append(rendezVous: RendezVous(idRendezVous: 0, numUtilisateurSource: Utilisateur.sharedInstance!.idUtilisateur, date: "\(datePicker.date)", numStatusRendezVous: 1, numRestaurant: Restaurant.sharedInstance!.idRestaurant,hote:Utilisateur.sharedInstance!,restau: Restaurant.sharedInstance!))
        
    }
}
extension  RendezVousView:WebServiceLinkable {
    func refresh() {
        print("RendezVousView:refresh")
        guard RendezVous.sharedInstance != nil else {
            print("->rendez-vous is empty")
            return
        }
        if self.choixDateView.isHidden == false
        {
            print("-> first refresh")
            setRendezVous(rendezVous: RendezVous.sharedInstance!)
            let controleur = self.parentControleur as! CreateGroupViewController
            controleur.viewMatchingPeople.show(controleur: self.parentControleur!)
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
    func rendezVousOnCreated() {
        print("RendezVousView:RendezVousDataSource:rendezVousOnCreated")
    }
    
    func rendezVousOnNotFoundRendezVous() {
        print("RendezVousView:RendezVousDataSource:rendezVousOnNotFoundRendezVous - NOT IMPLEMENTED")
    }
    
    func rendezVousOnWebServiceError(code: Int) {
        print("RendezVousView:RendezVousDataSource:rendezVousOnWebServiceError - NOT IMPLEMENTED")
    }
    
}
