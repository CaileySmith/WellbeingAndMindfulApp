//
//  MeditateViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 26/02/2022.
//

import Foundation

//Class - Meditate view model
class MeditateViewModel{
    
    //Function - calls meditate load database handler
    static func loadMeditate(){
        _ = FirebaseDB.meditateLoadFirebase()
    }
    
    //Function - calls silent meditate save database handler
    static func saveMeditateSilent(type: String, time: Int)->String{
     let newSilent = Meditate(type: type, time: time)
       let response = FirebaseDB.meditateSilentSaveFirebase(meditate: newSilent)
       if response == 2 {
           return "Saved"
       }else {
           return "not saved"
       }
    }
    
    //Function - calls music meditate save database handler
    static func saveMeditateMusic(type: String, track: Int)->String{
     let newMusic = Meditate(type: type, track: track)
        let response = FirebaseDB.meditateMusicSaveFirebase(meditate: newMusic)
        if response == 2 {
            return "Saved"
        }else {
            return "not saved"
        }
     }
}
