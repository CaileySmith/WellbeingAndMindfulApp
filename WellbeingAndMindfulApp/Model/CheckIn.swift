//
//  CheckIn.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 12/02/2022.
//

import Foundation

//Struct - CheckIn
struct CheckIn{
    
    //Variables
    let mood : String
    let input: String
    let rating : Int
    let tod: String
    
    //Default initaliser
    init(){
        self.mood = ""
        self.input = ""
        self.rating = 0
        self.tod = ""
    }
    
    //Initalising with mood, imput and rating
    init(mood: String, input: String, rating: Int){
        self.mood = mood
        self.input = input
        self.rating = rating
        self.tod = ""
    }
    
    //Initialising with all fields
    init(mood: String, input: String, rating: Int, tod: String){
        self.mood = mood
        self.input = input
        self.rating = rating
        self.tod = tod
    }
}
