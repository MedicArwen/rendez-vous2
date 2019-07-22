//
//  CreateGroupViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class CreateGroupViewController: UIViewController {

    
    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var raisonSociale: UILabel!
    @IBOutlet weak var pourcentReduction: RoundUILabel!
    @IBOutlet weak var noteRestaurant: UILabel!
    @IBOutlet weak var adresseRestaurant: UILabel!
    @IBOutlet weak var codePostalRestaurant: UILabel!
    @IBOutlet weak var villeRestaurant: UILabel!
    @IBOutlet weak var telephoneRestaurant: UILabel!
    @IBOutlet weak var dateRendezVous: UILabel!
    
    
    @IBOutlet weak var pickDateRendezVous: UIDatePicker!
    @IBOutlet weak var GuestRankedTable: GuestRankedTableView!
    
    @IBOutlet weak var guestInvitedCollection: GuestUICollectionView!
    
    @IBOutlet weak var vieuwButtonCreateGroupe: UIView!
    @IBOutlet weak var constraintHeightViewAdd: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var viewGuestList: UIView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.raisonSociale.text = RendezVousApplication.sharedInstance.currentRestaurant!.raisonSociale
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/places/\(RendezVousApplication.sharedInstance.currentRestaurant!.urlPhoto)")!
        //  print(url)
        self.photoRestaurant.af_setImage(withURL: url)
        self.photoRestaurant.layer.cornerRadius = 10.0
        self.pourcentReduction.text = "-\(RendezVousApplication.sharedInstance.currentRestaurant!.pourcentReduction)%"
        self.noteRestaurant.text = "9/10"
        self.adresseRestaurant.text = RendezVousApplication.sharedInstance.currentRestaurant!.adressse
        self.codePostalRestaurant.text = RendezVousApplication.sharedInstance.currentRestaurant!.codePostal
        self.villeRestaurant.text = RendezVousApplication.sharedInstance.currentRestaurant!.ville
        self.telephoneRestaurant.text = RendezVousApplication.sharedInstance.currentRestaurant!.telephone
        
      
        self.GuestRankedTable.currentControleur = self
        
        self.guestInvitedCollection.delegate = self.guestInvitedCollection
        self.guestInvitedCollection.dataSource = self.guestInvitedCollection
        self.guestInvitedCollection.currentControleur = self
        
        
        ListeMatchingUtilisateurs.listeMatchingUtilisateurs { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: self, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    RendezVousApplication.sharedInstance.matchList = ListeMatchingUtilisateurs(json: json["data"])
                    print("il y a \(RendezVousApplication.getListeMatching().count) utilisateurs à choisir")
                    self.GuestRankedTable.delegate = self.GuestRankedTable
                    self.GuestRankedTable.dataSource = self.GuestRankedTable
                    self.GuestRankedTable.reloadData()
                }
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func onClickClose(_ sender: RoundButtonUIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onClickCreateGroupe(_ sender: UIButton) {
        
        RendezVousApplication.sharedInstance.currentRendezVous = RendezVous(idRendezVous: 0, numUtilisateurSource: RendezVousApplication.getUtilisateurId(), date: "\(pickDateRendezVous.date)", numStatusRendezVous: 1, numRestaurant: RendezVousApplication.sharedInstance.currentRestaurant!.idRestaurant)
        RendezVousApplication.sharedInstance.currentRendezVous?.save { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: self, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    RendezVousApplication.sharedInstance.currentRendezVous = RendezVous(json: json["data"])
                    self.constraintHeightViewAdd.constant = 0.0
                    self.vieuwButtonCreateGroupe.isHidden = true
                    self.viewGuestList.isHidden = false
                    self.constraintHeightViewTop.constant = 160.0
                    self.dateRendezVous.isHidden = false
                    self.dateRendezVous.text = "\(RendezVousApplication.sharedInstance.currentRendezVous!.getDate())"
                }
            }
        }
        
        
    }
    
}
