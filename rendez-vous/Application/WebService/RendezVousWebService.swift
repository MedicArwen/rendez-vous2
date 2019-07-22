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
     https://api.ramon-technologies.com/rendez-vous/webservice.php?CMD=CREATE&TIMESTAMP=55555&NUMRAMONUSER=28&APIKEY=be085aea-9c0e-11e9-b4d8-fa163e526b5b&SIGNATURE=2EA4CD68F6BE3DDB58DF27E303DFB3A6&ENTITY=Utilisateur&catchPhrase=catchphrase&dateNaissance=1977-10-24&description=description&latitude=3.14&longitude=3.14&urlPhoto=url&numGenre=2&pseudonyme=Pseudo
     
     signature : CREDENTIALS1561618457thierry-bru@laposte.net1pwdonmangeensembleb20
     md5 : 9111015bfccda837ccba445bc8dc69df
     
     */
    
    func listeCentreInteret(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "LIST"
        params["ENTITY"] = "CentreInteret"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print("chargement des centres d'interet")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print(webServiceCalling(params, completion))
        
    }
    func listeTypeCuisine(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "LIST"
        params["ENTITY"] = "TypeCuisine"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print("chargement des types de cuisine")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)onmangeensembleb20")
        print(webServiceCalling(params, completion))
        
    }
    func registerCentreInteret(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "CREATE"
        params["ENTITY"] = "Utilisateur_CentreInteret"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        var listeInteret = [Int] ()
        for centreInteret in NewProfile.SharedInstance.centresInterets {
            listeInteret.append(centreInteret.id)
        }
        print("json: \(JSON(listeInteret).rawString()!)")
        params["liste"] = JSON(listeInteret).rawString()!
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print("enregistrement des centres d'interet")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print(webServiceCalling(params, completion))
        
    }
    func registerTypeCuisine(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["APIKEY"] = RendezVousApplication.getApiKey()
        params["CMD"] = "CREATE"
        params["ENTITY"] = "Utilisateur_TypeCuisine"
        params["NUMRAMONUSER"] = "\(RendezVousApplication.getRamonUserId())"
        params["TIMESTAMP"] = timestamp
        var listeCuisine = [Int] ()
        for typeCuisine in NewProfile.SharedInstance.typeCuisines {
            listeCuisine.append(typeCuisine.id)
        }
        print("json: \(JSON(listeCuisine).rawString()!)")
        params["liste"] = JSON(listeCuisine).rawString()!
        params[ "SIGNATURE"] =  MD5("\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print("enregistrement des types de cuisine")
        print("signature=\(params["APIKEY"]!)\(params["CMD"]!)\(params["ENTITY"]!)\(params["NUMRAMONUSER"]!)\(params["TIMESTAMP"]!)\(params["liste"]!)onmangeensembleb20")
        print(webServiceCalling(params, completion))
        
    }
    

    
    
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
