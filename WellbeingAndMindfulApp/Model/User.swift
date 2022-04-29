//
//  User.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 08/01/2022.
//

import Foundation

//Struct - User
struct User{
    
    //Variables
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let uid : String
    let date : String
    
    //Default initaliser
    init(){
        self.email = ""
        self.password = ""
        firstName = ""
        lastName = ""
        uid = ""
        date = ""
    }
    
    //Initaliser with email and password
    init(email: String, password: String){
        self.email = email
        self.password = password
        firstName = ""
        lastName = ""
        uid = ""
        date = ""
    }
    
    //Initaliser with email, uid and date
    init(email: String, uid : String, date: String){
        self.firstName = ""
        self.lastName = ""
        self.uid = uid
        self.date = date
        self.email = email
        password = ""
    }
    
    //Initaliser with email, password, first and last name
    init(email: String, password: String, first: String, last: String){
        self.email = email
        self.password = password
        self.firstName = first
        self.lastName = last
        self.uid = ""
        date = ""
    }
    
    //Initaliser with all fields
    init(email: String, password: String, first: String, last: String, uid : String){
        self.email = email
        self.password = password
        self.firstName = first
        self.lastName = last
        self.uid = uid
        date = ""
    }
}
