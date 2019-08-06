//
//  WebService.swift
//  rendez-vous
//
//  Created by Thierry BRU on 01/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//
// generation de la requete
/* 1 on instancie le web service X
 2 on configure la commande et l'entité cible X
 3 on genere les parametres par defaut X
 4 on ajoute les parametres supplémentaires
 5 on génere la signature
 6 on prépare l'execution avec la requete http ready
 7 on lance la purée
 */

import Foundation
import SwiftHash


class WebService
{
    
    // commande envoyée via le Web Service
    var commande: EnumCommandeWebService?
    var entite: EnumEntityWebServiceTargeted?
    // parametres supplémentaires du Web Service
    private var parametres = [WebServiceParametre] ()
    private var parametresHTTPReady = [String:String]()
    
    init(commande:EnumCommandeWebService,cible:EnumEntityWebServiceTargeted) {
        self.commande = commande
        self.entite = cible
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
        print("-> excjution ready: \(parametresHTTPReady.count) parameters")
    }
    
    func getHttpParams()->[String:String]
    {
        return parametresHTTPReady
    }
    func generateDefaultParams()
    {
        print("WebService:generateDefaultParams")
        let commande = "\(self.commande!)"
        let entity = "\(self.entite!)"
        if ConnectedRamonUser.sharedInstance != nil
        {self.addParameter(parametre: WebServiceParametre(cle: "APIKEY", valeur:  ConnectedRamonUser.sharedInstance!.apiKey!))}
        self.addParameter(parametre: WebServiceParametre(cle: "CMD", valeur:commande))
        self.addParameter(parametre: WebServiceParametre(cle: "ENTITY", valeur:entity))
        if ConnectedRamonUser.sharedInstance != nil
        { self.addParameter(parametre: WebServiceParametre(cle: "NUMRAMONUSER", valeur:"\(ConnectedRamonUser.sharedInstance!.ramonUser.idRamonUser)"))}
        self.addParameter(parametre: WebServiceParametre(cle: "TIMESTAMP", valeur:String(NSDate().timeIntervalSince1970)))
    }
    func generateSignature()
    {
        print("WebService:generateSignature")
        var signature = ""
        for item in self.parametres {
            signature.append(item.value)
        }
        signature.append("onmangeensembleb20")
        print("-> signature:\(signature)")
        self.addParameter(parametre: WebServiceParametre(cle: "SIGNATURE", valeur:MD5(signature)))
    }
    
}

