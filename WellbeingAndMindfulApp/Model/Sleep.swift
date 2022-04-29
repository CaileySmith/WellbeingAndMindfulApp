//
//  Sleep.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 09/01/2022.
//

import Foundation

//Struct - Sleep
struct Sleep{
    
    //Variables 
    let length: String
    let quality: Int
    let hour: Int
    let min: Int
    
    //Initalising with length and quality
    init(length: String, quality: Int){
        self.length = length
        self.quality = quality
        self.hour = 0
        self.min = 0
    }
    
    //Initialising with all fields
    init(length: String, quality: Int, hour: Int, min: Int){
        self.length = length
        self.quality = quality
        self.hour = hour
        self.min = min
    }
}
