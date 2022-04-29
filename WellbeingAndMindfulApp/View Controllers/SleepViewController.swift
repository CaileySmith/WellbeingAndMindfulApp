//
//  SleepViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit

//ViewController Class - Sleep screen
class SleepViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Variables - outlets for view elements
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var sleepPicker: UIPickerView!
    @IBOutlet weak var wakeupLabel: UILabel!
    @IBOutlet weak var wakeupPicker: UIPickerView!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var qualityTextView: UITextField!
    @IBOutlet weak var qualityStepper: UIStepper!
    @IBOutlet weak var saveButton: UIButton!
    
    //Variables
    var colour = "green"
    var minutes = Array(0...59)
    var hours = Array(0...12)
    var ampm = ["am","pm"]
    
    //Function - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //styles elements
        setUpElements()
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
        //set up the pickers
        sleepPicker.delegate = self
        wakeupPicker.delegate = self
        sleepPicker.delegate?.pickerView?(sleepPicker, didSelectRow: 0, inComponent: 0)
        sleepPicker.delegate?.pickerView?(sleepPicker, didSelectRow: 0, inComponent: 1)
        sleepPicker.delegate?.pickerView?(sleepPicker, didSelectRow: 0, inComponent: 2)
        wakeupPicker.delegate?.pickerView?(wakeupPicker, didSelectRow: 0, inComponent: 0)
        wakeupPicker.delegate?.pickerView?(wakeupPicker, didSelectRow: 0, inComponent: 1)
        sleepPicker.delegate?.pickerView?(sleepPicker, didSelectRow: 0, inComponent: 2)
        //opens view model to create default
        let message = SleepViewModel.SleepLoadVM()
        print(message)
    }
    
    //Function - when the stepper changes it changes corresponding text
    @IBAction func qualityChange(_ sender: UIStepper) {
        qualityTextView.text = Int(sender.value).description
    }
    
    //Function - saving sleep
    @IBAction func savedPressed(_ sender: Any) {
        //gets selected
        let sleepHour = hours[sleepPicker.selectedRow(inComponent: 0)]
        let sleepMin = minutes[sleepPicker.selectedRow(inComponent: 1)]
        let sleepAmPm = ampm[sleepPicker.selectedRow(inComponent: 2)]
        let wakeHour = hours[wakeupPicker.selectedRow(inComponent: 0)]
        let wakeMin = minutes[wakeupPicker.selectedRow(inComponent: 1)]
        let wakeAmPm = ampm[wakeupPicker.selectedRow(inComponent: 2)]
        
        //validation
        var message = ""
        if (sleepAmPm == "am" && wakeAmPm == "am" && (sleepHour > wakeHour)){
            message = "Please enter appropiate times"
            messageBox(message: message)
        }else if (sleepAmPm == "pm" && wakeAmPm == "pm" && (sleepHour > wakeHour)){
            message = "Please enter appropiate times"
            messageBox(message: message)
        }else {
            //formatting times
            let sleepPercent = Float(sleepMin)/60
            let wakePercent = Float(wakeMin)/60
            let sleep = Float(sleepHour) + sleepPercent
            let wakeup = Float(wakeHour) + wakePercent
            
            //validating
            if (sleepAmPm == "am" && wakeAmPm == "am" && sleep == wakeup){
                message = "Please enter appropiate times"
                messageBox(message: message)
            }else if (sleepAmPm == "pm" && wakeAmPm == "pm" && sleep == wakeup){
                message = "Please enter appropiate times"
                messageBox(message: message)
            }else {
                //calculating time slept
                var sleeptime: Float
                if (sleepAmPm == "am" && wakeAmPm == "am"){
                    sleeptime = wakeup - sleep
                }else if (sleepAmPm == "pm" && wakeAmPm == "am"){
                    let x = sleep - wakeup
                    sleeptime = 12 - x
                }else if (sleepAmPm == "am" && wakeAmPm == "pm"){
                    let x = 12 - sleep
                    sleeptime = x + wakeup
                }else {
                    sleeptime = sleep - wakeup
                }
                //formatting
                let minsleep = sleeptime.truncatingRemainder(dividingBy: 1)
                let hoursleep = sleeptime - minsleep
                var h: Int = Int (round(hoursleep))
                var m: Int = Int (round(minsleep * 60))
                if h < 0 {
                    h = -h
                }
                if m < 0 {
                    m = -m
                }
                let length = "\(h) hours \(m) minutes"
                let quality = Int(qualityTextView.text!)
                //send length and quality to view model
                let response = SleepViewModel.SleepSaveVM(length: length, quality: quality!, hour: Int((round(hoursleep))), min: Int((round(minsleep * 60))))
                messageBox(message: response)
            }
        }
    }
    
    //Action Function - Shows user information about the page
    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "Select the time you went to sleep, along with the time you woke up. Rate the qualit of your sleep out of 10, then press save to log that sleep session.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Number of components for picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    //Function - Number of rows per component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hours.count
        }else if component == 1{
            return minutes.count
        }else {
            return ampm.count
        }
    }
    
    //Function - Filling rows for each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if component == 0 {
            return String(hours[row])
        }else if component == 1{
            return String(minutes[row])
        }else {
            return String(ampm[row])
        }
    }
    
    //Function - formatting message box
    func messageBox(message: String ){
        let alert = UIAlertController(title: "Sleep", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
        (action:UIAlertAction!)in
            if message.contains("Sleep for"){
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
    
    //Function - sets up the style of view elements
    func setUpElements(){
        qualityTextView.allowsEditingTextAttributes = false
        qualityStepper.wraps = true
        qualityStepper.autorepeat = true
        qualityStepper.maximumValue = 10
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleFilledButtonLevel1(saveButton)
        StyleSheet.styleLabelLevel1(sleepLabel)
        StyleSheet.styleLabelLevel1(wakeupLabel)
        StyleSheet.styleLabelLevel1(qualityLabel)
        StyleSheet.styleTextFieldLevel1(qualityTextView)
        StyleSheet.styleBarButtonLevel1(HomeButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleFilledButtonLevel2(saveButton)
        StyleSheet.styleLabelLevel2(sleepLabel)
        StyleSheet.styleLabelLevel2(wakeupLabel)
        StyleSheet.styleLabelLevel2(qualityLabel)
        StyleSheet.styleTextFieldLevel2(qualityTextView)
        StyleSheet.styleBarButtonLevel2(HomeButton)
        StyleSheet.styleBarButtonLevel2(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleFilledButtonLevel3(saveButton)
        StyleSheet.styleLabelLevel3(sleepLabel)
        StyleSheet.styleLabelLevel3(wakeupLabel)
        StyleSheet.styleLabelLevel3(qualityLabel)
        StyleSheet.styleTextFieldLevel3(qualityTextView)
        StyleSheet.styleBarButtonLevel3(HomeButton)
        StyleSheet.styleBarButtonLevel3(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleFilledButtonExtra1(saveButton)
        StyleSheet.styleLabelExtra1(sleepLabel)
        StyleSheet.styleLabelExtra1(wakeupLabel)
        StyleSheet.styleLabelExtra1(qualityLabel)
        StyleSheet.styleTextFieldExtra1(qualityTextView)
        StyleSheet.styleBarButtonExtra1(HomeButton)
        StyleSheet.styleBarButtonExtra1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleFilledButtonExtra2(saveButton)
        StyleSheet.styleLabelExtra2(sleepLabel)
        StyleSheet.styleLabelExtra2(wakeupLabel)
        StyleSheet.styleLabelExtra2(qualityLabel)
        StyleSheet.styleTextFieldExtra2(qualityTextView)
        StyleSheet.styleBarButtonExtra2(HomeButton)
        StyleSheet.styleBarButtonExtra2(InfoButton)
    }
}
