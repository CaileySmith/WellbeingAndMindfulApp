//
//  SignUpViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    //sets up style of text fields and buttons
    func setUpElements(){
        ErrorLabel.alpha = 0
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(LastNameTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleTextField(ConfirmPasswordTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleFilledButton(SignUpButton)
    }
    
    //check fields and validate data is correct, if correct return nil else error messsage
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
    
    @IBAction func signUpTapped(_ sender: Any) {
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
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                //check for errors
                if err != nil{
                    //was an error
                    self.showError("Error creating user")
                }else {
                    //user was created successfully store first and last name
                    let db =  Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { err in
                        if err != nil{
                            self.showError("Error saving user data")
                        }
                    }
                    //transition to homescreen
                    self.transitionToHome()
                    
                }
            }
        }
    }
    
    //shows error message in label
    func showError(_ message: String){
        self.ErrorLabel.text = message
        self.ErrorLabel.alpha = 1
    }
    
    //changes view controller to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

}
