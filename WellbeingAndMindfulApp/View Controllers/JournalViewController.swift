//
//  JournalViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit
import Firebase

class JournalViewController: UIViewController {

    @IBOutlet weak var NavBar: UINavigationItem!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var JournalEntryTextView: UITextView!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(SaveButton)
        Utilities.styleBarButtonLevel1(HomeButton)
        // Do any additional setup after loading the view.
    }


}
