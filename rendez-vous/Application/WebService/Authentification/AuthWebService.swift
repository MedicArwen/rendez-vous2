//
//  AuthWebService.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftHash

// Singleton pour l'appel réseau
typealias ServiceResponse = ((JSON?, Error?) -> Void)

struct AuthWebService {
    
    let endPoint = "https://api.ramon-technologies.com/auth/webservice.php"
    var ramonUser :RamonUser?
    var userName: String?
    var password: String?
    
    static var sharedInstance = AuthWebService()
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
         https://api.ramon-technologies.com/auth/webservice.php?CMD=CREDENTIALS&TIMESTAMP=1561618457&courriel=thierry-bru@laposte.net&idApplication=1&motdepasse=pwd&SIGNATURE=9111015bfccda837ccba445bc8dc69df
         
         signature : CREDENTIALS1561618457thierry-bru@laposte.net1pwdonmangeensembleb20
         md5 : 9111015bfccda837ccba445bc8dc69df

         */
    /*    func loginWithPassword(_ completion: @escaping ServiceResponse) {
            let timestamp = String(NSDate().timeIntervalSince1970)
            var params = [String:String]()
            params["CMD"] = "CREDENTIALS"
            params["courriel"] = self.userName
            params[ "motdepasse"] = self.password!
            params["TIMESTAMP"] = timestamp
            print("CREDENTIALS\(timestamp)\(self.userName!)2\(self.password!)onmangeensembleb20")
            params[ "SIGNATURE"] =  MD5("CREDENTIALS\(timestamp)\(self.userName!)2\(self.password!)onmangeensembleb20" )
            params["motdepasse"] = password
            params["idApplication"] = "2"
            print("loginWithMailPwd")
            print(params)
            print(webServiceCalling(params, completion))
            
        }*/
    /*
     https://api.ramon-technologies.com/auth/webservice.php?CMD=REGISTER&TIMESTAMP=1561618457&courriel=toto@toto.fr&dateNaissance=1977-10-24&motdepasse=pwd&nom=MARTIN&numGenre=2&prenom=thomas&pseudonyme=toto&SIGNATURE=13349411885afe9d3a2d6a366beb8d66
     
     Attention au format de la date
     403 : signature incorrecte
     Pour signer : la valeur des parametres concaténé : commande, timestamp et ensuite les parametres sont classés par ordre alphabétique
     405 : utilisateur déjà existant
     418 : un des paramètres manque ou est malformé.
     Clé de sablage : onmangeensembleb20
     200 : tout est ok
     RETOUR : Utilisateur créé
     
 */
    func register(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["CMD"] = "REGISTER"
        params["courriel"] = self.ramonUser!.courriel
        params[ "motdepasse"] = self.ramonUser!.motdepasse
        params["dateNaissance"] = self.ramonUser!.dateNaissance
        params[ "prenom"] = self.ramonUser!.prenom
        
        
        params["nom"] = self.ramonUser!.nom
        params[ "numGenre"] = "\(self.ramonUser!.numGenre)"
        params["pseudonyme"] = self.ramonUser!.pseudonyme
        
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("REGISTER\(timestamp)\(self.ramonUser!.courriel)\(self.ramonUser!.dateNaissance)\(self.ramonUser!.motdepasse)\(self.ramonUser!.nom)\(self.ramonUser!.numGenre)\(self.ramonUser!.prenom)\(self.ramonUser!.pseudonyme)onmangeensembleb20" )

        print("register a new account")
        print(params)
        print(webServiceCalling(params, completion))
        
    }
    /*
     https://api.ramon-technologies.com/auth/webservice.php?CMD=MAIL&TIMESTAMP=1561618457&courriel=thierry-bru@laposte.net&SIGNATURE=addfe3108e6eefbed4495420f6fd07d6
     
     signature : MAIL1561618457thierry-bru@laposte.netonmangeensembleb20
     md5= addfe3108e6eefbed4495420f6fd07d6
     
     403: signature incorrecte
     Clé de sablage : onmangeensembleb20
     
     */
    func askValidationCode(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["CMD"] = "MAIL"
        params["courriel"] = self.ramonUser!.courriel
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("MAIL\(timestamp)\(self.ramonUser!.courriel)onmangeensembleb20" )
        
        print("ask a validation email")
        print(webServiceCalling(params, completion))
        
    }
    /*
     https://api.ramon-technologies.com/auth/webservice.php?CMD=CODE&TIMESTAMP=1561618457&codeValidation=d0c61f21-98c0-11e9-b4d8-fa163e526b5b&courriel=thierry-bru@laposte.net&SIGNATURE=001bbb2790fef2f838a9b7c7ec137649
     
     Signature : CODE1561618457d0c61f21-98c0-11e9-b4d8-fa163e526b5bthierry-bru@laposte.net onmangeensembleb20
     Md5 : 001bbb2790fef2f838a9b7c7ec137649
     403 : signature incorrecte
     301 : clé ou email non valide
     200 : tout est OK
     A CE STADE, le compte RAMON USER est créé et validé. L’utilisateur n’est pas enregistré pour l’application.
     
 */
    func checkValidationCode(_ completion: @escaping ServiceResponse) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        var params = [String:String]()
        params["CMD"] = "CODE"
        params["codeValidation"] = self.ramonUser!.codeValidation
        params["courriel"] = self.ramonUser!.courriel
        params["TIMESTAMP"] = timestamp
        params[ "SIGNATURE"] =  MD5("CODE\(timestamp)\(self.ramonUser!.codeValidation)\(self.ramonUser!.courriel)onmangeensembleb20" )
        
        print("check a validation email")
        print(webServiceCalling(params, completion))
        
    }
       /* func loginWithAPIKey(_ completion: @escaping ServiceResponse) {
            let timestamp = String(NSDate().timeIntervalSince1970)
            let params = ["CMD":"LOGIN",
                          "userid":String(userID),
                          "apikey":apiKey,
                          "TIMESTAMP":timestamp,
                          "SIGNATURE": MD5("LOGIN" + String(userID) + apiKey + timestamp),
                          "motdepasse":password]
            print("loginWithAPIKey")
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
    func isConnected()->Bool
    {
        return !(self.ramonUser == nil)
    }
}
