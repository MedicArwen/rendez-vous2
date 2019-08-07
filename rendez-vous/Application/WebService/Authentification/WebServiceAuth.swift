//
//  WebServiceAuth.swift
//  rendez-vous
//
//  Created by Thierry BRU on 06/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftHash
import SwiftyJSON

class WebServiceAuth
{
    // commande envoyée via le Web Service
    var commande: EnumAuthCommandWS?
    // parametres supplémentaires du Web Service
    private var parametres = [WebServiceParametre] ()
    private var parametresHTTPReady = [String:String]()
    private var dataSource:RamonUserDataSource?
    init(commande:EnumAuthCommandWS,datasource:RamonUserDataSource) {
        self.dataSource = datasource
        self.commande = commande
        generateDefaultParams()
    }
    func addParameter(parametre:WebServiceParametre)
    {
        parametres.append(parametre)
    }
    func prepareExecution()
    {
        for item in self.parametres {
            parametresHTTPReady[item.cle] = item.value
        }
        print("-> excution ready: \(parametresHTTPReady.count) parameters")
    }
    
    func getHttpParams()->[String:String]
    {
        return parametresHTTPReady
    }
    func generateDefaultParams()
    {
        print("WebServiceAuth:generateDefaultParams")
        let commande = "\(self.commande!)"
        self.addParameter(parametre: WebServiceParametre(cle: "CMD", valeur:commande))
        self.addParameter(parametre: WebServiceParametre(cle: "TIMESTAMP", valeur:String(NSDate().timeIntervalSince1970)))
        
    }
    func generateSignature()
    {
        print("WebServiceAuth:generateSignature")
        var signature = ""
        for item in self.parametres {
            signature.append(item.value)
        }
        signature.append("onmangeensembleb20")
        print("-> signature:\(signature)")
        self.addParameter(parametre: WebServiceParametre(cle: "SIGNATURE", valeur:MD5(signature)))
    }
    func callWebService(_ completion: @escaping ServiceResponse)
    {
        print(AuthWebService.sharedInstance.webServiceCalling(self.getHttpParams(), completion))
    }
    func execute()
    {
        guard dataSource != nil else {
            return
        }
        generateSignature()
      
        prepareExecution()
        callWebService { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    self.dataSource!.ramonUserOnWebServiceError(code:json["returnCode"].intValue)
                }
                else
                {
                    if json["data"] != "null"
                    {
                        switch self.commande! {
                        case .CODE: self.dataSource!.ramonUserOnCodeChecked()
                        case .MAIL: self.dataSource!.ramonUserOnMailAsked()
                        case .REGISTER: self.dataSource!.ramonUserOnRegistered(ramonUser:RamonUser(ramonUserJson: json["data"]))
                        }
                    }
                    else
                    {
                        self.dataSource!.ramonUserOnNotFoundRamonUser()
                    }
                    
                }
            }
        }
        
    }
}
