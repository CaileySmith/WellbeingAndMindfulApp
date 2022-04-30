//
//  BreatheViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit

//ViewController Class - Breathe screen
class BreatheViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    //Variables - outlets
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    @IBOutlet weak var BeginButton: UIButton!
    @IBOutlet weak var TimePicker: UIPickerView!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TechniquePicker: UIPickerView!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var AboutButton: UIButton!
    @IBOutlet weak var TechniqueLabel: UILabel!
    
    //Variables
    var colour = "green"
    var level = 1
    var techniques : Array<String> = []
    var times = [1,2,3,4,5]
    var message = ""
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up style for elements
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
        //set up restrictions based on level
        switch level {
        case 1: do {
            techniques = ["4-7-8", "Diaphragmatic"]
        }
        case 2: do {
            techniques = ["4-7-8", "Diaphragmatic", "Box Breath", "Resonant /Coherent"]
        }
        case 3: do {
            techniques = ["4-7-8", "Diaphragmatic", "Box Breath", "Alternative Nostril", "Resonant /Coherent"]
        }
        default: do {}
        }
        //set up picker views
        TechniquePicker.delegate = self
        TimePicker.delegate = self
        TimePicker.delegate?.pickerView?(TimePicker, didSelectRow: 0, inComponent: 0)
        TechniquePicker.delegate?.pickerView?(TechniquePicker, didSelectRow: 0, inComponent: 0)
    }
    
    //Action Function - how to do the techniques
    @IBAction func AboutPressed(_ sender: UIButton) {
        let technique = techniques[TechniquePicker.selectedRow(inComponent: 0)]
        //message for each technique
        switch technique {
        case "4-7-8": do {
            self.message = "Breathe through you nose.\nIn for 4 seconds\nHold for 7 seconds\nOut for 8 seconds.\nThen repeat"
        }
        case "Box Breath": do {
            self.message = "Breathe through your nose.\nIn for 4 seconds\nHold for 4 seconds\nOut for 4 seconds\nHold for 4 seconds.\nThen repeat"
        }
        case "Alternative Nostril": do {
            self.message = "Using your index finger cover your left nostril.\nBreathe in through your right nostril for 6 seconds.\nCover your right nostril with your thumb and uncover your left nostril.\n Breathe out through your left nostril for 6 seconds.\n Breathe in through your left nostril for 6 seconds.\nCover your left nostril with your index finger and uncover your right nostril.\nBreathe out of your right nostril for 6 seconds.\nThen repeat"
        }
        case "Diaphragmatic": do {
            self.message = "Breathe through your nose.\nBreathe in deeply focusing on filling your stomach with air for 8 seconds.\nBreathe out completely for 8 seconds.\nThen repeat"
        }
        case "Resonant /Coherent": do {
            self.message = "Breathe through your nose.\nBreathe in for 5 seconds.\n Then breathe out for 5 seconds.\nThen repeat"
        }
        default:
            self.message = ""
            
        }
        messageBox()
    }
    
    //Action Function - home screen loads
    @IBAction func homePressed(_ sender: UIBarButtonItem) {
        transitionToHome()
    }
    
    //Action Function - Information on what to do shows
    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "Select which breathing exercise you wish to follow. For more information on how to do the technique press that button. Select how many minutes you wish to do the exercise, then press begin", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - breathe message box
    func messageBox(){
        let alert = UIAlertController(title: "Breathe", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay", style: .default){
        (action:UIAlertAction!)in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - Number of components in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
        
    }
        
    //Function - Number of rows per component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return techniques.count
        }else {
            return times.count
        }
    }
    
    //Function - Filling rows for each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if pickerView.tag == 1 {
            return String(techniques[row])
        }else {
            return String(times[row])
        }
    }
    
    //Function - segue for breathe animation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: BreatheAnimationViewController = segue.destination as! BreatheAnimationViewController
        secondVC.technique = techniques[TechniquePicker.selectedRow(inComponent: 0)]
        secondVC.time = times[TimePicker.selectedRow(inComponent: 0)]
        secondVC.colour = colour
        secondVC.level = level
    }
    
    //Function - transistions to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleFilledButtonLevel1(BeginButton)
        StyleSheet.styleLabelLevel1(TimeLabel)
        StyleSheet.styleLabelLevel1(TechniqueLabel)
        StyleSheet.styleBarButtonLevel1(HomeButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
        StyleSheet.styleInvertFilledButtonLevel1(AboutButton)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleFilledButtonLevel2(BeginButton)
        StyleSheet.styleLabelLevel2(TimeLabel)
        StyleSheet.styleLabelLevel2(TechniqueLabel)
        StyleSheet.styleBarButtonLevel2(HomeButton)
        StyleSheet.styleBarButtonLevel2(InfoButton)
        StyleSheet.styleInvertFilledButtonLevel2(AboutButton)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleFilledButtonLevel3(BeginButton)
        StyleSheet.styleLabelLevel3(TimeLabel)
        StyleSheet.styleLabelLevel3(TechniqueLabel)
        StyleSheet.styleBarButtonLevel3(HomeButton)
        StyleSheet.styleBarButtonLevel3(InfoButton)
        StyleSheet.styleInvertFilledButtonLevel3(AboutButton)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleFilledButtonExtra1(BeginButton)
        StyleSheet.styleLabelExtra1(TimeLabel)
        StyleSheet.styleLabelExtra1(TechniqueLabel)
        StyleSheet.styleBarButtonExtra1(HomeButton)
        StyleSheet.styleBarButtonExtra1(InfoButton)
        StyleSheet.styleInvertFilledButtonExtra1(AboutButton)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleFilledButtonExtra2(BeginButton)
        StyleSheet.styleLabelExtra2(TimeLabel)
        StyleSheet.styleLabelExtra2(TechniqueLabel)
        StyleSheet.styleBarButtonExtra2(HomeButton)
        StyleSheet.styleBarButtonExtra2(InfoButton)
        StyleSheet.styleInvertFilledButtonExtra2(AboutButton)
    }
}
