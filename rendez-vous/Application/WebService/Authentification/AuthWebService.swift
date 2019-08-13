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

}
