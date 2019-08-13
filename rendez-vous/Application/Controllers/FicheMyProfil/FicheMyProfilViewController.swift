//
//  FicheMyProfilViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 30/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class FicheMyProfilViewController: RamonViewController {
//var listeCentreInteret = ListeCentreInteretUtilisateur.load(controleur: self)
  
    
    @IBOutlet weak var ficheUtilisateurShort: FicheMonShortProfilView!
    
    @IBOutlet weak var ficheLongCentreInteret: FicheMonLongProfilCentreInteretView!
    
    
    
    
    override func viewDidLoad() {
        print("FicheMyProfilViewController:viewDidLoad")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard Utilisateur.sharedInstance != nil else {
            print("Utilisateur non trouvé")
            return
        }
        self.ficheUtilisateurShort.update(controleur: self, utilisateur: Utilisateur.sharedInstance!)
        self.ficheLongCentreInteret.update(controleur:self)
        Utilisateur.subscribe(vue: self.ficheUtilisateurShort)
        Favoris.load(datasource: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
          print("FicheMyProfilViewController:viewWillAppear")
        self.ficheLongCentreInteret.centreInteretCollection.refresh()
    }
}
extension FicheMyProfilViewController:FavorisDataSource
{
    func favorisOnLoaded(ami: Favoris) {
        print("FicheMyProfilViewController:FavorisDataSource:favorisOnLoaded NOT IMPLEMENTED")
    }
    
    func favorisOnLoaded(amis: ListeUtilisateursFavoris) {
        print("FicheMyProfilViewController:FavorisDataSource:favorisOnLoaded")
        Utilisateur.sharedInstance!.friendList = amis
    }
    
    func favorisOnDeleted() {
        print("FicheMyProfilViewController:FavorisDataSource:favorisOnLoaded NOT IMPLEMENTED")
    }
    
    func favorisOnCreated(ami: Favoris) {
        print("FicheMyProfilViewController:FavorisDataSource:favorisOnLoaded NOT IMPLEMENTED")
    }
    
    func favorisOnNotFoundFavoris() {
        print("FicheMyProfilViewController:FavorisDataSource:favorisOnLoaded NOT IMPLEMENTED")
    }
    
    func favorisOnWebServiceError(code: Int) {
        print("FicheMyProfilViewController:FavorisDataSource:favorisOnLoaded NOT IMPLEMENTED")
    }
    
    
}
