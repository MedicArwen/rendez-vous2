//
//  CreateGroupViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
/*
 L'utilisateur peut créer via ce controleur un groupe pour aller dans un restaurant donné
 il a choisi a priori le groupe, avant d'arriver dans ce contrôleur
 */
class CreateGroupViewController: RamonViewController {

    var currentRendezVous: RendezVous?
    var currentRestaurant: Restaurant?
    
    // infos pour remplir la vue du groupe
    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var raisonSociale: UILabel!
    @IBOutlet weak var pourcentReduction: RoundUILabel!
    @IBOutlet weak var noteRestaurant: UILabel!
    @IBOutlet weak var adresseRestaurant: UILabel!
    @IBOutlet weak var codePostalRestaurant: UILabel!
    @IBOutlet weak var villeRestaurant: UILabel!
    @IBOutlet weak var telephoneRestaurant: UILabel!
    @IBOutlet weak var dateRendezVous: UILabel!
    
    // choix de la date et heure pour le rendez-vous
    @IBOutlet weak var pickDateRendezVous: UIDatePicker!
    //liste des personnes qui matchent (distance + note ranking)
    @IBOutlet weak var GuestRankedTable: GuestRankedTableView!
    // liste des invités dans le groupe
    @IBOutlet weak var guestInvitedCollection: GuestCollectionView!
    
    
    //vues et contraintes
    @IBOutlet weak var vieuwButtonCreateGroupe: UIView!
    @IBOutlet weak var constraintHeightViewAdd: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightViewTop: NSLayoutConstraint!
    @IBOutlet weak var viewGuestList: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // mise a jour du panel d'info sur le restaurant choisi
        self.raisonSociale.text = self.currentRestaurant!.raisonSociale
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/places/\(self.currentRestaurant!.urlPhoto)")!
        //  print(url)
        self.photoRestaurant.af_setImage(withURL: url)
        self.photoRestaurant.layer.cornerRadius = 10.0
        self.pourcentReduction.text = "-\(self.currentRestaurant!.pourcentReduction)%"
        self.noteRestaurant.text = "9/10"
        self.adresseRestaurant.text = self.currentRestaurant!.adressse
        self.codePostalRestaurant.text = self.currentRestaurant!.codePostal
        self.villeRestaurant.text = self.currentRestaurant!.ville
        self.telephoneRestaurant.text = self.currentRestaurant!.telephone
        
      
        self.GuestRankedTable.currentControleur = self
        // création du lien entre la collection des invités et la source de données des invités
        self.guestInvitedCollection.delegate = self.guestInvitedCollection
        self.guestInvitedCollection.dataSource = self.guestInvitedCollection
        self.guestInvitedCollection.currentControleur = self
        
        // création du lien entre la liste des gens pouvant être invité et la table permettant de les choisir
        self.GuestRankedTable.delegate = self.GuestRankedTable
        self.GuestRankedTable.dataSource = self.GuestRankedTable
        ListeMatchingUtilisateurs.subscribe(vue: self.GuestRankedTable)
        ListeMatchingUtilisateurs.load(controleur: self)
     
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
        
        self.currentRendezVous = RendezVous(idRendezVous: 0, numUtilisateurSource: RendezVousApplication.getUtilisateurId(), date: "\(pickDateRendezVous.date)", numStatusRendezVous: 1, numRestaurant: self.currentRestaurant!.idRestaurant,hote:RendezVousApplication.sharedInstance.connectedUtilisateur!)
        self.currentRendezVous?.save { (json: JSON?, error: Error?) in
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
                    let item = json["data"]
                    self.currentRendezVous = RendezVous(jRendezVous:item["Rendez-Vous"],jHote:item["Hote"])
                    self.constraintHeightViewAdd.constant = 0.0
                    self.vieuwButtonCreateGroupe.isHidden = true
                    self.viewGuestList.isHidden = false
                    self.constraintHeightViewTop.constant = 160.0
                    self.dateRendezVous.isHidden = false
                    self.dateRendezVous.text = "\(self.currentRendezVous!.getDate())"
                }
            }
        }
        
        
    }
    
}
