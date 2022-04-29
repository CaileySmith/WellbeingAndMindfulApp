//
//  CalendarTrackViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 29/04/2022.
//

import UIKit
import SwiftUI
import Firebase

class CalendarTrackViewController: UIViewController {

    @IBOutlet weak var ContainView: UIView!
    
    var colour = "green"
    var category = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //get track for current month
//        var journalList: Array<Journal> = []
//        var breathList: Array<Breathe> = []
//        var groundList: Array<Ground> = []
//        var sleepList: Array<Sleep> = []
//        var checkInList: Array<CheckIn> = []
//        var exerciseList: Array<Exercise> = []
//        var meditateList: Array<Meditate> = []
//        let db = Firestore.firestore()
//        let cat = category.lowercased()
//              let user = Auth.auth().currentUser
//                if let user = user {
//                    let userid = user.uid
//                    db.collection("users").document(userid).collection("daily").whereField(cat, isEqualTo: "tracked").getDocuments{ (querySnapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                        }else{
//                            for document in querySnapshot!.documents {
//                               // self.list.insert(Track(date: document.documentID), at: self.list.count)
//                                switch cat{
//                                case "journal": do{
//                                    for document in querySnapshot!.documents {
//                                        journalList.insert(Journal(entry: document["entry"] as? String ?? ""), at: journalList.count)
//                                    }
//                                }
//                                case "breathe": do{
//                                    for document in querySnapshot!.documents {
//                                        breathList.insert(Breathe(time: document["minutes"] as? Int ?? 0, technique: document["technique"] as? String ?? ""), at: breathList.count)
//                                    }
//                                }
//                                case "ground": do{
//                                    for document in querySnapshot!.documents {
//                                        groundList.insert(Ground(hear: document["hear"] as? Array<String> ?? [], see: document["see"] as? Array<String> ?? [], touch: document["touch"] as? Array<String> ?? [], smell: document["smell"] as? Array<String> ?? [], taste: document["taste"] as? String ?? ""), at: groundList.count)
//                                    }
//                                }
//                                case "sleep": do{
//                                    for document in querySnapshot!.documents {
//                                        sleepList.insert(Sleep(length: document["length"] as? String ?? "", quality: document["quality"] as? Int ?? 0), at: sleepList.count)
//                                    }
//                                }
//                                case "checkin": do{
//                                    for document in querySnapshot!.documents {
//                                        checkInList.insert(CheckIn(mood: document["mood"] as? String ?? "", input: document["input"] as? String ?? "", rating: document["rating"] as? Int ?? 0, tod: document.documentID), at: checkInList.count)
//                                    }
//                                }
//                                case "exercise": do{
//                                    for document in querySnapshot!.documents {
//                                        exerciseList.insert(Exercise(type: document["type"] as? String ?? "", hour: document["hour"] as? Int ?? 0, min: document["minutes"] as? Int ?? 0), at: exerciseList.count)
//                                    }
//                                }
//                                case "meditate": do{
//                                    for document in querySnapshot!.documents {
//                                        meditateList.insert(Meditate(type: document["type"] as? String ?? "", track: document["track"] as? Int ?? 0, time: document["time"] as? Int ?? 0), at: exerciseList.count)
//                                    }
//                                }
//                                default: do{ }
//                                }
//                            }
//                            }
//                        }
//                    }
        
        
                
        let childView = UIHostingController(rootView: HomeSwiftUIView())
        addChild(childView)
        childView.view.frame = ContainView.bounds
        ContainView.addSubview(childView.view)
    }
}
