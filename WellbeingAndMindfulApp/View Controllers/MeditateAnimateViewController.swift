//
//  MeditateAnimateViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 25/02/2022.
//

import UIKit
import SwiftUI
import AVFoundation

//ViewController Class - Meditate animation screen
class MeditateAnimateViewController: UIViewController {

    //Variables - outlets for view
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var theContainer: UIView!
    //Variables
    var colour = "green"
    var level = 1
    var length = 0.0
    var repeatcount = 0
    var track = 0
    var music = false
    var audioPlayer: AVAudioPlayer!
    
    //Function - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        music = false
        //plays song based upon which was chosen
        if length == 0.0 {
            switch track {
            case 1: do{
                let pathToSound = Bundle.main.path(forResource: "Komiku_-_08_-_Dreaming_of_you", ofType: "mp3")!
                let url = URL(fileURLWithPath: pathToSound)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                    length = 171
                    music = true
                }catch{
                    print("SOUND ERROR!!!!!!!!!!!!")
                }
            }
            case 2: do{
                let pathToSound = Bundle.main.path(forResource: "Komiku_-_11_-_Friends_2068", ofType: "mp3")!
                let url = URL(fileURLWithPath: pathToSound)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                    length = 75
                    music = true
                }catch{
                    print("SOUND ERROR!!!!!!!!!!!!")
                }
            }
            case 3: do{
                let pathToSound = Bundle.main.path(forResource: "Komiku_-_55_-_Sunset_on_the_beach", ofType: "mp3")!
                let url = URL(fileURLWithPath: pathToSound)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                    length = 80
                    music = true
                }catch{
                    print("SOUND ERROR!!!!!!!!!!!!")
                }
            }
            case 4: do{
                let pathToSound = Bundle.main.path(forResource: "Komiku_-_69_-_Resolution", ofType: "mp3")!
                let url = URL(fileURLWithPath: pathToSound)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                    length = 139
                    music = true
                }catch{
                    print("SOUND ERROR!!!!!!!!!!!!")
                }
            }default: do{}
            }
        }
        
        //Style elements
        var light = Color.white
        var dark = Color.white
        switch colour {
        case "green": do {
            light = Color.init(red: 216/255, green: 238/255, blue: 227/255)
            dark = Color.init(red: 109/255, green: 157/255, blue: 135/255)
            StyleSheet.styleBarButtonLevel1(HomeButton)
        }
        case "purple": do {
            light = Color.init(red: 240/255, green: 217/255, blue: 255/255)
            dark = Color.init(red: 157/255, green: 126/255, blue: 187/255)
            StyleSheet.styleBarButtonLevel2(HomeButton)
        }
        case "blue": do {
            light = Color.init(red: 162/255, green: 219/255, blue: 250/255)
            dark = Color.init(red: 57/255, green: 162/255, blue: 219/255)
            StyleSheet.styleBarButtonLevel3(HomeButton)
        }
        case "orange": do {
            light = Color.init(red: 255/255, green: 224/255, blue: 195/255)
            dark = Color.init(red: 233/255, green: 133/255, blue: 128/255)
            StyleSheet.styleBarButtonExtra1(HomeButton)
        }
        case "pink" : do {
            light = Color.init(red: 253/255, green: 207/255, blue: 232/255)
            dark = Color.init(red: 194/255, green: 93/255, blue: 149/255)
            StyleSheet.styleBarButtonExtra2(HomeButton)
        }
        default: do {}
        }
        //Show animation
        let childView = UIHostingController(rootView: MeditateUIView(length: length, track: track, dark: dark, light: light))
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
        doneMsg()
    }
    
    //Action Function - back to meditate screen
    @IBAction func BackPressed(_ sender: UIBarButtonItem) {
        audioPlayer?.stop()
        audioPlayer?.pause()
        audioPlayer = nil
        let MeditateViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.MeditateViewController) as? MeditateViewController
        MeditateViewController?.colour = colour
        MeditateViewController?.level = level
         view.window?.rootViewController = MeditateViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function - Shows when exercise is done
    func doneMsg(){
        if music == false {
            DispatchQueue.main.asyncAfter(deadline: .now()+Double(length*60)){
                      // BreatheViewModel.saveBreathe(time: self.time, technique: self.technique)
                _ = MeditateViewModel.saveMeditateSilent(type: "Silent", time: Int(self.length))
                self.messageBox(msg: "Silent Mediation for \(self.length) minutes saved")
            }
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now()+(length)){
                      // BreatheViewModel.saveBreathe(time: self.time, technique: self.technique)
                _ = MeditateViewModel.saveMeditateMusic(type: "Music", track: (self.track))
                self.messageBox(msg: "Music meditation for track \(self.track) saved")
            }
        }
    }
    
    //Function - alert box for meditate
    func messageBox(msg: String){
        let alert = UIAlertController(title: "Meditate", message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay", style: .default){
        (action:UIAlertAction!)in
            self.transitionToHome()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - transistions to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
