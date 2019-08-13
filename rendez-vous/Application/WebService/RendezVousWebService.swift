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
    
    let endPoint = "https://rdv.ramon-technologies.com/rendez-vous/webservice.php"
    
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
   
   
}
