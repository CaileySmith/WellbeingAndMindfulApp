//
//  StyleSheet.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/01/2022.
//

import Foundation
import UIKit

//Class - Styles view elements
class StyleSheet{
    
    //function to format textfield with a green bar underneath
    static func styleTextFieldLevel1(_ textfield: UITextField){
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomline.backgroundColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomline)
    }
    
    //function to format textfield with a purple bar underneath
    static func styleTextFieldLevel2(_ textfield: UITextField){
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomline.backgroundColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomline)
    }
    
    //function to format textfield with a blue bar underneath
    static func styleTextFieldLevel3(_ textfield: UITextField){
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomline.backgroundColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomline)
    }
    
    //function to format textfield with a orange bar underneath
    static func styleTextFieldExtra1(_ textfield: UITextField){
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomline.backgroundColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomline)
    }
    
    //function to format textfield with a pink bar underneath
    static func styleTextFieldExtra2(_ textfield: UITextField){
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomline.backgroundColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomline)
    }
    
    //function to format a label (green)
    static func styleLabelLevel1(_ label: UILabel){
        label.textColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
    
    //function to format a label (purple)
    static func styleLabelLevel2(_ label: UILabel){
        label.textColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
    }
    
    //function to format a label (blue)
    static func styleLabelLevel3(_ label: UILabel){
        label.textColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
    }
    
    //function to format a label (orange)
    static func styleLabelExtra1(_ label: UILabel){
        label.textColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
    }
    
    //function to format a label (pink)
    static func styleLabelExtra2(_ label: UILabel){
        label.textColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
    }
    
    //function to format a standard button which has a dark green background and lighter text
    static func styleFilledButtonLevel1(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 216/255, green: 238/255, blue: 227/255, alpha: 1)
    }
    
    //function to format a standard button which has a dark purple background and lighter text
    static func styleFilledButtonLevel2(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 240/255, green: 217/255, blue: 255/255, alpha: 1)
    }
    
    //function to format a standard button which has a dark blue background and lighter text
    static func styleFilledButtonLevel3(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 216/255, green: 244/255, blue: 250/255, alpha: 1)
    }
    
    //function to format a standard button which has a dark orange background and lighter text
    static func styleFilledButtonExtra1(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 255/255, green: 224/255, blue: 195/255, alpha: 1)
    }
    
    //function to format a standard button which has a dark pink background and lighter text
    static func styleFilledButtonExtra2(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 253/255, green: 207/255, blue: 232/255, alpha: 1)
    }
    
    //function to format a standard button which has a lighter green background and dark text
    static func styleInvertFilledButtonLevel1(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 216/255, green: 238/255, blue: 227/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
    
    //function to format a standard button which has a lighter purple background and dark text
    static func styleInvertFilledButtonLevel2(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 240/255, green: 217/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
    }
    
    //function to format a standard button which has a lighter blue background and dark text
    static func styleInvertFilledButtonLevel3(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 216/255, green: 244/255, blue: 250/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
    }
    
    //function to format a standard button which has a lighter orange background and dark text
    static func styleInvertFilledButtonExtra1(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 255/255, green: 224/255, blue: 195/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
    }
    
    //function to format a standard button which has a lighter pink background and dark text
    static func styleInvertFilledButtonExtra2(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 253/255, green: 207/255, blue: 232/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
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
    
    //function to format the colour of a bar button item for a level 3 user extra colour (dark orange)
    static func styleBarButtonExtra1(_ button: UIBarButtonItem){
        button.tintColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
    }
    
    //function to format the colour of a bar button item for a level 3 user extra colour (dark pink)
    static func styleBarButtonExtra2(_ button: UIBarButtonItem){
        button.tintColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
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
        button.tintColor = UIColor.init(red: 216/255, green: 244/255, blue: 250/255, alpha: 1)
    }
    
    //function to format home button for level 3 user extra colour(orange)
    static func styleHomeButtonsExtra1(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.init(red: 255/255, green: 224/255, blue: 195/255, alpha: 1)
    }
    
    //function to format home button for level 3 user extra colour (pink)
    static func styleHomeButtonsExtra2(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.init(red: 253/255, green: 207/255, blue: 232/255, alpha: 1)
    }
    
    //function to format a textview (green)
    static func styleTextViewLevel1(_ textview: UITextView){
        textview.textColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
    
    //function to format a label (purple)
    static func styleTextViewLevel2(_ textview: UITextView){
        textview.textColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
    }
    
    //function to format a label (blue)
    static func styleTextViewLevel3(_ textview: UITextView){
        textview.textColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
    }
    
    //function to format a label (orange)
    static func styleTextViewExtra1(_ textview: UITextView){
        textview.textColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
    }
    
    //function to format a label (pink)
    static func styleTextViewExtra2(_ textview: UITextView){
        textview.textColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
    }
    
    //function to format a standard button which has a dark green background and lighter text
    static func styleTextButtonLevel1(_ button: UIButton){
        button.tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
}
