//
//  LoginViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 08/01/2022.
//

import Foundation

//Class - Login view model
class LoginViewModel{
    
    //Function - calls login database handler
    static func LoginVM(email: String, password: String)-> String{
        //creates new instance of user model
        let newUser = User(email: email, password: password)
        let response = FirebaseDB.loginFirebase(user: newUser)
        //based on result of login returns a string
        if response == 1{
            return "Could not log in"
        }else if response == 2 {
            return "User logged in"
        }else {
            return "Error"
        }
    }
}
