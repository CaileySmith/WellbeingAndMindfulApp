//
//  MeditateViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit

//ViewController Class - Meditate screen
class MeditateViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    //Variables - Outlets for view
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var PickerView: UIPickerView!
    @IBOutlet weak var SilentButton: UIButton!
    @IBOutlet weak var MusicButton: UIButton!
    @IBOutlet weak var PickLabel: UILabel!
    @IBOutlet weak var AboutButton: UIButton!
    
    //Variables
    var colour = "green"
    var level = 1
    var music = false
    var message = ""
    var silent = 0
    let times: Array<Int> = [1,2,3,4,5]
    var tracks: Array<Int> = []
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up
        PickerView.alpha = 0
        StartButton.alpha = 0
        PickLabel.alpha = 0
        AboutButton.alpha = 0
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
        music = false
        //restrictions based on levels
        switch level {
        case 1: do {
            tracks = [1,2]
            message = "Track 1: 2 minutes 51 seconds long \nTrack 2: 1 minutes 15 seconds long"
        }
        case 2, 3: do {
            tracks = [1,2,3,4]
            message = "Track 1: 2 minutes 51 seconds long \nTrack 2: 1 minutes 15 seconds long \nTrack 3: 1 minutes 20 seconds long \nTrack 4: 2 minutes 19 seconds long"
        }
        default: do {}
        }
    }
    
    //Action Function - Silent meditation chosen
    @IBAction func SilentPressed(_ sender: UIButton) {
        PickerView.alpha = 1
        StartButton.alpha = 1
        PickLabel.alpha = 1
        AboutButton.alpha = 0
        PickLabel.text = "How many minutes?"
        silent = 1
        PickerView.delegate = self
        PickerView.delegate?.pickerView?(PickerView, didSelectRow: 0, inComponent: 0)
        music = false
    }
    
    //Action Function - Music meditation chosen
    @IBAction func MusicPressed(_ sender: UIButton) {
        PickerView.alpha = 1
        StartButton.alpha = 1
        PickLabel.alpha = 1
        AboutButton.alpha = 1
        PickLabel.text = "Which track to listen to?"
        silent = 2
        PickerView.delegate = self
        PickerView.delegate?.pickerView?(PickerView, didSelectRow: 0, inComponent: 0)
        music = true
    }
    
    //Action Function - message box about the different tracks
    @IBAction func AboutPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Meditate", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
        (action:UIAlertAction!)in}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Action Function - infomation to user about the page
    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "Choose from either silent or music meditation. With silent choose up to five minutes, with music choose which track. To see the lengths of the tracks press the about tracks button. Select begin to start.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Action Function - back to home
    @IBAction func HomePressed(_ sender: UIBarButtonItem) {
        transitionToHome()
    }
    
    //Function - segue for meditation animation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: MeditateAnimateViewController = segue.destination as! MeditateAnimateViewController
        if music == true {
            secondVC.track = tracks[PickerView.selectedRow(inComponent: 0)]
        }else {
            secondVC.length = Double(times[PickerView.selectedRow(inComponent: 0)])
        }
        secondVC.music = music
        secondVC.colour = colour
        secondVC.level = level
    }

    //Function - transistions to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //Function - Number of components in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
        
    }
        
    //Function - Number of rows per component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if silent == 1{
            return times.count
        }else {
            return tracks.count
        }
    }
    
    //Function - Filling rows for each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if silent == 1 {
            return String(times[row])
        }else {
            return String(tracks[row])
        }
    }
    
    //Function - Sets up style for view elements
    func levelOneSetUp(){
        StyleSheet.styleFilledButtonLevel1(SilentButton)
        StyleSheet.styleFilledButtonLevel1(MusicButton)
        StyleSheet.styleFilledButtonLevel1(StartButton)
        StyleSheet.styleLabelLevel1(PickLabel)
        StyleSheet.styleInvertFilledButtonLevel1(AboutButton)
        StyleSheet.styleBarButtonLevel1(HomeButton)
        StyleSheet.styleBarButtonLevel1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelTwoSetUp(){
        StyleSheet.styleFilledButtonLevel2(SilentButton)
        StyleSheet.styleFilledButtonLevel2(MusicButton)
        StyleSheet.styleFilledButtonLevel2(StartButton)
        StyleSheet.styleLabelLevel2(PickLabel)
        StyleSheet.styleInvertFilledButtonLevel2(AboutButton)
        StyleSheet.styleBarButtonLevel2(HomeButton)
        StyleSheet.styleBarButtonLevel2(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func levelThreeSetUp(){
        StyleSheet.styleFilledButtonLevel3(SilentButton)
        StyleSheet.styleFilledButtonLevel3(MusicButton)
        StyleSheet.styleFilledButtonLevel3(StartButton)
        StyleSheet.styleLabelLevel3(PickLabel)
        StyleSheet.styleInvertFilledButtonLevel3(AboutButton)
        StyleSheet.styleBarButtonLevel3(HomeButton)
        StyleSheet.styleBarButtonLevel3(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraOneSetUp(){
        StyleSheet.styleFilledButtonExtra1(SilentButton)
        StyleSheet.styleFilledButtonExtra1(MusicButton)
        StyleSheet.styleFilledButtonExtra1(StartButton)
        StyleSheet.styleLabelExtra1(PickLabel)
        StyleSheet.styleInvertFilledButtonExtra1(AboutButton)
        StyleSheet.styleBarButtonExtra1(HomeButton)
        StyleSheet.styleBarButtonExtra1(InfoButton)
    }
    
    //Function - Sets up style for view elements
    func extraTwoSetUp(){
        StyleSheet.styleFilledButtonExtra2(SilentButton)
        StyleSheet.styleFilledButtonExtra2(MusicButton)
        StyleSheet.styleFilledButtonExtra2(StartButton)
        StyleSheet.styleLabelExtra2(PickLabel)
        StyleSheet.styleInvertFilledButtonExtra2(AboutButton)
        StyleSheet.styleBarButtonExtra2(HomeButton)
        StyleSheet.styleBarButtonExtra2(InfoButton)
    }
}
