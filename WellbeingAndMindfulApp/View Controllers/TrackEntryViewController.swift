//
//  TrackEntryViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/03/2022.
//

import UIKit
import Firebase

//ViewController Class - track entry screen
class TrackEntryViewController: UIViewController, UITableViewDelegate {

    //Variables - outlets for view
    @IBOutlet weak var entrysTable: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    
    //Variables
    public var date = ""
    public var category = ""
    var journalList: Array<Journal> = []
    var breathList: Array<Breathe> = []
    var groundList: Array<Ground> = []
    var sleepList: Array<Sleep> = []
    var checkInList: Array<CheckIn> = []
    var exerciseList: Array<Exercise> = []
    var meditateList: Array<Meditate> = []
    var colour = "green"
  
    //Function - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up for view
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
        self.entrysTable.dataSource = self
        self.entrysTable.delegate = self
        print(date, category)
        //calls database
        dbCall()
        //reloads table
        var x = 0.1
        for _ in 0...30{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){
                        self.entrysTable.reloadData()
            }
            x = x + 0.1
        }
    }
    
    //Action Function - back to date view
    @IBAction func BackButtonPressed(_ sender: UIBarButtonItem) {
        let TrackMonthlyViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TrackMonthlyViewController) as? TrackMonthlyViewController
        TrackMonthlyViewController?.colour = colour
        TrackMonthlyViewController?.category = category
         view.window?.rootViewController = TrackMonthlyViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function - Calls database and fills up the table view
    func dbCall(){
        let cat = category.lowercased()
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document(date).collection(cat).getDocuments{(querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }else{
                    //different list for the different categorys
                    switch cat{
                    case "journal": do{
                        for document in querySnapshot!.documents {
                            self.journalList.insert(Journal(entry: document["entry"] as? String ?? ""), at: self.journalList.count)
                        }
                    }
                    case "breathe": do{
                        for document in querySnapshot!.documents {
                            self.breathList.insert(Breathe(time: document["minutes"] as? Int ?? 0, technique: document["technique"] as? String ?? ""), at: self.breathList.count)
                        }
                    }
                    case "ground": do{
                        for document in querySnapshot!.documents {
                            self.groundList.insert(Ground(hear: document["hear"] as? Array<String> ?? [], see: document["see"] as? Array<String> ?? [], touch: document["touch"] as? Array<String> ?? [], smell: document["smell"] as? Array<String> ?? [], taste: document["taste"] as? String ?? ""), at: self.groundList.count)
                        }
                    }
                    case "sleep": do{
                        for document in querySnapshot!.documents {
                            self.sleepList.insert(Sleep(length: document["length"] as? String ?? "", quality: document["quality"] as? Int ?? 0), at: self.sleepList.count)
                        }
                    }
                    case "checkin": do{
                        for document in querySnapshot!.documents {
                            self.checkInList.insert(CheckIn(mood: document["mood"] as? String ?? "", input: document["input"] as? String ?? "", rating: document["rating"] as? Int ?? 0, tod: document.documentID), at: self.checkInList.count)
                        }
                    }
                    case "exercise": do{
                        for document in querySnapshot!.documents {
                            self.exerciseList.insert(Exercise(type: document["type"] as? String ?? "", hour: document["hour"] as? Int ?? 0, min: document["minutes"] as? Int ?? 0), at: self.exerciseList.count)
                        }
                    }
                    case "meditate": do{
                        for document in querySnapshot!.documents {
                            self.meditateList.insert(Meditate(type: document["type"] as? String ?? "", track: document["track"] as? Int ?? 0, time: document["time"] as? Int ?? 0), at: self.exerciseList.count)
                        }
                    }
                    default: do{ }
                    }
                }
            }
        }
    }

    //Function - segue for monthly view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: TrackMonthlyViewController = segue.destination as! TrackMonthlyViewController
        secondVC.category = category
        secondVC.colour = colour
    }
}

