//
//  MesMatchsViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit

class MesMatchsViewController: RamonViewController {
    var currentUtilisateur : RankedUtilisateur?
    var currentScore : String?
    @IBOutlet weak var tableMesMatchs: MesMatchsTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableMesMatchs.currentControleur = self
        tableMesMatchs.delegate = self.tableMesMatchs
        tableMesMatchs.dataSource = self.tableMesMatchs
       // ListeMatchingUtilisateurs.subscribe(vue: self.tableMesMatchs)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        Utilisateur.load(datasource: self, latitude: LocationManager.SharedInstance.location!.coordinate.latitude, longitude: LocationManager.SharedInstance.location!.coordinate.longitude, range: 10)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "showScoring"
        {
            let dest = segue.destination as! FicheScoringUtilisateurViewController
            dest.currentUtilisateur = currentUtilisateur!
            dest.score = currentScore!
            dest.parentView = self.tableMesMatchs
        }
    }
    
    
    @IBAction func onClickClose(_ sender: RoundButtonUIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MesMatchsViewController:UtilisateurDataSource
{
    func utilisateurOnLoaded(utilisateur: Utilisateur) {
        print("MesMatchsViewController:UtilisateurDataSource:utilisateurOnLoaded -> NOT IMPLEMENTED")
    }
    
    func utilisateurOnLoaded(matchs: ListeMatchingUtilisateurs) {
        print("MesMatchsViewController:UtilisateurDataSource:utilisateurOnLoaded")
        print("matchs:\(matchs.liste.count)")
        self.tableMesMatchs.mesMatchs = matchs
        self.tableMesMatchs.refresh()
    }
    
    func utilisateurOnUpdated() {
        print("MesMatchsViewController:UtilisateurDataSource:utilisateurOnUpdated -> NOT IMPLEMENTED")
    }
    
    func utilisateurOnDeleted() {
        print("MesMatchsViewController:UtilisateurDataSource:utilisateurOnDeleted -> NOT IMPLEMENTED")
    }
    
    func utilisateurOnCreated() {
        print("MesMatchsViewController:UtilisateurDataSource:utilisateurOnCreated -> NOT IMPLEMENTED")
    }
    
    func utilisateurOnNotFoundUtilisateur() {
        print("MesMatchsViewController:UtilisateurDataSource:utilisateurOnNotFoundUtilisateur -> NOT IMPLEMENTED")
    }
    
    func utilisateurOnWebServiceError(code: Int) {
        AlerteBoxManager.sendAlertMessage(vc: self, returnCode: code)
    }
    
    
}
