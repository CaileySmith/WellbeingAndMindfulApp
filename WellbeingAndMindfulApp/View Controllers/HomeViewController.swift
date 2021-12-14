//
//  HomeViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/12/2021.
//

import UIKit

class HomeViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleHomeButtonsLevel3(JournalButton)
        Utilities.styleHomeButtonsLevel3(BreatheButton)
        Utilities.styleHomeButtonsLevel3(GroundButton)
        Utilities.styleHomeButtonsLevel3(SleepButton)
        Utilities.styleHomeButtonsLevel3(CheckInButton)
        Utilities.styleHomeButtonsLevel3(ExerciseButton)
        Utilities.styleHomeButtonsLevel3(TipsButton)
        Utilities.styleHomeButtonsLevel3(ConnectButton)
        Utilities.styleHomeButtonsLevel3(MeditateButton)
        Utilities.styleHomeButtonsLevel3(TrackingButton)
        Utilities.styleBarButtonLevel3(LogOutButton)
        Utilities.styleBarButtonLevel3(SettingsButton)
    

        // Do any additional setup after loading the view.
    }
    
    @IBAction func JournalTapped(_ sender: Any) {
        let journalViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.journalViewController) as? JournalViewController
         self.view.window?.rootViewController = journalViewController
         self.view.window?.makeKeyAndVisible()
    }
}
