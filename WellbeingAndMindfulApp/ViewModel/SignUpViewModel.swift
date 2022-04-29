//
//  SignUpViewModel.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 08/01/2022.
//

import Foundation

//Class - Sign up view model
class SignUpViewModel{
    
    //Function - calls sign up database handler
    static func signUpVM(email: String, password: String, first: String, last: String)-> String{
        //creates new instance of user model
        let newUser = User(email: email, password: password, first: first, last: last)
        let response = FirebaseDB.signInFirebase(user: newUser)
        //Based on success of signin returns a string
        if response == 2 {
            return "New user created"
        }else if response == 1{
            return "Error creating user"
        }else if response == 6 {
            return "email in use"
        }else {
            return "Error"
        }
    }
    
    //Function - calls sign up database handler for admin
    static func signUpAdminVM(email: String, password: String, first: String, last: String, admin: Bool)-> String{
        //creates new instance of user model
        let newUser = User(email: email, password: password, first: first, last: last)
        let response = FirebaseDB.signUpAdminFirebase(user: newUser, admin: admin)
        //based on success of signin returns a string
        if response == 2 {
            return "New admin created"
        }else if response == 1{
            return "Error creating user"
        }else {
            return "Error"
        }
    }
}
