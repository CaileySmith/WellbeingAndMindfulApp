//
//  AdminHomeViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 05/04/2022.
//

import UIKit
import Firebase

//ViewController Class - Admin home screen
class AdminHomeViewController: UIViewController {

    //Variables - outlets for view
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    @IBOutlet weak var ManageAccountButton: UIButton!
    @IBOutlet weak var ManageUsersButton: UIButton!
    @IBOutlet weak var TipsButton: UIButton!
    @IBOutlet weak var LogoutButton: UIBarButtonItem!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var SavePassword: UIButton!
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //style view
        hideKeyboard()
        StyleSheet.styleBarButtonLevel1(LogoutButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
        StyleSheet.styleFilledButtonLevel1(TipsButton)
        StyleSheet.styleFilledButtonLevel2(ManageUsersButton)
        StyleSheet.styleFilledButtonLevel3(ManageAccountButton)
        StyleSheet.styleTextFieldExtra1(Password)
        StyleSheet.styleTextFieldExtra2(ConfirmPassword)
        StyleSheet.styleFilledButtonLevel1(SavePassword)
        StyleSheet.styleFilledButtonLevel2(CancelButton)
        StyleSheet.styleLabelLevel3(ErrorLabel)
        Password.alpha = 0
        ConfirmPassword.alpha = 0
        SavePassword.alpha = 0
        CancelButton.alpha = 0
        ErrorLabel.alpha = 0
    }

    //Action Function - load tip view
    @IBAction func TipsPressed(_ sender: UIButton) {
        let TipsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TipsViewController) as? TipsViewController
         TipsViewController?.admin = true
         view.window?.rootViewController = TipsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - load manage user view
    @IBAction func ManageUsersPressed(_ sender: UIButton) {
        let AdminManageUsersViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.AdminManageUsersViewController) as? AdminManageUsersViewController
         view.window?.rootViewController = AdminManageUsersViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Manage account by either deleting account or changing password
    @IBAction func ManageAccountPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Manage Account", message: "Which would you like to do?", preferredStyle: UIAlertController.Style.alert)
        //deletes account
        let delAction = UIAlertAction(title: "Delete Account", style: .default){
        (action:UIAlertAction!)in
            let alt = UIAlertController(title: "Delete Account", message: "Do you wish to permenantly delete your account and all data?", preferredStyle: UIAlertController.Style.alert)
            let confirm = UIAlertAction(title: "Confirm Delete", style: .default){
            (action:UIAlertAction!)in
                let db = Firestore.firestore()
                let user = Auth.auth().currentUser
                if let user = user {
                    let userid = user.uid
                    db.collection("admin").document(userid).delete()
                    user.delete()
                    let alrt = UIAlertController(title: "Delete Account", message: "Account deleted", preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "Okay", style: .default){
                    (action:UIAlertAction!)in
                        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.ViewController) as? ViewController
                        self.view.window?.rootViewController = ViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                    alrt.addAction(ok)
                    self.present(alrt, animated: true, completion: nil)
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default){
                (action:UIAlertAction!)in
            }
            alt.addAction(confirm)
            alt.addAction(cancel)
            self.present(alt, animated: true, completion: nil)
        }
        //changes password shows
        let changePAction = UIAlertAction(title: "Change Password", style: .default){
        (action:UIAlertAction!)in
            self.Password.alpha = 1
            self.ConfirmPassword.alpha = 1
            self.SavePassword.alpha = 1
            self.CancelButton.alpha = 1
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
        (action:UIAlertAction!)in
            
        }
        alert.addAction(changePAction)
        alert.addAction(delAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Action Function - save new password
    @IBAction func SavePressed(_ sender: UIButton) {
        let ok = self.validateFields()
        if ok == nil {
            let user = Auth.auth().currentUser
            if let user = user {
                user.updatePassword(to: self.ConfirmPassword.text!)
                self.SavePassword.alpha = 0
                self.Password.alpha = 0
                self.ConfirmPassword.alpha = 0
                self.CancelButton.alpha = 0
                self.ErrorLabel.alpha = 1
                self.ErrorLabel.text = "Password Changed"
            }else {
                self.ErrorLabel.alpha = 1
                self.ErrorLabel.text = "Error Changing password"
            }
        }else {
            self.ErrorLabel.alpha = 1
            self.ErrorLabel.text = ok
        }
    }
    
    //Action Function - cancel changed password
    @IBAction func CancelPressed(_ sender: UIButton) {
        Password.alpha = 0
        ConfirmPassword.alpha = 0
        SavePassword.alpha = 0
        CancelButton.alpha = 0
        ErrorLabel.alpha = 0
    }

    //Action Function - logout back to start screen
    @IBAction func LogOutPressed(_ sender: UIBarButtonItem) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.ViewController) as? ViewController
        self.view.window?.rootViewController = ViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Shows user information about the page
    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "Choose between viewing, adding and editing tips for the users, managing users accounts which have been inactive for 90+ days, and managing your own account", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //Function - check fields and validate data is correct, if correct return nil else error messsage
    func validateFields() -> String?{
        //check all fields filled in
        if Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        let cleanedPassword =  ConfirmPassword!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedConfirmPassword = Password!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //check if password is secure
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure password is at least 8 characters long, contains one special character and one number"
        } else if cleanedConfirmPassword != cleanedPassword {
            return "Passwords do not match"
        }
        return nil
    }
    
    //Function - allows the keyboard to hide
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
