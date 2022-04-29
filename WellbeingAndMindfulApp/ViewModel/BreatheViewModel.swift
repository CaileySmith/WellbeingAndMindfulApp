//
//  BreatheViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 24/02/2022.
//

import Foundation

//Class - Breathe view model
class BreatheViewModel{
    
    //Function - calls breathe load database handler
    static func loadBreathe(){
        _ = FirebaseDB.breatheLoadFirebase()
    }
    
    //Function - calls checkin save database handler
    static func saveBreathe(time: Int, technique: String)->String{
     let newBreathe = Breathe(time: time, technique: technique)
       let response = FirebaseDB.breatheSaveFirebase(breathe: newBreathe)
       if response == 2 {
           return "Saved"
       }else {
           return "not saved"
       }
    }
}
