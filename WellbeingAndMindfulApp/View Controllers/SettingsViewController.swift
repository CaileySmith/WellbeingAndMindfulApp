//
//  SettingsViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit
import Firebase

//ViewController Class - Settings screen
class SettingsViewController: UIViewController {

    //Variables - Outlets to the view
    @IBOutlet weak var ViewAccButton: UIButton!
    @IBOutlet weak var DeleteAcc: UIButton!
    @IBOutlet weak var ColourSchemeButton: UIButton!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    
    //Variables
    var colour = "green"
    var level = 1
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up the view
        switch colour {
        case "green": do {
            StyleSheet.styleFilledButtonLevel1(ViewAccButton)
            StyleSheet.styleFilledButtonLevel1(DeleteAcc)
            StyleSheet.styleFilledButtonLevel1(ColourSchemeButton)
            StyleSheet.styleBarButtonLevel1(HomeButton)
        }
        case "purple": do {
            StyleSheet.styleFilledButtonLevel2(ViewAccButton)
            StyleSheet.styleFilledButtonLevel2(DeleteAcc)
            StyleSheet.styleFilledButtonLevel2(ColourSchemeButton)
            StyleSheet.styleBarButtonLevel2(HomeButton)
        }
        case "blue": do {
            StyleSheet.styleFilledButtonLevel3(ViewAccButton)
            StyleSheet.styleFilledButtonLevel3(DeleteAcc)
            StyleSheet.styleFilledButtonLevel3(ColourSchemeButton)
            StyleSheet.styleBarButtonLevel3(HomeButton)
        }
        case "orange": do {
            StyleSheet.styleFilledButtonExtra1(ViewAccButton)
            StyleSheet.styleFilledButtonExtra1(DeleteAcc)
            StyleSheet.styleFilledButtonExtra1(ColourSchemeButton)
            StyleSheet.styleBarButtonExtra1(HomeButton)
        }
        case "pink" : do {
            StyleSheet.styleFilledButtonExtra2(ViewAccButton)
            StyleSheet.styleFilledButtonExtra2(DeleteAcc)
            StyleSheet.styleFilledButtonExtra2(ColourSchemeButton)
            StyleSheet.styleBarButtonExtra2(HomeButton)
        }
        default: do {}
        }
        //restrictions based on level
        switch level {
        case 1: do {
            ColourSchemeButton.alpha = 0
        }
        case 2: do {
            ColourSchemeButton.alpha = 0
        }
        case 3: do {
            ColourSchemeButton.alpha = 1
        }
        default: do {}
        }
    }
    
    //Action Function - Shows view account page
    @IBAction func ViewAccPressed(_ sender: UIButton) {
        let ViewAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.ViewAccountViewController) as? ViewAccountViewController
        ViewAccountViewController?.colour = colour
        ViewAccountViewController?.level = level
         view.window?.rootViewController = ViewAccountViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - back to homepage
    @IBAction func HomePressed(_ sender: UIBarButtonItem) {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    //Action Function - chnages to colour scheme view
    @IBAction func ColourSchemePressed(_ sender: UIButton) {
        let ColourViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.ColourViewController) as? ColourViewController
        ColourViewController?.colour = colour
        ColourViewController?.level = level
         view.window?.rootViewController = ColourViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Deleting user
    @IBAction func DeleteAccPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete Account", message: "Do you wish to permenantly delete your account and all data?", preferredStyle: UIAlertController.Style.alert)
        //if they want to delete
        let confirm = UIAlertAction(title: "Confirm Delete", style: .default){
        (action:UIAlertAction!)in
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            if let user = user {
                let userid = user.uid
                //delete all from main database
                db.collection("users").document(userid).delete()
                //delete from authentication database
                user.delete()
                let alrt = UIAlertController(title: "Delete Account", message: "Account deleted", preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "Okay", style: .default){
                    //back to start screen
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
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
