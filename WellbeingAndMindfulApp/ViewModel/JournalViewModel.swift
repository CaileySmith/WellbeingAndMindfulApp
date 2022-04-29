//
//  JournalViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 08/01/2022.
//

import Foundation

//Class - journal view model
class JournalViewModel{
    
    //Function - calls journal save database handle
    static func JournalSaveVM(entry: String)-> String{
        //creates new instance of journal model
        let newEntry = Journal(entry: entry)
        let response = FirebaseDB.journalSaveFirebase(entry: newEntry)
        //based on success of saving journal returns a string
        if response == 1{
            return "Error Saving"
        }else {
            return "Journal Saved"
        }
    }
}

