//
//  HomeViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import UIKit
import Firebase

//ViewController Class - Home screen
class HomeViewController: UIViewController {

    //Variables
    @IBOutlet weak var LogOutButton: UIBarButtonItem!
    @IBOutlet weak var SettingsButton: UIBarButtonItem!
    @IBOutlet weak var JournalButton: UIButton!
    @IBOutlet weak var BreatheButton: UIButton!
    @IBOutlet weak var GroundButton: UIButton!
    @IBOutlet weak var SleepButton: UIButton!
    @IBOutlet weak var CheckInButton: UIButton!
    @IBOutlet weak var ExerciseButton: UIButton!
    @IBOutlet weak var TipsButton: UIButton!
    @IBOutlet weak var ConnectButton: UIButton!
    @IBOutlet weak var MeditateButton: UIButton!
    @IBOutlet weak var TrackingButton: UIButton!
    var colour: String = "green"
    var level: Int = 1
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //gets the colour and level from the database
        let db = Firestore.firestore()
        let database = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let col = document.get("colour") as? String ?? "green"
                    self.level = document.get("level") as? Int ?? 0
                    switch col {
                    case "green": do {
                        self.levelOneSetUp()
                        self.colour = "green"
                        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
                    }
                    case "purple": do {
                        self.levelTwoSetUp()
                        self.colour = "purple"
                        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1)
                    }
                    case "blue": do {
                        self.levelThreeSetUp()
                        self.colour = "blue"
                        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1)
                    }
                    case "orange": do {
                        self.extraOneSetUp()
                        self.colour = "orange"
                        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.init(red: 233/255, green: 133/255, blue: 128/255, alpha: 1)
                    }
                    case "pink" : do {
                        self.extraTwoSetUp()
                        self.colour = "pink"
                        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.init(red: 194/255, green: 93/255, blue: 149/255, alpha: 1)
                    }
                    default: do {
                        self.levelOneSetUp()
                        self.colour = "green"
                        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1)
                    }
                    }
                }
            }
            
            //updates the colour based upon the current streak
            var colour = "green"
            let databse = Firestore.firestore()
            database.collection("users").document(userid).collection("track").document("tracking").getDocument{(doc, error) in
            if let doc = doc, doc.exists {
                let all = doc.get("all") as? [String: Any]
                let streak = all?["streak"] as? String ?? "0"
                if streak == "30"{
                    self.level = 2
                    colour = "purple"
                    self.levelTwoSetUp()
                    self.colour = "purple"
                    databse.collection("users").document(userid).setData(["level" : self.level, "colour": colour], merge: true)
                }else if streak == "180"{
                    self.level = 3
                    colour = "blue"
                    self.levelThreeSetUp()
                    self.colour = "blue"
                    databse.collection("users").document(userid).setData(["level" : self.level, "colour": colour], merge: true)
                }
            }
            }
        }
    }
    
    //Action Function - Load journal screen
    @IBAction func JournalPressed(_ sender: UIButton) {
        let JournalViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.JournalViewController) as? JournalViewController
         JournalViewController?.colour = colour
         JournalViewController?.level = level
         view.window?.rootViewController = JournalViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load breathe screen
    @IBAction func BreathePressed(_ sender: UIButton) {
        let BreatheViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.BreatheViewController) as? BreatheViewController
        BreatheViewController?.colour = colour
        BreatheViewController?.level = level
         view.window?.rootViewController = BreatheViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load ground screen
    @IBAction func GroundPressed(_ sender: UIButton) {
        let GroundViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.GroundViewController) as? GroundViewController
        GroundViewController?.colour = colour
         view.window?.rootViewController = GroundViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load sleep screen
    @IBAction func SleepPressed(_ sender: UIButton) {
        let SleepViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.SleepViewController) as? SleepViewController
        SleepViewController?.colour = colour
         view.window?.rootViewController = SleepViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load settings screen
    @IBAction func SettingsPressed(_ sender: UIBarButtonItem) {
        let SettingsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.SettingsViewController) as? SettingsViewController
        SettingsViewController?.colour = colour
        SettingsViewController?.level = level
         view.window?.rootViewController = SettingsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load checkin screen
    @IBAction func CheckinPressed(_ sender: UIButton) {
        let CheckInViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.CheckInViewController) as? CheckInViewController
        CheckInViewController?.colour = colour
         view.window?.rootViewController = CheckInViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load exercise screen
    @IBAction func ExercisePressed(_ sender: UIButton) {
        let ExerciseViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.ExerciseViewController) as? ExerciseViewController
        ExerciseViewController?.colour = colour
         view.window?.rootViewController = ExerciseViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load tracking screen
    @IBAction func TrackingPressed(_ sender: UIButton) {
        let TrackViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TrackViewController) as? TrackViewController
        TrackViewController?.colour = colour
         view.window?.rootViewController = TrackViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load meditate screen
    @IBAction func MeditatePressed(_ sender: UIButton) {
        let MeditateViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.MeditateViewController) as? MeditateViewController
        MeditateViewController?.colour = colour
        MeditateViewController?.level = level 
         view.window?.rootViewController = MeditateViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load trends screen
    @IBAction func TrendPressed(_ sender: UIButton) {
        let TrendsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TrendsViewController) as? TrendsViewController
        TrendsViewController?.colour = colour
         view.window?.rootViewController = TrendsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load tips screen
    @IBAction func TipsPressed(_ sender: UIButton) {
        let TipsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.TipsViewController) as? TipsViewController
        TipsViewController?.colour = colour
         view.window?.rootViewController = TipsViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Load opening screen
    @IBAction func LogOutPressed(_ sender: UIBarButtonItem) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.ViewController) as? ViewController
        self.view.window?.rootViewController = ViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    //Function - Sets up view elements style
    func levelOneSetUp(){
        StyleSheet.styleHomeButtonsLevel1(JournalButton)
        StyleSheet.styleHomeButtonsLevel1(BreatheButton)
        StyleSheet.styleHomeButtonsLevel1(GroundButton)
        StyleSheet.styleHomeButtonsLevel1(SleepButton)
        StyleSheet.styleHomeButtonsLevel1(CheckInButton)
        StyleSheet.styleHomeButtonsLevel1(ExerciseButton)
        StyleSheet.styleHomeButtonsLevel1(TipsButton)
        StyleSheet.styleHomeButtonsLevel1(ConnectButton)
        StyleSheet.styleHomeButtonsLevel1(MeditateButton)
        StyleSheet.styleHomeButtonsLevel1(TrackingButton)
        StyleSheet.styleBarButtonLevel1(LogOutButton)
        StyleSheet.styleBarButtonLevel1(SettingsButton)
    }
    
    //Function - Sets up view elements style
    func levelTwoSetUp(){
        StyleSheet.styleHomeButtonsLevel2(JournalButton)
        StyleSheet.styleHomeButtonsLevel2(BreatheButton)
        StyleSheet.styleHomeButtonsLevel2(GroundButton)
        StyleSheet.styleHomeButtonsLevel2(SleepButton)
        StyleSheet.styleHomeButtonsLevel2(CheckInButton)
        StyleSheet.styleHomeButtonsLevel2(ExerciseButton)
        StyleSheet.styleHomeButtonsLevel2(TipsButton)
        StyleSheet.styleHomeButtonsLevel2(ConnectButton)
        StyleSheet.styleHomeButtonsLevel2(MeditateButton)
        StyleSheet.styleHomeButtonsLevel2(TrackingButton)
        StyleSheet.styleBarButtonLevel2(LogOutButton)
        StyleSheet.styleBarButtonLevel2(SettingsButton)
    }
    
    //Function - Sets up view elements style
    func levelThreeSetUp(){
        StyleSheet.styleHomeButtonsLevel3(JournalButton)
        StyleSheet.styleHomeButtonsLevel3(BreatheButton)
        StyleSheet.styleHomeButtonsLevel3(GroundButton)
        StyleSheet.styleHomeButtonsLevel3(SleepButton)
        StyleSheet.styleHomeButtonsLevel3(CheckInButton)
        StyleSheet.styleHomeButtonsLevel3(ExerciseButton)
        StyleSheet.styleHomeButtonsLevel3(TipsButton)
        StyleSheet.styleHomeButtonsLevel3(ConnectButton)
        StyleSheet.styleHomeButtonsLevel3(MeditateButton)
        StyleSheet.styleHomeButtonsLevel3(TrackingButton)
        StyleSheet.styleBarButtonLevel3(LogOutButton)
        StyleSheet.styleBarButtonLevel3(SettingsButton)
    }
    
    //Function - Sets up view elements style
    func extraOneSetUp(){
        StyleSheet.styleHomeButtonsExtra1(JournalButton)
        StyleSheet.styleHomeButtonsExtra1(BreatheButton)
        StyleSheet.styleHomeButtonsExtra1(GroundButton)
        StyleSheet.styleHomeButtonsExtra1(SleepButton)
        StyleSheet.styleHomeButtonsExtra1(CheckInButton)
        StyleSheet.styleHomeButtonsExtra1(ExerciseButton)
        StyleSheet.styleHomeButtonsExtra1(TipsButton)
        StyleSheet.styleHomeButtonsExtra1(ConnectButton)
        StyleSheet.styleHomeButtonsExtra1(MeditateButton)
        StyleSheet.styleHomeButtonsExtra1(TrackingButton)
        StyleSheet.styleBarButtonExtra1(LogOutButton)
        StyleSheet.styleBarButtonExtra1(SettingsButton)
    }
    
    //Function - Sets up view elements style
    func extraTwoSetUp(){
        StyleSheet.styleHomeButtonsExtra2(JournalButton)
        StyleSheet.styleHomeButtonsExtra2(BreatheButton)
        StyleSheet.styleHomeButtonsExtra2(GroundButton)
        StyleSheet.styleHomeButtonsExtra2(SleepButton)
        StyleSheet.styleHomeButtonsExtra2(CheckInButton)
        StyleSheet.styleHomeButtonsExtra2(ExerciseButton)
        StyleSheet.styleHomeButtonsExtra2(TipsButton)
        StyleSheet.styleHomeButtonsExtra2(ConnectButton)
        StyleSheet.styleHomeButtonsExtra2(MeditateButton)
        StyleSheet.styleHomeButtonsExtra2(TrackingButton)
        StyleSheet.styleBarButtonExtra2(LogOutButton)
        StyleSheet.styleBarButtonExtra2(SettingsButton)
    }
}
