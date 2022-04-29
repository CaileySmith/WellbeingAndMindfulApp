//
//  TrackMonthlyViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 06/03/2022.
//

import UIKit
import Firebase

//ViewController Class - track monthly screen
class TrackMonthlyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    //Variables - Outlets for view
    @IBOutlet weak var TrackTableView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var noEntries: UITextView!
    
    //Variables
    var colour = "green"
    var category = ""
    var list: Array<Track> = []
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //inital set up
        noEntries.alpha = 0
        navBar.title = category
        switch colour {
        case "green": do {
            StyleSheet.styleBarButtonLevel1(backButton)
        }
        case "purple": do {
            StyleSheet.styleBarButtonLevel2(backButton)
        }
        case "blue": do {
            StyleSheet.styleBarButtonLevel3(backButton)
        }
        case "orange": do {
            StyleSheet.styleBarButtonExtra1(backButton)
        }
        case "pink" : do {
            StyleSheet.styleBarButtonExtra2(backButton)
        }
        default: do {}
        }
        let cat = category.lowercased()
        self.TrackTableView.delegate = self
        TrackTableView.dataSource = self
        //gets the data from database
        let db = Firestore.firestore()
              let user = Auth.auth().currentUser
                if let user = user {
                    let userid = user.uid
                    db.collection("users").document(userid).collection("daily").whereField(cat, isEqualTo: "tracked").getDocuments{ (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        }else{
                            for document in querySnapshot!.documents {
                                self.list.insert(Track(date: document.documentID), at: self.list.count)
                            }
                        }
                    }
                }
        //updates table
        var x = 0.1
        for _ in 0...30{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){ [self] in
                list = list.sorted {$0.date.compare($1.date, options: .numeric) == .orderedDescending}
                self.TrackTableView.reloadData()
                if (self.list.isEmpty){
                    self.TrackTableView.backgroundView = self.noEntries
                    self.noEntries.alpha = 1
                }
            }
            x = x + 0.1
        }
    }
    
    //Action Function - back to track screen
    @IBAction func BackButtonPressed(_ sender: UIBarButtonItem) {
        let TrackViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TrackViewController) as? TrackViewController
        TrackViewController?.colour = colour
         view.window?.rootViewController = TrackViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function - Number of rows in component
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    //Function - did select row at
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TrackTableView.deselectRow(at: indexPath, animated: true)
        let tip = list[indexPath.row]
        //if not journal then show records
        if category != "Journal"{
            let TrackEntrysViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TrackEntrysViewController) as? TrackEntryViewController
            TrackEntrysViewController?.category = category
            TrackEntrysViewController?.date = tip.date
            TrackEntrysViewController?.colour = colour
             view.window?.rootViewController = TrackEntrysViewController
             view.window?.makeKeyAndVisible()
        }
    }
    
    //Function - cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // set the text from the data model
        cell.textLabel?.text = self.list[indexPath.row].date
        return cell
    }
}
    
