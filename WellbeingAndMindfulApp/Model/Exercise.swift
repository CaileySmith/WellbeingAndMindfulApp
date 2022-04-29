//
//  Exercise.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 08/01/2022.
//

import Foundation

//Struct - Exercise
struct Exercise{
    
    //Variables
    let type: String
    let hour: Int
    let min: Int
    
    //Initaliser
    init(type: String, hour: Int, min: Int){
        self.type = type
        self.hour = hour
        self.min = min
    }
}
