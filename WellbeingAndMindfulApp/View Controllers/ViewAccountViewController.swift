//
//  ViewAccountViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 03/04/2022.
//

import UIKit
import Firebase

//ViewController Class - view account screen
class ViewAccountViewController: UIViewController {

    //Variables - outlets for view
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var SavePass: UIButton!
    @IBOutlet weak var PasswordTwo: UITextField!
    @IBOutlet weak var StreakLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var PasswordButton: UIButton!
    @IBOutlet weak var PasswordOne: UITextField!
    
    //Variables
    var colour = "green"
    var level = 1
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //view style set up
        hideKeyboard()
        switch colour {
        case "green": do {
            self.levelOneSetUp()
        }
        case "purple": do {
            self.levelTwoSetUp()
        }
        case "blue": do {
            self.levelThreeSetUp()
        }
        case "orange": do {
            self.extraOneSetUp()
        }
        case "pink" : do {
            self.extraTwoSetUp()
        }
        default: do {}
        }
        SavePass.alpha = 0
        PasswordOne.alpha = 0
        PasswordTwo.alpha = 0
        ErrorLabel.alpha = 0
        //get information from database
        let db = Firestore.firestore()
        let database = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            let email = String(describing: user.email)
            let result = email.split(separator: "\"")
            self.EmailLabel.text = "Email: \(result[1])"
            db.collection("users").document(userid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let first = document.get("firstname") as? String ?? ""
                    let last = document.get("lastname") as? String ?? ""
                    self.NameLabel.text = "Name: \(first) \(last)"
                    let lvl = document.get("level") as? Int ?? 0
                    self.LevelLabel.text = "Level: \(lvl)"
                    database.collection("users").document(userid).collection("track").document("tracking").getDocument{(doc, error) in
                    if let doc = doc, doc.exists {
                        let all = doc.get("all") as? [String: Any]
                        let streak = all?["streak"] as? String ?? "0"
                        self.StreakLabel.text = "Streak: \(streak)"
                    }
                    }
                }
            }
        }
    }
    
    //Action Function - back to settings
    @IBAction func BackPressed(_ sender: UIBarButtonItem) {
        let SettingsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.SettingsViewController) as? SettingsViewController
        SettingsViewController?.colour = colour
        SettingsViewController?.level = level
         view.window?.rootViewController = SettingsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - change password view change
    @IBAction func ChangePasswordPressed(_ sender: UIButton) {
        SavePass.alpha = 1
        PasswordOne.alpha = 1
        PasswordTwo.alpha = 1
    }
    
    //Action Function - update password
    @IBAction func SavePasswordPressed(_ sender: UIButton) {
        let ok = validateFields()
        if ok == nil {
            let user = Auth.auth().currentUser
            if let user = user {
                user.updatePassword(to: PasswordTwo.text!)
                SavePass.alpha = 0
                PasswordOne.alpha = 0
                PasswordTwo.alpha = 0
                ErrorLabel.alpha = 1
                ErrorLabel.text = "Password Changed"
            }else {
                ErrorLabel.alpha = 1
                ErrorLabel.text = "Error Changing password"
            }
        }else {
            self.ErrorLabel.alpha = 1
            self.ErrorLabel.text = ok
        }
    }
    
    //Function - check fields and validate data is correct, if correct return nil else error messsage
    func validateFields() -> String?{
        //check all fields filled in
        if PasswordTwo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordOne.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        let cleanedPassword = PasswordOne!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedConfirmPassword = PasswordTwo!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //check if password is secure
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure password is at least 8 characters long, contains one special character and one number"
        } else if cleanedConfirmPassword != cleanedPassword {
            return "Passwords do not match"
        }
        return nil
    }
    
    //Function - allows keyboard to be hidden
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleInvertFilledButtonLevel1(PasswordButton)
        StyleSheet.styleFilledButtonLevel1(SavePass)
        StyleSheet.styleTextFieldLevel1(PasswordOne)
        StyleSheet.styleTextFieldLevel1(PasswordTwo)
        StyleSheet.styleBarButtonLevel1(BackButton)
        StyleSheet.styleLabelLevel1(ErrorLabel)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleInvertFilledButtonLevel2(PasswordButton)
        StyleSheet.styleFilledButtonLevel2(SavePass)
        StyleSheet.styleTextFieldLevel2(PasswordOne)
        StyleSheet.styleTextFieldLevel2(PasswordTwo)
        StyleSheet.styleBarButtonLevel2(BackButton)
        StyleSheet.styleLabelLevel2(ErrorLabel)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleInvertFilledButtonLevel3(PasswordButton)
        StyleSheet.styleFilledButtonLevel3(SavePass)
        StyleSheet.styleTextFieldLevel3(PasswordOne)
        StyleSheet.styleTextFieldLevel3(PasswordTwo)
        StyleSheet.styleBarButtonLevel3(BackButton)
        StyleSheet.styleLabelLevel3(ErrorLabel)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleInvertFilledButtonExtra1(PasswordButton)
        StyleSheet.styleFilledButtonExtra1(SavePass)
        StyleSheet.styleTextFieldExtra1(PasswordOne)
        StyleSheet.styleTextFieldExtra1(PasswordTwo)
        StyleSheet.styleBarButtonExtra1(BackButton)
        StyleSheet.styleLabelExtra1(ErrorLabel)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleInvertFilledButtonExtra2(PasswordButton)
        StyleSheet.styleFilledButtonExtra2(SavePass)
        StyleSheet.styleTextFieldExtra2(PasswordOne)
        StyleSheet.styleTextFieldExtra2(PasswordTwo)
        StyleSheet.styleBarButtonExtra2(BackButton)
        StyleSheet.styleLabelExtra2(ErrorLabel)
    }
}
