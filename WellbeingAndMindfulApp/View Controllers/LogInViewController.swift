//
//  LoginViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    //sets up elements from style sheet
    func setUpElements(){
        ErrorLabel.alpha = 0
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(LoginButton)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        //validate text fields
        let error = validateFields()
        if error != nil {
            self.showError(error!)
        }else {
        //cleaned data
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //sign in user
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                self.showError("could not sign in")
            }else{
                self.transitionToHome()
            }
        }
        }
    }
    
    func validateFields()-> String?{
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        return nil
    }
    
    //shows error message in label
    func showError(_ message: String){
        self.ErrorLabel.text = message
        self.ErrorLabel.alpha = 1
    }
    
    //changed view controller to home screen 
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
    }

}
