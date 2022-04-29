//
//  ColourViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 03/04/2022.
//

import UIKit
import Firebase

//ViewController Class - colour screen
class ColourViewController: UIViewController {

    //Variables- outlets for view
    @IBOutlet weak var PinkButton: UIButton!
    @IBOutlet weak var OrangeButton: UIButton!
    @IBOutlet weak var BlueButton: UIButton!
    @IBOutlet weak var PurpleButton: UIButton!
    @IBOutlet weak var GreenButton: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var BackButton: UIBarButtonItem!
    
    //Variables
    var colour = "green"
    var level = 1
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //style elements
        switch colour {
        case "green": do {
            StyleSheet.styleLabelLevel1(TitleLabel)
            StyleSheet.styleBarButtonLevel1(BackButton)
            StyleSheet.styleFilledButtonLevel1(GreenButton)
            StyleSheet.styleFilledButtonLevel2(PurpleButton)
            StyleSheet.styleFilledButtonLevel3(BlueButton)
            StyleSheet.styleFilledButtonExtra1(OrangeButton)
            StyleSheet.styleFilledButtonExtra2(PinkButton)
        }
        case "purple": do {
            StyleSheet.styleLabelLevel2(TitleLabel)
            StyleSheet.styleBarButtonLevel2(BackButton)
            StyleSheet.styleFilledButtonLevel1(GreenButton)
            StyleSheet.styleFilledButtonLevel2(PurpleButton)
            StyleSheet.styleFilledButtonLevel3(BlueButton)
            StyleSheet.styleFilledButtonExtra1(OrangeButton)
            StyleSheet.styleFilledButtonExtra2(PinkButton)
        }
        case "blue": do {
            StyleSheet.styleLabelLevel3(TitleLabel)
            StyleSheet.styleBarButtonLevel3(BackButton)
            StyleSheet.styleFilledButtonLevel1(GreenButton)
            StyleSheet.styleFilledButtonLevel2(PurpleButton)
            StyleSheet.styleFilledButtonLevel3(BlueButton)
            StyleSheet.styleFilledButtonExtra1(OrangeButton)
            StyleSheet.styleFilledButtonExtra2(PinkButton)
        }
        case "orange": do {
            StyleSheet.styleLabelExtra1(TitleLabel)
            StyleSheet.styleBarButtonExtra1(BackButton)
            StyleSheet.styleFilledButtonLevel1(GreenButton)
            StyleSheet.styleFilledButtonLevel2(PurpleButton)
            StyleSheet.styleFilledButtonLevel3(BlueButton)
            StyleSheet.styleFilledButtonExtra1(OrangeButton)
            StyleSheet.styleFilledButtonExtra2(PinkButton)
        }
        case "pink" : do {
            StyleSheet.styleLabelExtra2(TitleLabel)
            StyleSheet.styleBarButtonExtra2(BackButton)
            StyleSheet.styleFilledButtonLevel1(GreenButton)
            StyleSheet.styleFilledButtonLevel2(PurpleButton)
            StyleSheet.styleFilledButtonLevel3(BlueButton)
            StyleSheet.styleFilledButtonExtra1(OrangeButton)
            StyleSheet.styleFilledButtonExtra2(PinkButton)
        }
        default: do {}
        }
    }
    
    //Action function - update to green
    @IBAction func GreenPressed(_ sender: UIButton) {
       updateDB(col: "green")
    }
    
    //Action function - update to purple
    @IBAction func PurplePressed(_ sender: UIButton) {
        updateDB(col: "purple")
    }
    
    //Action function - update to blue
    @IBAction func BluePressed(_ sender: UIButton) {
        updateDB(col: "blue")
    }

    //Action function - update to orange
    @IBAction func OrangePressed(_ sender: UIButton) {
        updateDB(col: "orange")
    }
    
    //Action function - update to pink
    @IBAction func PinkPressed(_ sender: UIButton) {
        updateDB(col: "pink")
    }
    
    //Action function - back to settings view
    @IBAction func BackPressed(_ sender: UIBarButtonItem) {
        let SettingsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.SettingsViewController) as? SettingsViewController
        SettingsViewController?.colour = colour
        SettingsViewController?.level = level
         view.window?.rootViewController = SettingsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function- updates the colour in the database
    func updateDB(col: String){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).setData(["colour": col], merge: true)
            let alert = UIAlertController(title: "Colour Scheme", message: "Colour changed to \(col)", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "Okay", style: .default){
            (action:UIAlertAction!)in
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Colour Scheme", message: "Error changing colour", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "Okay", style: .default){
            (action:UIAlertAction!)in
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
