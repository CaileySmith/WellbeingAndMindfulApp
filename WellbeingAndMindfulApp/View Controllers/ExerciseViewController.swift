//
//  ExerciseViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit
import Firebase

//ViewController Class - Exercise screen
class ExerciseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    //Variables - outlets for view elements
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var exercisePicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    
    //Variables
    var colour = "green"
    var minutes = Array(0...59)
    var hours = Array(0...24)
    var exercise = ["Walk", "Run", "Cardio", "Yoga", "Dance", "Cycling", "Swim", "Pilates", "Strength training" ,"HIIT", "Tennis", "Badmington", "Squash", "Football", "Rugby", "Basketball" , "Netball", "Boxing", "Martial Arts", "Elliptical", "Rowing", "Stairs", "Gymnastics", "Other" ]
   
    //Function- view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //styles the views
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
        //sets up the pickers
        exercisePicker.delegate = self
        timePicker.delegate = self
        timePicker.delegate?.pickerView?(timePicker, didSelectRow: 0, inComponent: 0)
        timePicker.delegate?.pickerView?(timePicker, didSelectRow: 0, inComponent: 1)
        exercisePicker.delegate?.pickerView?(exercisePicker, didSelectRow: 0, inComponent: 0)
        //loads default
        let message = ExerciseViewModel.ExerciseLoadVM()
        print(message)
    }
    
    //Action Function - saved pressed, saves exercise data
    @IBAction func savedPressed(_ sender: UIButton) {
        //sets selected picker components
        let execisePicked = exercise[exercisePicker.selectedRow(inComponent: 0)]
        let hourPicked = hours[timePicker.selectedRow(inComponent: 0)]
        let minPicked = minutes[timePicker.selectedRow(inComponent: 1)]
        //validation
        if ((hourPicked == 0) && (minPicked == 0)){
            messageBox(message: "Please enter exercise time")
        }else {
            //sends exercise and time to view model
            let timedone: String = String(hourPicked) + " hours, " + String(minPicked) + " minutes"
            let message = ExerciseViewModel.ExerciseSaveVM(type: execisePicked, hour: hourPicked, min: minPicked, time: timedone)
            messageBox(message: message)
        }
    }

    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "Choose from the different exercise which you have done, choose the length of time it was completed, then press save to keep a log of that exercise.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Home(_ sender: Any) {
        transitionToHome()
    }
    
    //Function - Number of components in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1{
            return 1
        } else {
            return 2
        }
    }
        
    //Function - Number of rows per component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return exercise.count
        }else {
            if component == 0{
                return hours.count
            }else{
                return minutes.count
            }
        }
    }
    
    //Function - Filling rows for each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if pickerView.tag == 1 {
            return String(exercise[row])
        }else {
            if component == 0 {
                return String(hours[row])
            }else{
                return String(minutes[row])
            }
        }
    }
    
    //Function - transistions to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //Function - formats a message box
    func messageBox(message: String ){
        let alert = UIAlertController(title: "Exercise", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
        (action:UIAlertAction!)in
            if message.contains("exercise saved for"){
                self.transitionToHome()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleFilledButtonLevel1(saveButton)
        StyleSheet.styleBarButtonLevel1(homeButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
        StyleSheet.styleLabelLevel1(typeLabel)
        StyleSheet.styleLabelLevel1(hourLabel)
        StyleSheet.styleLabelLevel1(minuteLabel)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleFilledButtonLevel2(saveButton)
        StyleSheet.styleBarButtonLevel2(homeButton)
        StyleSheet.styleBarButtonLevel2(InfoButton)
        StyleSheet.styleLabelLevel2(typeLabel)
        StyleSheet.styleLabelLevel2(hourLabel)
        StyleSheet.styleLabelLevel2(minuteLabel)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleFilledButtonLevel3(saveButton)
        StyleSheet.styleBarButtonLevel3(homeButton)
        StyleSheet.styleBarButtonLevel3(InfoButton)
        StyleSheet.styleLabelLevel3(typeLabel)
        StyleSheet.styleLabelLevel3(hourLabel)
        StyleSheet.styleLabelLevel3(minuteLabel)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleFilledButtonExtra1(saveButton)
        StyleSheet.styleBarButtonExtra1(homeButton)
        StyleSheet.styleBarButtonExtra1(InfoButton)
        StyleSheet.styleLabelExtra1(typeLabel)
        StyleSheet.styleLabelExtra1(hourLabel)
        StyleSheet.styleLabelExtra1(minuteLabel)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleFilledButtonExtra2(saveButton)
        StyleSheet.styleBarButtonExtra2(homeButton)
        StyleSheet.styleBarButtonExtra2(InfoButton)
        StyleSheet.styleLabelExtra2(typeLabel)
        StyleSheet.styleLabelExtra2(hourLabel)
        StyleSheet.styleLabelExtra2(minuteLabel)
    }
}

