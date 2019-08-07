//
//  Utilisateur.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
import Foundation
import SwiftyJSON
import MapKit
import SwiftHash


class Utilisateur {
    /*
     // MARK: - Propriétés
     */
    // Variable statique contenant l'utilisateur connecté à l'application
    static var sharedInstance: Utilisateur?
    // Propriétés caractérisant un utilisateur de l'application RendezVous
    var idUtilisateur = 0
    var numRamonUser = 0
    var urlImage = ""
    var uiImage : UIImage?
    var catchPhrase = ""
    var description = ""
    var pseudo = ""
    var latitude = 0.0
    var longitude = 0.0
    /*
     // MARK: - Constructeurs
     */
    func construct(idUtilisateur: Int,numRamonUser:Int,urlImage:String,catchPhrase:String,description:String,pseudo: String,latitude:Double,longitude:Double) {
        print("Utilisateur:init pseudo:\(pseudo)")
        self.idUtilisateur = idUtilisateur
        self.numRamonUser = numRamonUser
        self.urlImage = urlImage
        self.catchPhrase = catchPhrase
        self.description = description
        self.pseudo = pseudo
        self.latitude = latitude
        self.longitude = longitude
        print("Instantiation de l'utilisateur \(self.pseudo) id:  \(self.idUtilisateur) num: \(self.numRamonUser)")
        
    }
    init(json:JSON) {
        self.construct(idUtilisateur:json["idUtilisateur"].intValue,
                       numRamonUser:json["libelle"].intValue,
                       urlImage:json["urlPhoto"].stringValue,
                       catchPhrase:json["catchPhrase"].stringValue,
                       description:json["description"].stringValue,
                       pseudo:json["pseudonyme"].stringValue,
                       latitude:json["latitude"].doubleValue,
                       longitude:json["longitude"].doubleValue
        )
    }
    func debugPrint()
    {
        print("idUtilisateur :\(self.idUtilisateur)")
        print("numRamonUser :\(self.numRamonUser)")
        print("urlImage :\(self.urlImage)")
        print("catchPhrase :\(self.catchPhrase)")
        
        print("description :\(self.description)")
        print("pseudo :\(self.pseudo)")
        print("pseudo :\(self.latitude)")
        print("longitude :\(self.longitude)")
    }
    /*
     // MARK: - Getters et setters
     */
    func setImage(url:String)
    {
        self.urlImage = url
    }
    func setPseudo(pseudo:String)
    {
        self.pseudo = pseudo
    }
    func setCatchPhrase(catchPhrase:String)
    {
        self.catchPhrase = catchPhrase
    }
    func setDescription(description:String)
    {
        self.description = description
    }
    /*
     // MARK: - Gestion de la connection automatique via les parametres par défaut du téléphone
     */
    static func saveUserConnected(utilisateur:Utilisateur)
    {
        UserDefaults.standard.set(utilisateur, forKey: "utilisateur")
    }
    static func connectUtilisateurDefault()->Utilisateur?
    {
        print("\(String(describing: UserDefaults.standard.string(forKey: "utilisateur")))")
        if let json = UserDefaults.standard.string(forKey: "utilisateur")
        {
            return Utilisateur(json: JSON(parseJSON: json))
        }
        return nil
    }
}
/*
 // MARK: - Utilisateur:Equatable
 */
extension Utilisateur:Equatable
{
    static func == (lhs: Utilisateur, rhs: Utilisateur) -> Bool {
        return lhs.idUtilisateur == rhs.idUtilisateur
    }
}
/*
 // MARK: - Utilisateur:WebServiceSubscribable
 */
extension Utilisateur:WebServiceSubscribable
{
    private static var suscribedViews = [WebServiceLinkable]()
    
    static func subscribe(vue:WebServiceLinkable)
    {
        print("Utilisateur:subscribe")
        var lavue = vue
        lavue.indice = self.suscribedViews.count
        self.suscribedViews.append(lavue)
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à Utilisateur")
    }
    
    static func unsuscribe(vue:WebServiceLinkable)
    {
        print("Utilisateur:unsubscribe")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à Utilisateur")
        //listeVuesUI.index(of: vue).map { listeVuesUI.remove(at: $0) }
        print("indice de la vue:\(vue.indice)")
        self.suscribedViews.remove(at: vue.indice)
        var i = 0
        for var item in self.suscribedViews
        {
            item.indice = i
            i += 1
        }
        
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à Utilisateur")
    }
    static func reloadViews()
    {
        print("Utilisateur:reloadViews")
        print("Il y a \(self.suscribedViews.count) vue(s abonnée(s) à Utilisateur")
        for vue in self.suscribedViews
        {
            print(vue)
            vue.refresh()
        }
    }
}
/*
 // MARK: - Utilisateur:UtilisateurCrudable
 */
