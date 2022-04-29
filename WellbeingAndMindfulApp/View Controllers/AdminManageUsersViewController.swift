//
//  AdminManageUsersViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 05/04/2022.
//

import UIKit
import Firebase
import Foundation
import MessageUI

//ViewController Class - Admin manage users screen
class AdminManageUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //Variables - outlets for view
    @IBOutlet weak var NonActiveTableView: UITableView!
    @IBOutlet weak var ActiveMessage: UITextView!
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    
    //Variables
    var email = ""
    var list: Array<User> = []
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up style for view
        self.NonActiveTableView.delegate = self
        NonActiveTableView.dataSource = self
        StyleSheet.styleBarButtonLevel1(BackButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
    
        //gets users from database which have not been active for over 90 days
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
                    let database = Firestore.firestore()
                    database.collection("users").document(userid).collection("track").document("tracking").getDocument{(doc, error) in
                    if let doc = doc, doc.exists {
                        let all = doc.get("all") as? [String: Any]
                        let date = all?["date"] as? String ?? ""
                        let days = Date().days90(using: .gregorian).map(\.MMMMddyyyy)
                        if days.contains(date){
                        }else {
                            self.list.insert(User(email: mail, uid: userid, date: date), at: self.list.count)
                        }
                    }
                    }
                        }
                    }
                }
            }
        }
        //Takes in account delay from database
        var x = 0.1
        for _ in 0...60{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){
               self.NonActiveTableView.reloadData()
                if (self.list.isEmpty){
                    self.NonActiveTableView.backgroundView = self.ActiveMessage
                    self.ActiveMessage.alpha = 1
                }
            }
            x = x + 0.1
        }
    }
    
    //Action Function - back to admin home
    @IBAction func BackPressed(_ sender: UIBarButtonItem) {
        let AdminHomeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.AdminHomeViewController) as? AdminHomeViewController
         self.view.window?.rootViewController = AdminHomeViewController
         self.view.window?.makeKeyAndVisible()
    }
    
    //Action function - tells user what to do on the screen
    @IBAction func InfoButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "Click on any accounts which have been inactive and send them an informed message to let them know.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - did select row at
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NonActiveTableView.deselectRow(at: indexPath, animated: true)
        let email = list[indexPath.row].email
        //opens mail
        showMailComposer(mail: email)
    }
    
    //Function - opens up a mail sender with premade email ready to send
    @objc func showMailComposer(mail: String){
        guard MFMailComposeViewController.canSendMail() else {
            print("fail")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([mail])
        composer.setSubject("Wellbeing and Mindful Healthy Habits Non-Active Account")
        composer.setMessageBody("Hi User! \nUnfortunately your account has been inactive for over 90 days", isHTML: false)
        present(composer, animated: true)
    }
    
    //Function - number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    //Function - cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // set the text from the data model
        cell.textLabel?.text = "\(self.list[indexPath.row].email): \(self.list[indexPath.row].date)"
        return cell
    }
}

//Extension - mail delegate
extension AdminManageUsersViewController: MFMailComposeViewControllerDelegate {
    //Function - did finish with
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            break
        case .failed:
            break
        case .saved:
            break
        case .sent:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

