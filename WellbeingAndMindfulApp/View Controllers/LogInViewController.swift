//
//  LoginViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import UIKit
import FirebaseAuth

//ViewController Class - Login in screen
class LoginViewController: UIViewController {

    //Variables - outlets for view
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var PassHideButton: UIButton!
    
    //Variable
    var admin = false
    
    //Function- view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        //sets up view elements
        setUpElements()
    }
    
    //Action Function - Login pressed - login in user
    @IBAction func loginTapped(_ sender: UIButton) {
        //validate text fields
        let error = validateFields()
        if error != nil {
            self.showError(error!)
        }else {
            //cleaned data
            var password = ""
            if PasswordTextField.isSecureTextEntry {
                PasswordTextField.isSecureTextEntry =  !PasswordTextField.isSecureTextEntry
                password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }else {
                password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //checks with firebase authentication
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Could not sign in")
                }else{
                    self.messageBox(message: "Signed in")
                }
            }
        }
    }
    
    //Action Function - Secures and reveals password
    @IBAction func passTapped(_ sender: UIButton) {
        if PasswordTextField.isSecureTextEntry {
            PassHideButton.setTitle("Hide Password", for: .normal)
            PasswordTextField.isSecureTextEntry = !PasswordTextField.isSecureTextEntry
        }else {
            PassHideButton.setTitle("View Password", for: .normal)
            PasswordTextField.isSecureTextEntry = !PasswordTextField.isSecureTextEntry
        }
    }
    
    //Function- Login message box creater
    func messageBox(message: String ){
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay", style: .default){
            (action:UIAlertAction!)in
            if self.admin == false {
                self.transitionToHome()
            }else {
                self.transitionToAdminHome()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Validates the fields
    func validateFields()-> String?{
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        return nil
    }

    //Function - shows error message in label
    func showError(_ message: String){
        self.ErrorLabel.text = message
        self.ErrorLabel.alpha = 1
    }
    
    //Function - changed view controller to home screen
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    //Function - changed view controller to admin home screen
    func transitionToAdminHome(){
       let AdminHomeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.AdminHomeViewController) as? AdminHomeViewController
        self.view.window?.rootViewController = AdminHomeViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    //Function - allows keyboard to hide
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    //sets up elements from style sheet
    func setUpElements(){
        ErrorLabel.alpha = 0
        StyleSheet.styleTextFieldLevel1(EmailTextField)
        StyleSheet.styleTextFieldLevel1(PasswordTextField)
        StyleSheet.styleFilledButtonLevel1(LoginButton)
        StyleSheet.styleInvertFilledButtonLevel1(BackButton)
        StyleSheet.styleLabelLevel1(TitleLabel)
        StyleSheet.styleLabelLevel1(ErrorLabel)
        StyleSheet.styleTextButtonLevel1(PassHideButton)
        if admin == false {
            TitleLabel.text = "User Login"
        }else {
            TitleLabel.text = "Admin Login"
        }
    }
}
