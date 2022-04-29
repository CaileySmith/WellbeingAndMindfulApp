//
//  Track.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 11/03/2022.
//

import Foundation

//Struct - Track
struct Track{
    
    //Variables
    let date: String
    let journal: Bool
    let breathe: Bool
    let ground: Bool
    let sleep: Bool
    let checkin: Bool
    let exercise: Bool
    let meditate: Bool
    
    //Default initialiser
    init(){
        self.date = ""
        self.journal = false
        self.breathe = false
        self.ground = false
        self.sleep = false
        self.checkin = false
        self.exercise = false
        self.meditate = false
    }
    
    //initialiser with date
    init(date: String){
        self.date = date
        self.journal = false
        self.breathe = false
        self.ground = false
        self.sleep = false
        self.checkin = false
        self.exercise = false
        self.meditate = false
    }
}
