//
//  Utilities.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import Foundation
import UIKit

//Class - Utilities
class Utilities{
    
    //Function - regex for secure password
    static func isPasswordValid(_ password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //Function - regex for email
    static func validateEmail(email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
}
