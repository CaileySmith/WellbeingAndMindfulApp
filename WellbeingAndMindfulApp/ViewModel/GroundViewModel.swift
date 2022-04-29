//
//  GroundViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 10/02/2022.
//

import Foundation

//Class - Ground view model
class GroundViewModel{
    
    //Function - calls exercise load database handler
    static func GroundLoadVM()-> String{
        let response = FirebaseDB.groundLoadFirebase()
        if response == 1 {
            return "Error"
        }
        return ""
    }
    
    //Function - calls ground save database handler
    static func saveGroundVm(hear : Array<String?>, see : Array<String?>, touch : Array<String?>, smell : Array<String?>, taste : String)-> String{
        let newGround = Ground(hear: hear, see: see, touch: touch, smell: smell, taste: taste)
        let response = FirebaseDB.groundSaveFirebase(ground: newGround)
        if response == 2{
            return "Grounding saved"
        }else {
            return "Error saving exercise"
        }
    }
}
