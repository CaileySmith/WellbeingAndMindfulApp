//
//  BreatheAnimationViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 15/02/2022.
//

import UIKit
import SwiftUI

//ViewController Class - Breathe animation screen
class BreatheAnimationViewController: UIViewController {
    
    //Variables - outlets for view
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var theContainer : UIView!
    
    //Variables
    var colour = "green"
    var level = 1
    var technique = ""
    var time = 0
    var count = 0
    var done = 0
    let four78 = 19
    let bbD = 16
    let an = 24
    let res = 10

    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //load document
        BreatheViewModel.loadBreathe()
        //calculate time for each technique
        switch time {
        case 1: do{
            switch technique{
            case "4-7-8": do{
                count = 3
                done = (count * four78) - count
            }case "Box Breath", "Diaphragmatic": do{
                count = 4
                done = (count * bbD) - count
            }case "Alternative Nostril": do {
                count = 3
                done = (count * an) - count
            }case "Resonant /Coherent": do {
                count = 6
                done = (count * res) - count
            }default :do  {
               count = 1
            }
            }
        }case 2: do {
            switch technique{
            case "4-7-8": do{
                count = 6
                done = (count * four78) - count
            }case "Box Breath", "Diaphragmatic": do{
                count = 8
                done = (count * bbD) - count
            }case "Alternative Nostril": do {
                count = 5
                done = (count * an) - count
            }case "Resonant /Coherent": do {
                count = 12
                done = (count * res) - count
            }default :do  {
               count = 1
            }
            }
        }case 3: do {
            switch technique{
            case "4-7-8": do{
                count = 9
                done = (count * four78) - count
            }case "Box Breath", "Diaphragmatic": do{
                count = 11
                done = (count * bbD) - count
            }case "Alternative Nostril": do {
                count = 8
                done = (count * an) - count
            }case "Resonant /Coherent": do {
                count = 18
                done = (count * res) - count
            }default :do  {
               count = 1
            }
            }
        }case 4: do {
            switch technique{
            case "4-7-8": do{
                count = 12
                done = (count * four78) - count
            }case "Box Breath", "Diaphragmatic": do{
                count = 15
                done = (count * bbD) - count
            }case "Alternative Nostril": do {
                count = 10
                done = (count * an) - count
            }case "Resonant /Coherent": do {
                count = 24
                done = (count * res) - count
            }default :do  {
               count = 1
            }
            }
        }case 5: do {
            switch technique{
            case "4-7-8": do{
                count = 15
                done = (count * four78) - count
            }case "Box Breath", "Diaphragmatic": do{
                count = 19
                done = (count * bbD) - count
            }case "Alternative Nostril": do {
                count = 13
                done = (count * an) - count
            }case "Resonant /Coherent": do {
                count = 30
                done = (count * res) - count
            }default :do  {
               count = 1
            }
            }
        }
        default: do {
            count = 1
        }
        }
        //do the styling for each
        var light = Color.white
        var dark = Color.white
        switch colour {
        case "green": do {
            light = Color.init(red: 216/255, green: 238/255, blue: 227/255)
            dark = Color.init(red: 109/255, green: 157/255, blue: 135/255)
            StyleSheet.styleBarButtonLevel1(backButton)
        }
        case "purple": do {
            light = Color.init(red: 240/255, green: 217/255, blue: 255/255)
            dark = Color.init(red: 157/255, green: 126/255, blue: 187/255)
            StyleSheet.styleBarButtonLevel2(backButton)
        }
        case "blue": do {
            light = Color.init(red: 162/255, green: 219/255, blue: 250/255)
            dark = Color.init(red: 57/255, green: 162/255, blue: 219/255)
            StyleSheet.styleBarButtonLevel3(backButton)
        }
        case "orange": do {
            light = Color.init(red: 255/255, green: 224/255, blue: 195/255)
            dark = Color.init(red: 233/255, green: 133/255, blue: 128/255)
            StyleSheet.styleBarButtonExtra1(backButton)
        }
        case "pink" : do {
            light = Color.init(red: 253/255, green: 207/255, blue: 232/255)
            dark = Color.init(red: 194/255, green: 93/255, blue: 149/255)
            StyleSheet.styleBarButtonExtra2(backButton)
        }
        default: do {}
        }
        //shows ui view depneding on the technique
        switch technique{
        case "4-7-8": do{
            let childView = UIHostingController(rootView: Breath478SwiftUIView(colour: colour, light: light, dark: dark, repeatcount: count))
            addChild(childView)
            childView.view.frame = theContainer.bounds
            theContainer.addSubview(childView.view)
            doneMsg()
        }case "Box Breath": do{
            let childView = UIHostingController(rootView: BoxBreathSwiftUIView(colour: colour, repeatcount: count, light: light, dark: dark))
            addChild(childView)
            childView.view.frame = theContainer.bounds
            theContainer.addSubview(childView.view)
            doneMsg()
        }case "Alternative Nostril": do {
            let childView = UIHostingController(rootView: AlternateNostrilBreathSwiftUIView(colour: colour, dark: dark, light: light, repeatcount: count))
            addChild(childView)
            childView.view.frame = theContainer.bounds
            theContainer.addSubview(childView.view)
            doneMsg()
        }case "Diaphragmatic" : do {
            let childView = UIHostingController(rootView: DiaphragmaticBreathSwiftUIView(colour: colour, dark: dark, light: light, repeatcount: count))
            addChild(childView)
            childView.view.frame = theContainer.bounds
            theContainer.addSubview(childView.view)
            doneMsg()
        }case "Resonant /Coherent": do {
            let childView = UIHostingController(rootView: ResonantBreathSwiftUIView(dark: dark, light: light, repeatcount: count, colour: colour))
            addChild(childView)
            childView.view.frame = theContainer.bounds
            theContainer.addSubview(childView.view)
            doneMsg()
        }default :do  {}
        }
    }
    
    //Action Function - back to breathe screen
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        let BreatheViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.BreatheViewController) as? BreatheViewController
        BreatheViewController?.colour = colour
        BreatheViewController?.level = level
         view.window?.rootViewController = BreatheViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function - Show when done
    func doneMsg(){
        DispatchQueue.main.asyncAfter(deadline: .now()+Double(done)){
            _ = BreatheViewModel.saveBreathe(time: self.time, technique: self.technique)
            let alert = UIAlertController(title: "breathe", message: "" + self.technique + " for " + String(self.time) + " minutes has been saved", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default){
            (action:UIAlertAction!)in
                self.transitionToHome()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Function - transistions to homepage
    func transitionToHome(){
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
