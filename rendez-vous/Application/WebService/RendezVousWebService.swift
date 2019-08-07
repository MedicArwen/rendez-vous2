//
//  RendezVousWebService.swift
//  rendez-vous
//
//  Created by Thierry BRU on 10/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
import SwiftHash

// Singleton pour l'appel réseau
struct RendezVousWebService {
    
    let endPoint = "https://api.ramon-technologies.com/rendez-vous/webservice.php"
    
    static var sharedInstance = RendezVousWebService()
    fileprivate init() {}
    // MARK: VERIFICATION LOGIN
    func webServiceCalling(_ params: [String : String], _ completion: @escaping ServiceResponse) -> (DataRequest) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return Alamofire.request(endPoint ,method: .get,parameters:params).validate(statusCode:200..<500).responseJSON {
            response in
            switch response.result{
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("## SUCCESSFULLY RECEIVED JSON DATAS ##")
                    //print("## -> DATA received = \(json)")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(nil, error)
            }
        }
    }
   /*
    func registerCentreInteret(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = ConnectedRamonUser.sharedInstance!.apiKey
        params["CMD"] = "CREATE"
        params["ENTITY"] = "Utilisateur_CentreInteret"
        params["NUMRAMONUSER"] = "\(ConnectedRamonUser.sharedInstance!.ramonUser.idRamonUser)"
        params["TIMESTAMP"] = timestamp
        var listeInteret = [Int] ()
        for centreInteret in ListeCentreInteretUtilisateur.sharedInstance!.liste {
            listeInteret.append(centreInteret.id)
        }
        print("json: \(JSON(listeInteret).rawString()!)")
        params["liste"] = JSON(listeInteret).rawString()!
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print("enregistrement des centres d'interet")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print(webServiceCalling(params, completion))
        
    }*/
  /*  func registerTypeCuisine(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = ConnectedRamonUser.sharedInstance!.apiKey
        params["CMD"] = "CREATE"
        params["ENTITY"] = "Utilisateur_TypeCuisine"
        params["NUMRAMONUSER"] = "\(ConnectedRamonUser.sharedInstance!.ramonUser.idRamonUser)"
        params["TIMESTAMP"] = timestamp
        var listeCuisine = [Int] ()
        for typeCuisine in ListeTypeCuisineUtilisateur.sharedInstance!.liste {
            listeCuisine.append(typeCuisine.id)
        }
        print("json: \(JSON(listeCuisine).rawString()!)")
        params["liste"] = JSON(listeCuisine).rawString()!
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print("enregistrement des types de cuisine")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print(webServiceCalling(params, completion))
        
    }*/
    
    static func generateMessageAlert(returnCode: Int)-> String {
        let message: String
        switch returnCode
        {
        case 1: message = "Vous allez maintenant recevoir un courriel contenant votre code de validation à 6 chiffes."
            
        case 301: message = "La connexion internet n'est pas disponible: \(returnCode)"
        case 200: message = "La connexion a réussi. Bienvenue."
            
        case 400: message = "La requête est mal formulée: \(returnCode)"
        case 401: message = "Votre identifiant ou votre mot de passe est incorrect: \(returnCode)"
        case 403: message = "Signature de la requête invalide: \(returnCode)"
        case 405: message = "Cette requête a déjà été envoyée: \(returnCode)"
        default: message = "Erreur indéterminée: \(returnCode)"
        }
        return message
    }
    static func generateTitleAlert(vc:RamonViewController)->String
    {
        var title : String
        switch vc.codeController {
        case "RegisterVC": title = "Creating Account"
        case "AuthentificationVC": title = "Authentification"
        default:
            title = "Alert"
        }
        return title
    }
    
    static func sendAlertMessage(vc:UIViewController,returnCode:Int)
    {
        let message = AuthWebService.generateMessageAlert(returnCode: returnCode)
        let view = vc as!RamonViewController
        let title = AuthWebService.generateTitleAlert(vc: view)
        let alert : UIAlertController = UIAlertController(title: title, message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
        vc.present(alert, animated: true, completion: nil)
    }
  
}
