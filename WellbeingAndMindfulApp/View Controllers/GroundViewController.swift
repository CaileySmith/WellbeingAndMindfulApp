//
//  GroundViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit

//ViewController Class - Ground screen
class GroundViewController: UIViewController {

    //Variables - outlets for view
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    @IBOutlet weak var ResetButton: UIBarButtonItem!
    @IBOutlet weak var TextBox1: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var TextBox5: UITextField!
    @IBOutlet weak var TextBox4: UITextField!
    @IBOutlet weak var TextBox3: UITextField!
    @IBOutlet weak var TextBox2: UITextField!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    
    //Variables
    var colour = "green"
    var count: Int = 0
    var hear : Array<String?> = []
    var see : Array<String?> = []
    var touch : Array<String?> = []
    var smell : Array<String?> = []
    var taste : String = ""
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //screen setup
        hideKeyboard()
        count = 1
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
        let message = GroundViewModel.GroundLoadVM()
        print(message)
    }
    
    //Action Function - Save pressed
    @IBAction func SaveButtonPress(_ sender: UIButton) {
        let txt1 = TextBox1.text
        let txt2 = TextBox2.text
        let txt3 = TextBox3.text
        let txt4 = TextBox4.text
        let txt5 = TextBox5.text
        //depending on what sense they are on
        switch count {
        case 1: do {
            if (txt1 == "" || txt2 == "" || txt3 == "" || txt4 == "" || txt5 == ""){
                messageBox(message: "Please enter 5 things you can hear")
            }else {
                hear = [txt1, txt2, txt3, txt4, txt5]
                self.count = self.count + 1
                TitleLabel.text = "Four things you can see"
                TextBox5.alpha = 0
                reset()
            }
        }
        case 2: do {
            if (txt1 == "" || txt2 == "" || txt3 == "" || txt4 == ""){
                messageBox(message: "Please enter 4 things you can see")
            }else {
                see = [txt1, txt2, txt3, txt4]
                self.count = self.count + 1
                TitleLabel.text = "Three things you can Touch"
                TextBox4.alpha = 0
                reset()
            }
        }
        case 3: do {
            if (txt1 == "" || txt2 == "" || txt3 == ""){
                messageBox(message: "Please enter 3 things you can touch")
            }else {
                touch = [txt1, txt2, txt3]
                self.count = self.count + 1
                TitleLabel.text = "Two things you can Smell"
                TextBox3.alpha = 0
                reset()
            }
        }
        case 4: do {
            if (txt1 == "" || txt2 == ""){
                messageBox(message: "Please enter 2 things you can Smell")
            }else {
                smell = [txt1, txt2]
                self.count = self.count + 1
                TitleLabel.text = "One thing you can Taste"
                TextBox2.alpha = 0
                reset()
            }
        }
        case 5: do {
            if (txt1 == ""){
                messageBox(message: "Please enter 1 thing you can taste")
            }else {
               taste = txt1!
                let message = GroundViewModel.saveGroundVm(hear: hear, see: see, touch: touch, smell: smell, taste: taste)
                messageBox(message: message)
                self.count = self.count + 1
            }
        }
        default: do {}
        }
    }
    
    //Action Function - Resets grounding
    @IBAction func Reset(_ sender: UIBarButtonItem) {
        reset()
        count = 1
        TitleLabel.text = "Five things you can Hear"
        TextBox1.alpha = 1
        TextBox2.alpha = 1
        TextBox3.alpha = 1
        TextBox4.alpha = 1
        TextBox5.alpha = 1
    }
    
    //Action Function - Shows information about page
    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "This grounding technique uses the five different senses to allow you to become present in the moment. Do not think too hard just take a note of each observation as prompted", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - resets text boxes
    func reset(){
        TextBox1.placeholder = "1"
        TextBox1.text = ""
        TextBox2.placeholder = "2"
        TextBox2.text = ""
        TextBox3.placeholder = "3"
        TextBox3.text = ""
        TextBox4.placeholder = "4"
        TextBox4.text = ""
        TextBox5.placeholder = "5"
        TextBox5.text = ""
    }
    
    //Function - transistions to homepage
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

    //Function - message box creater
    func messageBox(message : String){
        let alert = UIAlertController(title: "Ground", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
        (action:UIAlertAction!)in
            if message.contains("Grounding entries saved"){
                self.transitionToHome()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleTextFieldLevel1(TextBox1)
        StyleSheet.styleTextFieldLevel1(TextBox2)
        StyleSheet.styleTextFieldLevel1(TextBox3)
        StyleSheet.styleTextFieldLevel1(TextBox4)
        StyleSheet.styleTextFieldLevel1(TextBox5)
        StyleSheet.styleFilledButtonLevel1(SaveButton)
        StyleSheet.styleLabelLevel1(TitleLabel)
        StyleSheet.styleBarButtonLevel1(ResetButton)
        StyleSheet.styleBarButtonLevel1(HomeButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleTextFieldLevel2(TextBox1)
        StyleSheet.styleTextFieldLevel2(TextBox2)
        StyleSheet.styleTextFieldLevel2(TextBox3)
        StyleSheet.styleTextFieldLevel2(TextBox4)
        StyleSheet.styleTextFieldLevel2(TextBox5)
        StyleSheet.styleFilledButtonLevel2(SaveButton)
        StyleSheet.styleLabelLevel2(TitleLabel)
        StyleSheet.styleBarButtonLevel2(ResetButton)
        StyleSheet.styleBarButtonLevel2(HomeButton)
        StyleSheet.styleBarButtonLevel2(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleTextFieldLevel3(TextBox1)
        StyleSheet.styleTextFieldLevel3(TextBox2)
        StyleSheet.styleTextFieldLevel3(TextBox3)
        StyleSheet.styleTextFieldLevel3(TextBox4)
        StyleSheet.styleTextFieldLevel3(TextBox5)
        StyleSheet.styleFilledButtonLevel3(SaveButton)
        StyleSheet.styleLabelLevel3(TitleLabel)
        StyleSheet.styleBarButtonLevel3(ResetButton)
        StyleSheet.styleBarButtonLevel3(HomeButton)
        StyleSheet.styleBarButtonLevel3(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleTextFieldExtra1(TextBox1)
        StyleSheet.styleTextFieldExtra1(TextBox2)
        StyleSheet.styleTextFieldExtra1(TextBox3)
        StyleSheet.styleTextFieldExtra1(TextBox4)
        StyleSheet.styleTextFieldExtra1(TextBox5)
        StyleSheet.styleFilledButtonExtra1(SaveButton)
        StyleSheet.styleLabelExtra1(TitleLabel)
        StyleSheet.styleBarButtonExtra1(ResetButton)
        StyleSheet.styleBarButtonExtra1(HomeButton)
        StyleSheet.styleBarButtonExtra1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleTextFieldExtra2(TextBox1)
        StyleSheet.styleTextFieldExtra2(TextBox2)
        StyleSheet.styleTextFieldExtra2(TextBox3)
        StyleSheet.styleTextFieldExtra2(TextBox4)
        StyleSheet.styleTextFieldExtra2(TextBox5)
        StyleSheet.styleFilledButtonExtra2(SaveButton)
        StyleSheet.styleLabelExtra2(TitleLabel)
        StyleSheet.styleBarButtonExtra2(ResetButton)
        StyleSheet.styleBarButtonExtra2(HomeButton)
        StyleSheet.styleBarButtonExtra2(InfoButton)
    }
}