//Extension - table data source
extension TrackEntryViewController: UITableViewDataSource{
    //Function - number of rows in selection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cat = category.lowercased()
        switch cat {
        case "journal": do{
            return journalList.count
        }
        case "breathe": do{
            return breathList.count
        }
        case "ground": do{
            return groundList.count
        }
        case "sleep": do{
            return sleepList.count
        }
        case "checkin": do{
            return checkInList.count
        }
        case "exercise": do{
            return exerciseList.count
        }
        case "meditate": do{
            return meditateList.count
        }
        default: do{
            return journalList.count
        }
        }
    }
    
    //Function - cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cat = category.lowercased()
        //formats based upon the different category
        switch cat {
        case "journal": do{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as! cellOne
            let journal = journalList[indexPath.row]
            cell.cellOne?.text = "Entry: \(journal.entry)"
            return cell
        }
        case "breathe", "sleep", "exercise", "meditate": do{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as! cellTwo
            switch cat {
            case "breathe": do{
                let breathe = breathList[indexPath.row]
                cell.cellTwoL1?.text = "Technique: \(breathe.technique)"
                cell.cellTwoL2?.text = "Length: \(breathe.time)"
                return cell
            }
            case "sleep": do{
                let sleep = sleepList[indexPath.row]
                cell.cellTwoL1?.text = "Length: \(sleep.length)"
                cell.cellTwoL2?.text = "Quality: \(sleep.quality)"
                return cell
            }
            case "exercise": do{
                let exercise = exerciseList[indexPath.row]
                cell.cellTwoL1?.text = "Type: \(exercise.type)"
                cell.cellTwoL2?.text = "Length: \(exercise.hour) hours \(exercise.min) minutes"
                return cell
            }
            case "meditate": do{
                let meditate = meditateList[indexPath.row]
                if meditate.track == 0 {
                    cell.cellTwoL1?.text = "Type: \(meditate.type)"
                    cell.cellTwoL2?.text = "Length: \(meditate.time)"
                }else{
                    cell.cellTwoL1?.text = "Type: \(meditate.type)"
                    cell.cellTwoL2?.text = "Track: \(meditate.track)"
                }
                return cell
            }
            default: do{}
            }
        }
        case "ground": do{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFour", for: indexPath) as! cellFour
            let ground = groundList[indexPath.row]
            cell.cellFourL1?.text = "Hear: \(ground.hear[0]! as String), \(ground.hear[1]! as String), \(ground.hear[2]! as String), \(ground.hear[3]! as String), \(ground.hear[4]! as String)"
            cell.cellFourL2?.text = "See: \(ground.see[0]! as String), \(ground.see[1]! as String), \(ground.see[2]! as String), \(ground.see[3]! as String)"
            cell.cellFourL3?.text = "Touch: \(ground.touch[0]! as String), \(ground.touch[1]! as String), \(ground.touch[2]! as String)"
            cell.cellFourL4?.text = "Smell: \(ground.smell[0]! as String), \(ground.smell[1]! as String)"
            cell.cellFourL5?.text = "Taste: \(ground.taste)"
            return cell
        }
        case "checkin": do{
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellThree", for: indexPath) as! cellThree
            let checkIn = checkInList[indexPath.row]
            switch checkIn.tod {
            case "1": do {
                cell.cellThreeL1?.text = "Morning"
                cell.cellThreeL2?.text = "Mood: \(checkIn.mood)"
                cell.cellThreeL3?.text = "Todays Plan: \(checkIn.input)"
                cell.cellThreeL4?.text = "Rating: \(checkIn.rating)"
                return cell
            }
            case "2": do {
                cell.cellThreeL1?.text = "Afternoon"
                cell.cellThreeL2?.text = "Mood: \(checkIn.mood)"
                cell.cellThreeL3?.text = "Hows the day going: \(checkIn.input)"
                cell.cellThreeL4?.text = "Rating: \(checkIn.rating)"
                return cell
            }
            case "3": do {
                cell.cellThreeL1?.text = "Evening"
                cell.cellThreeL2?.text = "Mood: \(checkIn.mood)"
                cell.cellThreeL3?.text = "Greatful for: \(checkIn.input)"
                cell.cellThreeL4?.text = "Rating: \(checkIn.rating)"
                return cell
            }
            case "4": do {
                cell.cellThreeL1?.text = "Night"
                cell.cellThreeL2?.text = "Mood: \(checkIn.mood)"
                cell.cellThreeL3?.text = "Todays highlight: \(checkIn.input)"
                cell.cellThreeL4?.text = "Rating: \(checkIn.rating)"
                return cell
            }
            default: do{}
            }
        }
        default: do{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as! cellTwo
            cell.cellTwoL1?.text = "error"
            return cell
        }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as! cellTwo
        cell.cellTwoL1?.text = "error"
        return cell
    }
    
    //Function - Automatically adjusts size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//Class - cell one format
class cellOne: UITableViewCell{
    @IBOutlet weak var cellOne: UILabel!
}

//Class - cell two format
class cellTwo : UITableViewCell{
    @IBOutlet weak var cellTwoL1: UILabel!
    @IBOutlet weak var cellTwoL2: UILabel!
}

//Class - cell three format
class cellThree : UITableViewCell{
    @IBOutlet weak var cellThreeL3: UILabel!
    @IBOutlet weak var cellThreeL2: UILabel!
    @IBOutlet weak var cellThreeL1: UILabel!
    @IBOutlet weak var cellThreeL4: UILabel!
}

//Class - cell four format
class cellFour : UITableViewCell{
    @IBOutlet weak var cellFourL1: UILabel!
    @IBOutlet weak var cellFourL4: UILabel!
    @IBOutlet weak var cellFourL3: UILabel!
    @IBOutlet weak var cellFourL2: UILabel!
    @IBOutlet weak var cellFourL5: UILabel!
}


