//
//  AddTipsViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 02/03/2022.
//

import UIKit
import Firebase

//ViewController Class - Add Tips screen
class AddTipsViewController: UIViewController {
    
    //Variables - outlets for view
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var TipText: UITextView!
    @IBOutlet weak var TipTitle: UITextField!
    @IBOutlet weak var AddTipButton: UIBarButtonItem!
    
    //Variables
    var admin = false
    var colour = "green"
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up for view
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
    }
    
    //Action Function - Adding new tip
    @IBAction func AddTipPressed(_ sender: UIBarButtonItem) {
        let title = TipTitle.text
        let information = TipText.text
        if title == "" || information == ""{
            TipText.text = "Please fill out title and tip"
        }else {
            //adds new tip to database
            let db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("tips").addDocument(data:["title": title!, "information": information!]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                        let alert = UIAlertController(title: "Tips", message: "Tip added", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "OK", style: .default){
                        (action:UIAlertAction!)in
                            self.back()
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //Action Function - Back to tips
    @IBAction func BackPressed(_ sender: UIBarButtonItem) {
        back()
    }
    
    //Function - bakc to tips screen
    func back(){
        let TipsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TipsViewController) as? TipsViewController
        TipsViewController?.colour = colour
        TipsViewController?.admin = admin
         view.window?.rootViewController = TipsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function - allows keyboard to hide
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleBarButtonLevel1(BackButton)
        StyleSheet.styleBarButtonLevel1(AddTipButton)
        StyleSheet.styleTextFieldLevel1(TipTitle)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleBarButtonLevel2(BackButton)
        StyleSheet.styleBarButtonLevel2(AddTipButton)
        StyleSheet.styleTextFieldLevel2(TipTitle)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleBarButtonLevel3(BackButton)
        StyleSheet.styleBarButtonLevel3(AddTipButton)
        StyleSheet.styleTextFieldLevel3(TipTitle)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleBarButtonExtra1(BackButton)
        StyleSheet.styleBarButtonExtra1(AddTipButton)
        StyleSheet.styleTextFieldExtra1(TipTitle)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleBarButtonExtra2(BackButton)
        StyleSheet.styleBarButtonExtra2(AddTipButton)
        StyleSheet.styleTextFieldExtra2(TipTitle)
    }
}
