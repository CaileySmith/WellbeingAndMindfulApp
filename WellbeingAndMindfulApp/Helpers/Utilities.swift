//
//  Utilities.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import Foundation
import UIKit

class Utilities{
    //function to format textfield with a green bar underneath
    static func styleTextField(_ textfield: UITextField){
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomline.backgroundColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomline)
    }
    
    //function to format a standard button which has a dark green background and lighter text
    static func styleFilledButton(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 216/255, green: 238/255, blue: 227/255, alpha: 1)
    }
    
    //function to format a standard button which has a lighter green background and dark text
    static func styleInvertFilledButton(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 216/255, green: 238/255, blue: 227/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
    
    //function to format the colour of a bar button item for a level 1 user (dark green)
    static func styleBarButtonLevel1(_ button: UIBarButtonItem){
        button.tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
    
    //function to format the colour of a bar button item for a level 2 user (dark purple)
    static func styleBarButtonLevel2(_ button: UIBarButtonItem){
        button.tintColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
    }
    
    //function to format the colour of a bar button item for a level 3 user (dark blue)
    static func styleBarButtonLevel3(_ button: UIBarButtonItem){
        button.tintColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
    }
    
    //function to format home buttons for level 1 user (green)
    static func styleHomeButtonsLevel1(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.init(red: 216/255, green: 238/255, blue: 227/255, alpha: 1)
    }
    
    //function to format home buttons for level 2 user (purple)
    static func styleHomeButtonsLevel2(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.init(red: 240/255, green: 217/255, blue: 255/255, alpha: 1)
    }
    
    //function to format home button for level 3 user (blue)
    static func styleHomeButtonsLevel3(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.init(red: 162/255, green: 219/255, blue: 250/255, alpha: 1)
    }
    
    
    static func isPasswordValid(_ password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func validateEmail(email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    
}
