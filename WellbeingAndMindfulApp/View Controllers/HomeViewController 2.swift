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
        
        Utilities.styleHomeButtonsLevel1(JournalButton)
        Utilities.styleHomeButtonsLevel1(BreatheButton)
        Utilities.styleHomeButtonsLevel1(GroundButton)
        Utilities.styleHomeButtonsLevel1(SleepButton)
        Utilities.styleHomeButtonsLevel1(CheckInButton)
        Utilities.styleHomeButtonsLevel1(ExerciseButton)
        Utilities.styleHomeButtonsLevel1(TipsButton)
        Utilities.styleHomeButtonsLevel1(ConnectButton)
        Utilities.styleHomeButtonsLevel1(MeditateButton)
        Utilities.styleHomeButtonsLevel1(TrackingButton)
        Utilities.styleBarButtonLevel1(LogOutButton)
        Utilities.styleBarButtonLevel1(SettingsButton)
    

        // Do any additional setup after loading the view.
    }
    
    @IBAction func JournalTapped(_ sender: Any) {
        let journalViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.journalViewController) as? JournalViewController
         self.view.window?.rootViewController = journalViewController
         self.view.window?.makeKeyAndVisible()
    }
}
