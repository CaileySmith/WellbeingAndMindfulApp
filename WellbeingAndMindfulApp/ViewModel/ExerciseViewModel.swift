//
//  ExerciseViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 08/01/2022.
//

import Foundation

//Class - Exercise view model
class ExerciseViewModel{
    
    //Function - calls exercise load database handler
    static func ExerciseLoadVM()-> String{
        let response = FirebaseDB.exerciseLoadFirebase()
        if response == 1 {
            return "Error"
        }
        return ""
    }
    
    //Function - calls exercise save database handler
    static func ExerciseSaveVM(type: String, hour:Int, min: Int, time: String)-> String{
        //creates instance of Exercise model
        let newExercise = Exercise(type: type, hour: hour, min: min)
        let response = FirebaseDB.exerciseSaveFirebase(exercise: newExercise)
        if response == 2{
            return "\(time) exercise saved for \(type)"
        }else {
            return "Error saving exercise"
        }
    }
}
