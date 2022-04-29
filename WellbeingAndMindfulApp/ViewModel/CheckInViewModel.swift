//
//  CheckInViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 12/02/2022.
//

import Foundation

//Class - Check in view model
class CheckInViewModel{
    
    //Function - calls check in load database handler
    static func CheckInLoadVM()-> String{
        let response = FirebaseDB.checkInLoadFirebase()
        if response == 1 {
            return "Error"
        }
        return ""
    }
    
    //Function - calls checkin save database handler
    static func CheckSave(tod: Int, mood: String, input: String?, rating: Int?)->String{
        let newCheck = CheckIn(mood: mood, input: input!, rating: rating!)
        let response = FirebaseDB.checkInSaveFirebase(checkIn: newCheck, tod: tod)
        if response == 2{
            let daytime = self.getTod(tod: tod)
            return daytime + " Check-In Saved"
        }else {
            return "Error saving check in"
        }
    }
    
    //Function - Gets the time of the day based on Integer
    static func getTod(tod: Int)-> String{
        switch tod{
        case 1: do{
            return "Morning"
        }
        case 2: do{
            return "Afternoon"
        }
        case 3: do{
            return "Evening"
        }
        default: do{ return "Night"}
        }
    }
}
