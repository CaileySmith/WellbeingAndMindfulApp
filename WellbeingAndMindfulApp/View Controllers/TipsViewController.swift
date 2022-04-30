//
//  TipsViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit
import SwiftUI
import Firebase

//ViewController Class - Tips screen
class TipsViewController: UIViewController {

    //Variables - outlets for views
    @IBOutlet weak var TipsTableView: UITableView!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var AddButton: UIBarButtonItem!
    @IBOutlet weak var noRecords: UITextView!
    
    //Variables
    var colour = "green"
    var list: Array<Tips> = []
    var admin = false
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up view elements
        self.TipsTableView.delegate = self
        self.TipsTableView.dataSource = self
        TipsTableView.separatorColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
        TipsTableView.tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
        switch colour {
        case "green": do {
            StyleSheet.styleBarButtonLevel1(HomeButton)
            StyleSheet.styleBarButtonLevel1(AddButton)
        }
        case "purple": do {
            StyleSheet.styleBarButtonLevel2(HomeButton)
            StyleSheet.styleBarButtonLevel2(AddButton)
        }
        case "blue": do {
            StyleSheet.styleBarButtonLevel3(HomeButton)
            StyleSheet.styleBarButtonLevel3(AddButton)
        }
        case "orange": do {
            StyleSheet.styleBarButtonExtra1(HomeButton)
            StyleSheet.styleBarButtonExtra1(AddButton)
        }
        case "pink" : do {
            StyleSheet.styleBarButtonExtra2(HomeButton)
            StyleSheet.styleBarButtonExtra2(AddButton)
        }
        default: do {}
        }
        //allows for admin
        switch admin {
        case true : do {
            AddButton.title = "Add"
            AddButton.isEnabled = true
        }default: do {
            AddButton.title = ""
            AddButton.isEnabled = false
        }
        }

        //gets tips from database
        let db = Firestore.firestore()
        db.collection("tips").getDocuments { [self] snapshot, error in
            if error == nil {
                if let snapshot = snapshot{
                    for doc in snapshot.documents {
                        self.list.insert(Tips(id: doc.documentID, title: doc["title"] as? String ?? "", information: doc["information"] as? String ?? ""), at: list.count)
                    }
                }
            }else {
                print("error")
            }
        }
        //loads tips in, taking in account delay
        var x = 0.1
        for _ in 0...10{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){
                self.TipsTableView.reloadData()
                if self.list.isEmpty {
                    self.noRecords.alpha = 1
                }else {
                    self.noRecords.alpha = 0
                }
            }
            x = x + 0.1
        }
    }
    
    //Action Function - Add tips
    @IBAction func AddTipsPressed(_ sender: UIBarButtonItem) {
        let AddTipsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.AddTipsViewController) as? AddTipsViewController
        AddTipsViewController?.colour = colour
        AddTipsViewController?.admin = admin
         view.window?.rootViewController = AddTipsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - home pressed
    @IBAction func HomePressed(_ sender: UIBarButtonItem) {
        if admin == false {
            let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
             view.window?.rootViewController = homeViewController
             view.window?.makeKeyAndVisible()
        }else {
            let AdminHomeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.AdminHomeViewController) as? AdminHomeViewController
             self.view.window?.rootViewController = AdminHomeViewController
             self.view.window?.makeKeyAndVisible()
        }
    }
}

//Extension - table view delegate
extension TipsViewController: UITableViewDelegate{
    
    //Function - did select row at
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TipsTableView.deselectRow(at: indexPath, animated: true)
        let tip = list[indexPath.row]
        let ShowTipsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.ShowTipsViewController) as? ShowTipsViewController
        ShowTipsViewController?.tipTitle = tip.title
        ShowTipsViewController?.tipInfo = tip.information
        ShowTipsViewController?.tipId = tip.id
        ShowTipsViewController?.colour = colour
        ShowTipsViewController?.admin = admin
         view.window?.rootViewController = ShowTipsViewController
         view.window?.makeKeyAndVisible()
    }
}

//Extension - table view data source
extension TipsViewController: UITableViewDataSource{
    
    //Function - number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    //Function - cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tipCell = tableView.dequeueReusableCell(withIdentifier: "tipCell", for: indexPath)
        let tips = list[indexPath.row]
        tipCell.textLabel?.text = tips.title
        return tipCell
    }
    
    //Function - height for row at
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Swift 4.2 onwards
        return UITableView.automaticDimension
    }
}