extension Utilisateur:UtilisateurCrudable
{
    static func read(datasource: UtilisateurDataSource, idUtilisateur: Int) {
        print("Utilisateur:UtilisateurCrudable:read(idUtilisateur)")
        let webservice = WebServiceUtilisateur(commande: .READ, entite: .Utilisateur, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "idUtilisateur", valeur: "\(idUtilisateur)"))
        webservice.execute()
    }
    static func read(datasource: UtilisateurDataSource, idRamonUser: Int) {
        print("Utilisateur:UtilisateurCrudable:read(idRamonUser)")
        let webservice = WebServiceUtilisateur(commande: .READ, entite: .Utilisateur, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "numRamonUser", valeur: "\(idRamonUser)"))
        webservice.execute()
    }
    static func read(datasource:UtilisateurDataSource)
    {
        print("Utilisateur:UtilisateurCrudable:read")
        let webservice = WebServiceUtilisateur(commande: .READ, entite: .Utilisateur, datasource: datasource)
        webservice.execute()
    }
    static func create(datasource:UtilisateurDataSource)
    {
        print("Utilisateur:UtilisateurCrudable:create")
        let webservice = WebServiceUtilisateur(commande: .CREATE, entite: .Utilisateur, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "catchPhrase", valeur: NewProfile.SharedInstance.catchPhrase.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
        webservice.addParameter(parametre: WebServiceParametre(cle: "dateNaissance", valeur: "\(ConnectedRamonUser.sharedInstance!.ramonUser.dateNaissance)"))
        
        webservice.addParameter(parametre: WebServiceParametre(cle: "description", valeur: NewProfile.SharedInstance.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
        webservice.addParameter(parametre: WebServiceParametre(cle: "latitude", valeur: "\(NewProfile.SharedInstance.latitude)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "longitude", valeur: "\(NewProfile.SharedInstance.longitude)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numGenre", valeur: "\(ConnectedRamonUser.sharedInstance!.ramonUser.numGenre)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "pseudonyme", valeur: NewProfile.SharedInstance.pseudo))
        webservice.addParameter(parametre: WebServiceParametre(cle: "urlPhoto", valeur: NewProfile.SharedInstance.urlImage))
        webservice.execute()
    }

    func update(datasource:UtilisateurDataSource)
    {
        print("Utilisateur:UtilisateurCrudable:update")
        let webservice = WebServiceUtilisateur(commande: .UPDATE, entite: .Utilisateur, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "catchPhrase", valeur: self.catchPhrase.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
        webservice.addParameter(parametre: WebServiceParametre(cle: "description", valeur: self.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
        webservice.addParameter(parametre: WebServiceParametre(cle: "idUtilisateur", valeur: "\(self.idUtilisateur)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "latitude", valeur: "\(self.latitude)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "longitude", valeur: "\(self.longitude)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "numGenre", valeur: "\(ConnectedRamonUser.sharedInstance!.ramonUser.numGenre)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "pseudonyme", valeur: self.pseudo))
        webservice.addParameter(parametre: WebServiceParametre(cle: "urlPhoto", valeur: self.urlImage))
        webservice.execute()
        Utilisateur.reloadViews()
    }
    func delete(datasource:UtilisateurDataSource)
    {
        print("Utilisateur:UtilisateurCrudable:delete")
        print("NON IMPLEMENTE")
    }
}
extension Utilisateur:UtilisateurListable
{
    static func load(datasource: UtilisateurDataSource, latitude: Double, longitude: Double, range: Int) {
        print("Utilisateur:UtilisateurListable:load (\(latitude):\(longitude) - \(range) - \(Utilisateur.sharedInstance!.pseudo)[\(Utilisateur.sharedInstance!.idUtilisateur)]")
        let webservice = WebServiceUtilisateur(commande: .LIST, entite: .Utilisateur, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "distance", valeur: "\(range)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "latitude", valeur: "\(latitude)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "longitude", valeur: "\(longitude)"))
        webservice.execute()
    }
    static func find(utilisateur:Utilisateur)->Int
    {
        print("ListeMatchingUtilisateurs:find")
        var i = 0
        var indice = -1
        for item in ListeMatchingUtilisateurs.sharedInstance!.liste
        {
            if item.idUtilisateur == utilisateur.idUtilisateur
            {
                indice = i
            }
            i += 1
        }
        print("-> indice trouvé: \(indice) (-1 = rien trouvé)")
        return indice
    }
    static func remove(indice: Int) {
        guard ListeMatchingUtilisateurs.sharedInstance != nil else {
            print("ListeMatchingUtilisateurs:remove(indexPath) - aucune liste ListeMatchingUtilisateurs trouvée")
            return
        }
        if let currentList = ListeMatchingUtilisateurs.sharedInstance
        {
            print("ListeMatchingUtilisateurs:remove(indexPath) - indice:\(indice) ")
            currentList.liste.remove(at: indice)
            ListeMatchingUtilisateurs.reloadViews()
        }
    }
        
    
    static func append(utilisateur:RankedUtilisateur)
    {
        guard ListeMatchingUtilisateurs.sharedInstance != nil else {
            print("ListeMatchingUtilisateurs:append - aucune liste ListeMatchingUtilisateurs trouvée")
            return
        }
        print("ListeMatchingUtilisateurs:append - id utilisateur: \(utilisateur.idUtilisateur)")
        ListeMatchingUtilisateurs.sharedInstance!.liste.append(utilisateur)
        ListeMatchingUtilisateurs.reloadViews()
    }
    
}
