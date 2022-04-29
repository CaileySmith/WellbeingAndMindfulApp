//
//  Ground.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 10/02/2022.
//

import Foundation

//Struct - Ground
struct Ground{
    
    //Variables
    var hear : Array<String?>
    var see : Array<String?>
    var touch : Array<String?>
    var smell : Array<String?>
    var taste : String
    
    //Default initialiser
    init(){
        self.hear = []
        self.see = []
        self.touch = []
        self.smell = []
        self.taste = ""
    }
    
    //Initialiser with all fields
    init(hear : Array<String?>, see : Array<String?>, touch : Array<String?>, smell : Array<String?>, taste : String){
        self.hear = hear
        self.see = see
        self.touch = touch
        self.smell = smell
        self.taste = taste
    }
    
}
