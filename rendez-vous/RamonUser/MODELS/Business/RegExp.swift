//
//  RegExp.swift
//  rendez-vous
//
//  Created by Thierry BRU on 02/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
struct RegExp {
    
    /**
     Check password complexity
     
     - parameter password:         password to test
     - parameter length:           password min length
     - parameter patternsToEscape: patterns that password must not contains
     - parameter caseSensitivty:   specify if password must conforms case sensitivity or not
     - parameter numericDigits:    specify if password must conforms contains numeric digits or not
     
     - returns: int that describes the error in the password (0 = all is ok)
     */
    static func checkPasswordComplexity(password: String, length: Int, patternsToEscape: [String], caseSensitivty: Bool, numericDigits: Bool) -> Int {
        if (password.count < length) {
            return 1
        }
        if caseSensitivty {
            let hasUpperCase = RegExp.matchesForRegexInText(regex: "[A-Z]", text: password).count > 0
            if !hasUpperCase {
                return 2
            }
            let hasLowerCase = RegExp.matchesForRegexInText(regex: "[a-z]", text: password).count > 0
            if !hasLowerCase {
                return 4
            }
        }
        if numericDigits {
            let hasNumbers = RegExp.matchesForRegexInText(regex: "\\d", text: password).count > 0
            if !hasNumbers {
                return 5
            }
        }
        if patternsToEscape.count > 0 {
            let passwordLowerCase = password.lowercased()
            for pattern in patternsToEscape {
                let hasMatchesWithPattern = RegExp.matchesForRegexInText(regex: pattern, text: passwordLowerCase).count > 0
                if hasMatchesWithPattern {
                    return 6
                }
            }
        }
        return 0
    }
    
    static func matchesForRegexInText(regex: String, text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text,
                                                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
