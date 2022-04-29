//
//  Meditate.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 26/02/2022.
//

import Foundation

//Struct - Meditate
struct Meditate{
    
    //Variables
    let type : String
    let time : Int
    let track: Int
    
    //Initalising with type and time
    init(type: String, time: Int){
        self.type = type
        self.time = time
        self.track = 0
    }
    
    //Initialsing with type and track
    init(type: String, track: Int){
        self.type = type
        self.time = 0
        self.track = track
    }
    
    //Initalising with all fields
    init(type: String, track: Int,  time: Int){
        self.type = type
        self.time = time
        self.track = track
    }
}
