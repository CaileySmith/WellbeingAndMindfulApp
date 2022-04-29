//
//  ShowTipsViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 02/03/2022.
//

import UIKit
import Firebase

//ViewController Class - Show Tips screen
class ShowTipsViewController: UIViewController {
    
    //Variables - outlets for view
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var tipText: UITextView!
    
    //Variables
    var colour = "green"
    var admin = false
    public var tipTitle: String = ""
    public var tipInfo: String  = ""
    public var tipId: String = "99"

    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up for view
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
        titleText.text = tipTitle
        tipText.text = tipInfo
        //admin set up
        switch admin {
        case true : do {
            editButton.title = "Edit"
            editButton.isEnabled = true
        }default: do {
            editButton.title = ""
            editButton.isEnabled = false
        }
        }
        saveButton.title = ""
        deleteButton.title = ""
        titleText.isEditable = false
        tipText.isEditable = false
    }
    
    //Action Function - when edit is pressed show save and delete
    @IBAction func EditButtonPressed(_ sender: UIBarButtonItem) {
        saveButton.title = "Save"
        deleteButton.title = "Delete"
        titleText.isEditable = true
        tipText.isEditable = true
    }
    
    //Action Function - Save edit of tip
    @IBAction func SavedPressed(_ sender: UIBarButtonItem) {
        let title = titleText.text
        let information = tipText.text
        if title == "" || information == ""{
            tipText.text = "Please fill out title and tip"
        }else {
            //updates tip
            let db = Firestore.firestore()
            db.collection("tips").document(self.tipId).setData(["title": title!, "information": information!], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
            
            let alert = UIAlertController(title: "Tips", message: "Tip edited", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Okay", style: .default){
            (action:UIAlertAction!)in
                self.back()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            }
            }
        }
    }
    
    //Action Function - Delete the tip
    @IBAction func DeletePressed(_ sender: UIBarButtonItem) {
        let refreshAlert = UIAlertController(title: "Tip", message: "Are you sure you want to delete tip", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            let db = Firestore.firestore()
            //delete tip from database
            db.collection("tips").document(self.tipId).delete(){ err in
            if let err = err {
                print("Error deleting document: \(err)")
            } else {
                let alert = UIAlertController(title: "Tips", message: "Tip deleted", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "Okay", style: .default){
                (action:UIAlertAction!)in
                    self.back()
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            }
        }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    //Action Function - back to tips
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        back()
    }
    
    //Function - back to tip view
    func back(){
        let TipsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TipsViewController) as? TipsViewController
        TipsViewController?.colour = colour
        TipsViewController?.admin = admin
         view.window?.rootViewController = TipsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleBarButtonLevel1(BackButton)
        StyleSheet.styleTextViewLevel1(titleText)
        StyleSheet.styleBarButtonLevel1(editButton)
        StyleSheet.styleBarButtonLevel1(saveButton)
        StyleSheet.styleBarButtonLevel1(deleteButton)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleBarButtonLevel2(BackButton)
        StyleSheet.styleTextViewLevel2(titleText)
        StyleSheet.styleBarButtonLevel2(editButton)
        StyleSheet.styleBarButtonLevel2(saveButton)
        StyleSheet.styleBarButtonLevel2(deleteButton)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleBarButtonLevel3(BackButton)
        StyleSheet.styleTextViewLevel3(titleText)
        StyleSheet.styleBarButtonLevel3(editButton)
        StyleSheet.styleBarButtonLevel3(saveButton)
        StyleSheet.styleBarButtonLevel3(deleteButton)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleBarButtonExtra1(BackButton)
        StyleSheet.styleTextViewExtra1(titleText)
        StyleSheet.styleBarButtonExtra1(editButton)
        StyleSheet.styleBarButtonExtra1(saveButton)
        StyleSheet.styleBarButtonExtra1(deleteButton)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleBarButtonExtra2(BackButton)
        StyleSheet.styleTextViewExtra2(titleText)
        StyleSheet.styleBarButtonExtra2(editButton)
        StyleSheet.styleBarButtonExtra2(saveButton)
        StyleSheet.styleBarButtonExtra2(deleteButton)
    }
}
