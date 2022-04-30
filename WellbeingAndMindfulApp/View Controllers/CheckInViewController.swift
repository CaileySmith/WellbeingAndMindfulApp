//
//  CheckInViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit
import Firebase

//ViewController Class - Check in screen
class CheckInViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    //Variables - outlets for view
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var MoodLabel: UILabel!
    @IBOutlet weak var MoodPicker: UIPickerView!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var RatingStepper: UIStepper!
    @IBOutlet weak var RatingTextField: UITextField!
    @IBOutlet weak var RatingLabel: UILabel!
    @IBOutlet weak var InputTextView: UITextView!
    @IBOutlet weak var InputLabel: UILabel!
    @IBOutlet weak var TimeOfDayLabel: UILabel!
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    
    //Variables
    var colour = "green"
    let moods = ["Happy", "Okay" ,"Calm", "Suprised", "Excited", "Scared", "Angry", "Sad", "Unhappy", "Anxious"]
    var tod = 0
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        //loads database
        let message = CheckInViewModel.CheckInLoadVM()
        print(message)
        
        //style based on time of day
        let today = Date()
        let hours   = (Calendar.current.component(.hour, from: today))
        switch hours {
        case 1...12: do{
            TimeOfDayLabel.text = "Good Morning!"
            InputLabel.text = "What is todays plan?"
            tod = 1
        }
        case 13...17: do{
            TimeOfDayLabel.text = "Good Afternoon!"
            InputLabel.text = "How is today going?"
            tod = 2
        }
        case 18...21: do{
            TimeOfDayLabel.text = "Good Evening!"
            InputLabel.text = "What are you grateful for today?"
            tod = 3
        }
        case 21...24: do{
            TimeOfDayLabel.text = "Good Night!"
            InputLabel.text = "What is today's highlight?"
            tod = 4
        }
        default: do{
            TimeOfDayLabel.text = "Good Night!"
            InputLabel.text = "What is today's highlight?"
            tod = 4
        }
        }
        setUpElements()
        //style based on colour
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
        //reads in any saved data
        readData()
    }
  
    //Action Function - Save button
    @IBAction func SaveButtonPressed(_ sender: UIButton) {
        let mood = moods[MoodPicker.selectedRow(inComponent: 0)]
        let input = InputTextView.text
        let rating = Int(RatingTextField.text!)
        if input == "" {
            messageBox(message: "Please enter answers")
        }else{
            let message = CheckInViewModel.CheckSave(tod: tod, mood: mood, input: input, rating: rating)
            messageBox(message: message)
        }
 
    }
    
    //Action Function - rating change
    @IBAction func RatingChange(_ sender: UIStepper) {
        RatingTextField.text = Int(sender.value).description
    }
    
    //Action Function - Shows the user information about the screen
    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "Select the mood which closest describes how you feel in the present moment. Answer the prompted question. Choose how you are feeling on a scale of zero to 10.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Number of components in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    //Function - Number of rows per component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moods.count
    }
    
    //Function - Filling rows for each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return String(moods[row])
    }
    
    //Function - formatting message box
    func messageBox(message: String ){
        let alert = UIAlertController(title: "Check-In", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay", style: .default){
        (action:UIAlertAction!)in
            if message.contains("Check-In Saved"){
                self.transitionToHome()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - transistion to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //Function - allows the user to hide the keyboard
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //Function - reads in previously saved data
    func readData(){
        let db = Firestore.firestore()
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let d = formatter.string(from: date)
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
        let dateRef = db.collection("users").document(userid).collection("daily").document(d).collection("checkin").document(String(tod))
            dateRef.getDocument { (document, error) in
                if let document = document , document.exists{
                    let input = document.get("input") as? String
                    self.InputTextView.text = input
                    let rating = document.get("rating") as? Int ?? 0
                    self.RatingTextField.text = String(rating)
                    let mood = document.get("mood") as? String
                    self.MoodPicker.selectRow(self.moods.firstIndex(of: mood!)!, inComponent: 0, animated: true)
                }else {
                    self.InputTextView.text = "..."
                    self.RatingTextField.text = "0"
                    self.MoodPicker.selectRow(0, inComponent: 0, animated: false)
                }
            }
        }
    }
    
    //Function - set up view elements
    func setUpElements(){
        RatingTextField.allowsEditingTextAttributes = false
        RatingStepper.wraps = true
        RatingStepper.autorepeat = true
        RatingStepper.maximumValue = 10
        MoodPicker.delegate = self
        MoodPicker.delegate?.pickerView?(MoodPicker, didSelectRow: 0, inComponent: 0)
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleLabelLevel1(MoodLabel)
        StyleSheet.styleFilledButtonLevel1(SaveButton)
        StyleSheet.styleTextFieldLevel1(RatingTextField)
        StyleSheet.styleLabelLevel1(RatingLabel)
        StyleSheet.styleLabelLevel1(InputLabel)
        StyleSheet.styleLabelLevel1(TimeOfDayLabel)
        StyleSheet.styleBarButtonLevel1(HomeButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleLabelLevel2(MoodLabel)
        StyleSheet.styleFilledButtonLevel2(SaveButton)
        StyleSheet.styleTextFieldLevel2(RatingTextField)
        StyleSheet.styleLabelLevel2(RatingLabel)
        StyleSheet.styleLabelLevel2(InputLabel)
        StyleSheet.styleLabelLevel2(TimeOfDayLabel)
        StyleSheet.styleBarButtonLevel2(HomeButton)
        StyleSheet.styleBarButtonLevel2(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleLabelLevel3(MoodLabel)
        StyleSheet.styleFilledButtonLevel3(SaveButton)
        StyleSheet.styleTextFieldLevel3(RatingTextField)
        StyleSheet.styleLabelLevel3(RatingLabel)
        StyleSheet.styleLabelLevel3(InputLabel)
        StyleSheet.styleLabelLevel3(TimeOfDayLabel)
        StyleSheet.styleBarButtonLevel3(HomeButton)
        StyleSheet.styleBarButtonLevel3(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleLabelExtra1(MoodLabel)
        StyleSheet.styleFilledButtonExtra1(SaveButton)
        StyleSheet.styleTextFieldExtra1(RatingTextField)
        StyleSheet.styleLabelExtra1(RatingLabel)
        StyleSheet.styleLabelExtra1(InputLabel)
        StyleSheet.styleLabelExtra1(TimeOfDayLabel)
        StyleSheet.styleBarButtonExtra1(HomeButton)
        StyleSheet.styleBarButtonExtra1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleLabelExtra2(MoodLabel)
        StyleSheet.styleFilledButtonExtra2(SaveButton)
        StyleSheet.styleTextFieldExtra2(RatingTextField)
        StyleSheet.styleLabelExtra2(RatingLabel)
        StyleSheet.styleLabelExtra2(InputLabel)
        StyleSheet.styleLabelExtra2(TimeOfDayLabel)
        StyleSheet.styleBarButtonExtra2(HomeButton)
        StyleSheet.styleBarButtonExtra2(HomeButton)
    }
}
