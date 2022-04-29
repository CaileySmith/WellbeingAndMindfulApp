//
//  SleepViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 09/01/2022.
//

import Foundation

//Class - Sleep view model
class SleepViewModel{
    
    //Function - calls sleep load database handler
    static func SleepLoadVM()->String{
        let response = FirebaseDB.sleepLoadFirebase()
        if response == 1 {
            return "Error"
        }
        return ""
    }
    
    //Function - calls sleep save database handler
    static func SleepSaveVM(length: String, quality: Int, hour: Int, min: Int)-> String{
        //creates new instance of Sleep model
        let newSleep = Sleep(length: length, quality: quality, hour: hour, min: min)
        let response = FirebaseDB.sleepSaveFirebase(sleep: newSleep)
        if response == 2{
            return "Sleep for \(length) with \(quality)/10 quality saved"
        }else{
            return "Error saving Sleep"
        }
    }
}
