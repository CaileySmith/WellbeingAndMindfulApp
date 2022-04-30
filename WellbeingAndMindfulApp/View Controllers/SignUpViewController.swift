//
//  SignUpViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import UIKit
import FirebaseAuth
import Firebase

//ViewController Class - Sign up screen
class SignUpViewController: UIViewController {

    //Variables - outlets for views
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var AboutButton: UIButton!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    //Variable
    var admin = false
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //calls functions
        hideKeyboard()
        setUpElements()
    }
    
    //Action Function - Sign up button pressed, signs user up
    @IBAction func signUpTapped(_ sender: UIButton) {
        var exist = false
        //validate fields
        let error = validateFields()
        if error != nil {
            showError(error!)
        }else {
            //create cleaned data
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if admin == false {
                let cleanedEmail = EmailTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let db = Firestore.firestore()
                db.collection("users").getDocuments{ (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    }else{
                        for document in querySnapshot!.documents {
                            let userid = document.documentID
                            let dbse = Firestore.firestore()
                            dbse.collection("users").document(userid).getDocument{ (docc, error) in
                                if let docc = docc, docc.exists {
                                    let mail = docc.get("email") as? String ?? ""
                                    if mail == cleanedEmail {
                                        self.showError("Email already taken")
                                        exist = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    if exist != true {
                        if self.admin == false {
                            //passes the user data to view model
                            let message = SignUpViewModel.signUpVM(email: email, password: password, first: firstName, last: lastName)
                            
                            if message.contains("New user created"){
                                let alert = UIAlertController(title: "Sign up", message: message, preferredStyle: UIAlertController.Style.alert)
                                let okAction = UIAlertAction(title: "Okay", style: .default){
                                    (action:UIAlertAction!)in
                                    self.transitionToHome()
                                    }
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                    self.showError(message)
                            }
                        }else {
                            //passes the admin data to view model
                            let message = SignUpViewModel.signUpAdminVM(email: email, password: password, first: firstName, last: lastName, admin: self.admin)
                            self.showError(message)
                            if message.contains("New admin created"){
                                let alert = UIAlertController(title: "Sign up", message: message, preferredStyle: UIAlertController.Style.alert)
                                let okAction = UIAlertAction(title: "Okay", style: .default){
                                    (action:UIAlertAction!)in
                                    self.transitionToHome()
                                    }
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                self.showError(message)
                            }
                        }
                    }
                }
        }
    }
    
    //Action Function - Gives information about the app
    @IBAction func AboutPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "About", message: "By signing up you are agreeing to have your personal and information data recorded. You can opt out at any time by deleting your account, this will erase all personal information and any saved data. \nEmails must be in a valid form and passwords must be at least 8 characters long, contains one special character and one number", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - shows error message in label
    func showError(_ message: String){
        self.ErrorLabel.text = message
        self.ErrorLabel.alpha = 1
    }
    
    //Function - changes view controller to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //Function - changed view controller to admin home screen
    func transitionToAdminHome(){
       let AdminHomeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.AdminHomeViewController) as? AdminHomeViewController
        self.view.window?.rootViewController = AdminHomeViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    //Function - Allows the keyboard to hide
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    //Function - check fields and validate data is correct, if correct return nil else error messsage
    func validateFields() -> String?{
        //check all fields filled in
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ConfirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        let cleanedPassword = PasswordTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedConfirmPassword = ConfirmPasswordTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = EmailTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //check if password is secure
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure password is at least 8 characters long, contains one special character and one number"
        } else if cleanedConfirmPassword != cleanedPassword {
            return "Passwords do not match"
        }
        //check if email is in correct format
        if Utilities.validateEmail(email: cleanedEmail) == false {
            return "Please correct email format is used"
        }
        return nil
    }

    
    //Function - sets up style of text fields and buttons
    func setUpElements(){
        ErrorLabel.alpha = 0
        StyleSheet.styleTextFieldLevel1(FirstNameTextField)
        StyleSheet.styleTextFieldLevel1(LastNameTextField)
        StyleSheet.styleTextFieldLevel1(PasswordTextField)
        StyleSheet.styleTextFieldLevel1(ConfirmPasswordTextField)
        StyleSheet.styleTextFieldLevel1(EmailTextField)
        StyleSheet.styleFilledButtonLevel1(SignUpButton)
        StyleSheet.styleInvertFilledButtonLevel1(BackButton)
        StyleSheet.styleLabelLevel1(TitleLabel)
        StyleSheet.styleLabelLevel1(ErrorLabel)
        StyleSheet.styleTextButtonLevel1(AboutButton)
        if admin == false {
            TitleLabel.text = "New User Sign Up"
        }else {
            TitleLabel.text = "New Admin Sign Up"
        }
    }
}
