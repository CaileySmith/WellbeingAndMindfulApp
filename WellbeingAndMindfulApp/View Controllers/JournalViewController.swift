//
//  JournalViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit
import Firebase

//ViewController Class - Journal screen
class JournalViewController: UIViewController {

    //Variables - outlets for view
    @IBOutlet weak var NavBar: UINavigationItem!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var JournalEntryTextView: UITextView!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var DatePick: UIDatePicker!
    @IBOutlet weak var PromptButton: UIBarButtonItem!
    
    //Variables
    var colour = "green"
    var level = 1
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        //sets up style of view elements
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
        //only if they are level three they can access prompts
        if level == 3 {
            PromptButton.isEnabled = true
            PromptButton.title = "Prompts"
        }else {
            PromptButton.isEnabled = false
            PromptButton.title = ""
        }
        //connects to database- loads up an existing journal entry
        let db = Firestore.firestore()
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let d = formatter.string(from: date)
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
        let dateRef = db.collection("users").document(userid).collection("daily").document(d).collection("journal").document("1")
            dateRef.getDocument { (document, error) in
                if let document = document , document.exists{
                    let entry = document.get("entry") as? String
                    self.JournalEntryTextView.text = entry
                }else {
                    print("doc not exist")
                }
            }
        }
    }
    
    //Action Function - Save journal entry
    @IBAction func SaveJournal(_ sender: UIButton) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let today = formatter.string(from: date)
        let entry = JournalEntryTextView.text!
        if ((entry == "Today...")||(entry == "")){
            messageBox(message: "Please enter todays journal")
        }else{
            //sends entry to view model
            let message = JournalViewModel.JournalSaveVM(entry: entry)
            let response = message + " for " + today
            messageBox(message: response)
        }
    }
    
    //Action Function - Prompt pressed
    @IBAction func promptPressed(_ sender: UIBarButtonItem) {
        //prompts
        let p1 = "What are my weekly goals?"
        let p2 = "What is a positive memory from today?"
        let p3 = "What will I do differently tomorrow?"
        let p4 = "What are key takeaways from today?"
        let p5 = "What challenges have I overcome today?"
        let p6 = "An act of kindness from today was?"
        let p7 = "What held me back today?"
        //adds all prompts to an alert message box
        let alert = UIAlertController(title: "Journal", message: "Choose a prompt", preferredStyle: UIAlertController.Style.alert)
        let prompt1 = UIAlertAction(title: p1, style: .default){
        (action:UIAlertAction!)in
            self.JournalEntryTextView.text = self.JournalEntryTextView.text + "\n" + p1
        }
        let prompt2 = UIAlertAction(title: p2, style: .default){
        (action:UIAlertAction!)in
            self.JournalEntryTextView.text = self.JournalEntryTextView.text + "\n" + p2
        }
        let prompt3 = UIAlertAction(title: p3, style: .default){
        (action:UIAlertAction!)in
            self.JournalEntryTextView.text = self.JournalEntryTextView.text + "\n" + p3
        }
        let prompt4 = UIAlertAction(title: p4, style: .default){
        (action:UIAlertAction!)in
            self.JournalEntryTextView.text = self.JournalEntryTextView.text + "\n" + p4
        }
        let prompt5 = UIAlertAction(title: p5, style: .default){
        (action:UIAlertAction!)in
            self.JournalEntryTextView.text = self.JournalEntryTextView.text + "\n" + p5
        }
        let prompt6 = UIAlertAction(title: p6, style: .default){
        (action:UIAlertAction!)in
            self.JournalEntryTextView.text = self.JournalEntryTextView.text + "\n" + p6
        }
        let prompt7 = UIAlertAction(title: p7, style: .default){
        (action:UIAlertAction!)in
            self.JournalEntryTextView.text = self.JournalEntryTextView.text + "\n" + p7
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){
        (action:UIAlertAction!)in
            
        }
        alert.addAction(prompt1)
        alert.addAction(prompt2)
        alert.addAction(prompt3)
        alert.addAction(prompt4)
        alert.addAction(prompt5)
        alert.addAction(prompt6)
        alert.addAction(prompt7)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Action Function - choosing date
    @IBAction func DatePicked(_ sender: UIDatePicker) {
        let day = DatePick.date
        let date = Date()
        let chosenDate = day.MMMMddyyyy
        let today = date.MMMMddyyyy
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document("\(chosenDate)").getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    let database = Firestore.firestore()
                    database.collection("users").document(userid).collection("daily").document("\(chosenDate)").collection("journal").getDocuments{ (snap , err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        }else{
                            for doc in snap!.documents {
                                let entry = doc.get("entry") as? String ?? ""
                                if entry == "" {
                                    self.JournalEntryTextView.text = "No entry for \(chosenDate)"
                                    self.JournalEntryTextView.isEditable = false
                                    self.SaveButton.isEnabled = false
                                    self.PromptButton.isEnabled = false
                                    self.PromptButton.title = ""
                                }else {
                                    self.JournalEntryTextView.text = entry
                                    if chosenDate == today {
                                        self.JournalEntryTextView.isEditable = true
                                        self.SaveButton.isEnabled = true
                                        if self.level == 3 {
                                            self.PromptButton.isEnabled = true
                                            self.PromptButton.title = "Prompts"
                                        }else {
                                            self.PromptButton.isEnabled = false
                                            self.PromptButton.title = ""
                                        }
                                    }else {
                                        self.JournalEntryTextView.isEditable = false
                                        self.SaveButton.isEnabled = false
                                        self.PromptButton.isEnabled = false
                                        self.PromptButton.title = ""
                                    }
                                }
                            }
                        }
                    }
                }else {
                    self.JournalEntryTextView.text = "No entry for \(chosenDate)"
                    self.JournalEntryTextView.isEditable = false
                    self.SaveButton.isEnabled = false
                    self.PromptButton.isEnabled = false
                    self.PromptButton.title = ""
                }
            }
        }
    }
    
    //Function - message box creater
    func messageBox(message : String){
        let alert = UIAlertController(title: "Journal", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay", style: .default){
        (action:UIAlertAction!)in
            if message.contains("Journal Saved"){
                self.transitionToHome()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Transitions to home
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //Function - allows the keyboard to hide
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleFilledButtonLevel1(SaveButton)
        StyleSheet.styleBarButtonLevel1(HomeButton)
        StyleSheet.styleBarButtonLevel1(PromptButton)
        DatePick.tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleFilledButtonLevel2(SaveButton)
        StyleSheet.styleBarButtonLevel2(HomeButton)
        StyleSheet.styleBarButtonLevel2(PromptButton)
        DatePick.tintColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleFilledButtonLevel3(SaveButton)
        StyleSheet.styleBarButtonLevel3(HomeButton)
        StyleSheet.styleBarButtonLevel3(PromptButton)
        DatePick.tintColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleFilledButtonExtra1(SaveButton)
        StyleSheet.styleBarButtonExtra1(HomeButton)
        StyleSheet.styleBarButtonExtra1(PromptButton)
        DatePick.tintColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleFilledButtonExtra2(SaveButton)
        StyleSheet.styleBarButtonExtra2(HomeButton)
        StyleSheet.styleBarButtonExtra2(PromptButton)
        DatePick.tintColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
    }
}
