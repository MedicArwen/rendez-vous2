//
//  NewAccount.swift
//  rendez-vous
//
//  Created by Thierry BRU on 28/06/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
class NewAccount
{
    static var SharedInstance = NewAccount()
    var courriel = ""
    var motdepasse = ""
    var repeterMotdepasse = ""
    var pseudonyme = ""
    var nom = ""
    var prenom = ""
    var dateNaissance = ""
    var genre = ""
    var codeValidation = ""
    var nbChamps = 0
}
