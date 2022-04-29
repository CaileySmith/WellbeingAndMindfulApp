//
//  FirebaseDB.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 08/01/2022.
//

import Foundation
import Firebase
import FirebaseAuth
import simd

//Class - database handler
class FirebaseDB{
    
    //Function - Login in database
    static func loginFirebase(user: User)->Int{
        var response = 0
        //logs into database using email and password
        Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, err) in
            if err != nil {
                response = 1
            }else{
                response = 2
            }
        }
        if response != 1 {
            response = 2
        }
        return response
    }
    
    //Function - sign in database
    static func signInFirebase(user: User)-> Int{
        var response = 0
        var uid: String = ""
        //creates a new user in authentication database
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, err in
            if err != nil{
                response = 1
            }else {
                uid = result!.user.uid
                let db =  Firestore.firestore()
                //creates a new user in firestore database
                db.collection("users").document(uid).setData(["firstname": user.firstName, "lastname": user.lastName, "uid": uid, "level": 1, "colour": "green", "email":user.email]) { err in
                    if err != nil{
                        response = 1
                    }
                }
                let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                let today = date.MMMMddyyyy
                let trackData: [String: Any] = [
                    "all":[
                        "date": today,
                        "streak": "0"
                    ],
                    "journal":[
                        "date": today,
                        "streak": "0"
                    ],
                    "exercise":[
                        "date":today,
                        "streak": "0"
                    ],
                    "sleep":[
                        "date":today,
                        "streak": "0"
                    ],
                    "ground":[
                        "date":today,
                        "streak": "0"
                    ],
                    "checkin":[
                        "date":today,
                        "streak": "0"
                    ],
                    "breathe":[
                        "date":today,
                        "streak": "0"
                    ],
                    "meditate":[
                        "date":today,
                        "streak": "0"
                    ]
                    
                    
                ]
                //creates blank track collection in database for user
                db.collection("users").document(uid).collection("track").document("tracking").setData(trackData){ err in
                    if err != nil{
                        response = 1
                    }else {
                        response = 2
                    }
                }
            }
        }
        if response != 1 {
            response = 2
        }
    return response
    }
    
    //Function - Save journal entry
    static func journalSaveFirebase(entry: Journal)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //changes the daily field in database to tracked
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "journal":"tracked"], merge: true)
            //adds journal data to database
            db.collection("users").document(userid).collection("daily").document(today).collection("journal").document("1").setData(["entry":entry.entry]){ err in
                if err != nil{
                    response = 1
                }
            }
        //updates the tracking part of the database
        let docRef = db.collection("users").document(userid).collection("track").document("tracking")
        docRef.getDocument { (document, err)in
            if let document = document , document.exists{
                if let doc = document.get("journal") as? [String: Any]{
                    let journalStreak = doc["streak"] as? String ?? "0"
                    let journalDate = doc["date"] as? String ?? ""
                    let streak = Int(journalStreak)
                    let increase = streak! + 1
                    let newStreak = String(increase)
                    if journalDate != today {
                        db.collection("users").document(userid).collection("track").document("tracking").setData(["journal":["date": today, "streak": newStreak]], merge: true)
                    }
                }
                if let all = document.get("all") as? [String: Any]{
                    let allStreak = all["streak"] as? String ?? "0"
                    let allDate = all["date"] as? String ?? ""
                    let streak = Int(allStreak)
                    let increase = streak! + 1
                    let newStreak = String(increase)
                    if allDate != today {
                        db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                    }
                }
                    }else {
                        response = 1
                    }
                }
                response = 2
            }else {
                response = 1
            }
        return response
    }
    
    //Function - load default exercise document
    static func exerciseLoadFirebase()-> Int{
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //creates a new document
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today], merge: true)
            db.collection("users").document(userid).collection("daily").document(today).collection("exercise")
            return 2
        }else {
            return 1
        }
    }
    
    //Function - Save exercise to database
    static func exerciseSaveFirebase(exercise: Exercise)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document(today).collection("exercise").getDocuments(){
                (QuerySnapshot, err) in
                if err != nil {
                    response = 1
                }else{
                    var count = 0
                    for _ in QuerySnapshot!.documents{
                        count += 1
                    }
                    let amount: String = String(count + 1)
                    //adds exercise data to the database
                    db.collection("users").document(userid).collection("daily").document(today).collection("exercise").document(amount).setData(["type": exercise.type, "hour": exercise.hour, "minutes": exercise.min])
                    //updating the tracking part of the database
                    db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "exercise":"tracked"], merge: true)
                    let docRef = db.collection("users").document(userid).collection("track").document("tracking")
                    docRef.getDocument { (document, err)in
                        if let document = document , document.exists{
                            if let doc = document.get("exercise") as? [String: Any]{
                                let exerciseStreak = doc["streak"] as? String ?? "0"
                                let exerciseDate = doc["date"] as? String ?? ""
                                let streak = Int(exerciseStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if exerciseDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["exercise":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                            if let all = document.get("all") as? [String: Any]{
                                let allStreak = all["streak"] as? String ?? "0"
                                let allDate = all["date"] as? String ?? ""
                                let streak = Int(allStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if allDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                        }
                    }
                    response = 2
                }
            }
        }
        if response != 1{
            response = 2
        }
        return response
    }
    
    //Function - load default sleep document
    static func sleepLoadFirebase()-> Int{
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //creates new sleep document
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today], merge: true)
            db.collection("users").document(userid).collection("daily").document(today).collection("sleep")
            return 2
        }else {
            return 1
        }
    }
    
    //Function - save sleep to database
    static func sleepSaveFirebase(sleep: Sleep)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document(today).collection("sleep").getDocuments(){
                (QuerySnapshot, err) in
                if err != nil {
                    response = 1
                }else{
                    var count = 0
                    for _ in QuerySnapshot!.documents{
                        count += 1
                    }
                    let amount: String = String(count + 1)
                    //adds sleep to database
                    db.collection("users").document(userid).collection("daily").document(today).collection("sleep").document(amount).setData(["length": sleep.length, "quality": sleep.quality, "hour" : sleep.hour, "minute" : sleep.min])
                    //updates tracking part of the database
                    db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "sleep":"tracked"], merge: true)
                    let docRef = db.collection("users").document(userid).collection("track").document("tracking")
                    docRef.getDocument { (document, err)in
                        if let document = document , document.exists{
                            if let doc = document.get("sleep") as? [String: Any]{
                                let sleepStreak = doc["streak"] as? String ?? "0"
                                let sleepDate = doc["date"] as? String ?? ""
                                let streak = Int(sleepStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if sleepDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["sleep":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                            if let all = document.get("all") as? [String: Any]{
                                let allStreak = all["streak"] as? String ?? "0"
                                let allDate = all["date"] as? String ?? ""
                                let streak = Int(allStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if allDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                        }
                    }
                    response = 2
                }
            }
        }
        if response != 1{
            response = 2
        }
        return response
    }
    
    //Function - load default ground document
    static func groundLoadFirebase()-> Int{
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //creates new ground document
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today], merge: true)
            db.collection("users").document(userid).collection("daily").document(today).collection("ground")
            return 2
        }else {
            return 1
        }
    }

    //Function - save ground to database
    static func groundSaveFirebase(ground: Ground)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document(today).collection("ground").getDocuments(){
                (QuerySnapshot, err) in
                if err != nil {
                    response = 1
                }else{
                    var count = 0
                    for _ in QuerySnapshot!.documents{
                        count += 1
                    }
                    let amount: String = String(count + 1)
                    //saves ground to database
                    db.collection("users").document(userid).collection("daily").document(today).collection("ground").document(amount).setData(["hear": ground.hear, "see": ground.see, "touch": ground.touch, "smell" : ground.smell, "taste": ground.taste])
                    //update tracking
                    db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "ground":"tracked"], merge: true)
                    let docRef = db.collection("users").document(userid).collection("track").document("tracking")
                    docRef.getDocument { (document, err)in
                        if let document = document , document.exists{
                            if let doc = document.get("ground") as? [String: Any]{
                                let groundStreak = doc["streak"] as? String ?? "0"
                                let groundDate = doc["date"] as? String ?? ""
                                let streak = Int(groundStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if groundDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["ground":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                            if let all = document.get("all") as? [String: Any]{
                                let allStreak = all["streak"] as? String ?? "0"
                                let allDate = all["date"] as? String ?? ""
                                let streak = Int(allStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if allDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                        }
                    }
                    response = 2
                }
            }
        }
        if response != 1{
            response = 2
        }
        return response
    }
    
    //Function - load default checkin document
    static func checkInLoadFirebase()-> Int{
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //creates new document for check in
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today], merge: true)
            db.collection("users").document(userid).collection("daily").document(today).collection("checkin")
            return 2
        }else {
            return 1
        }
    }
    
    //Function - Save checkin entry
    static func checkInSaveFirebase(checkIn: CheckIn, tod: Int)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //saves check in into database
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "checkin": "tracked"], merge: true)
            db.collection("users").document(userid).collection("daily").document(today).collection("checkin").document(String(tod)).setData(["mood": checkIn.mood, "input": checkIn.input, "rating": checkIn.rating]){ err in
                if err != nil{
                    response = 1
                }
            }
        
        //updates tracking
        let docRef = db.collection("users").document(userid).collection("track").document("tracking")
        docRef.getDocument { (document, err)in
            if let document = document , document.exists{
                if let doc = document.get("checkin") as? [String: Any]{
                    let journalStreak = doc["streak"] as? String ?? "0"
                    let journalDate = doc["date"] as? String ?? ""
                    let streak = Int(journalStreak)
                    let increase = streak! + 1
                    let newStreak = String(increase)
                    if journalDate != today {
                        db.collection("users").document(userid).collection("track").document("tracking").setData(["checkin":["date": today, "streak": newStreak]], merge: true)
                    }
                }
                if let all = document.get("all") as? [String: Any]{
                    let allStreak = all["streak"] as? String ?? "0"
                    let allDate = all["date"] as? String ?? ""
                    let streak = Int(allStreak)
                    let increase = streak! + 1
                    let newStreak = String(increase)
                    if allDate != today {
                        db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                    }
                }
                    }else {
                        response = 1
                    }
                }
                response = 2
            }else {
                response = 1
            }
        return response
    }
    
    //Function - load default breathe document
    static func breatheLoadFirebase()-> Int{
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //creates new breathe document
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today], merge: true)
            db.collection("users").document(userid).collection("daily").document(today).collection("breathe")
            return 2
        }else {
            return 1
        }
    }

    
    //Function - save ground to database
    static func breatheSaveFirebase(breathe: Breathe)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let time = formatter.string(from: date)
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document(today).collection("breathe").getDocuments(){
                (QuerySnapshot, err) in
                if err != nil {
                    response = 1
                }else{
                    var count = 0
                    for _ in QuerySnapshot!.documents{
                        count += 1
                    }
                    let amount: String = String(count + 1)
                    //adds breathe to database
                    db.collection("users").document(userid).collection("daily").document(today).collection("breathe").document(amount).setData(["technique" : breathe.technique, "minutes" : breathe.time, "time" : time])
                    //updates tracking
                    db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "breathe":"tracked"], merge: true)
                    let docRef = db.collection("users").document(userid).collection("track").document("tracking")
                    docRef.getDocument { (document, err)in
                        if let document = document , document.exists{
                            if let doc = document.get("breathe") as? [String: Any]{
                                let breatheStreak = doc["streak"] as? String ?? "0"
                                let breatheDate = doc["date"] as? String ?? ""
                                let streak = Int(breatheStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if breatheDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["breathe":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                            if let all = document.get("all") as? [String: Any]{
                                let allStreak = all["streak"] as? String ?? "0"
                                let allDate = all["date"] as? String ?? ""
                                let streak = Int(allStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if allDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                        }
                    }
                    response = 2
                }
            }
        }
        if response != 1{
            response = 2
        }
        return response
    }
    


    //Function - load default meditate document
    static func meditateLoadFirebase()-> Int{
        let db = Firestore.firestore()
        let date = Date()
        let today = date.MMMMddyyyy
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            //creates new meditate document
            db.collection("users").document(userid).collection("daily").document(today).setData(["date": today], merge: true)
            db.collection("users").document(userid).collection("daily").document(today).collection("meditate")
            return 2
        }else {
            return 1
        }
    }


    //Function - save meditate silent to database
    static func meditateSilentSaveFirebase(meditate: Meditate)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let formatter = DateFormatter()
        let today = date.MMMMddyyyy
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let time = formatter.string(from: date)
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document(today).collection("meditate").getDocuments(){
                (QuerySnapshot, err) in
                if err != nil {
                    response = 1
                }else{
                    var count = 0
                    for _ in QuerySnapshot!.documents{
                        count += 1
                    }
                    let amount: String = String(count + 1)
                    //saves meditate data
                    db.collection("users").document(userid).collection("daily").document(today).collection("meditate").document(amount).setData(["type" : meditate.type, "minutes" : meditate.time, "time" : time])
                    //updates tracking
                    db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "meditate":"tracked"], merge: true)
                    let docRef = db.collection("users").document(userid).collection("track").document("tracking")
                    docRef.getDocument { (document, err)in
                        if let document = document , document.exists{
                            if let doc = document.get("meditate") as? [String: Any]{
                                let meditateStreak = doc["streak"] as? String ?? "0"
                                let meditateDate = doc["date"] as? String ?? ""
                                let streak = Int(meditateStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if meditateDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["meditate":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                            if let all = document.get("all") as? [String: Any]{
                                let allStreak = all["streak"] as? String ?? "0"
                                let allDate = all["date"] as? String ?? ""
                                let streak = Int(allStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if allDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                        }
                    }
                    response = 2
                }
            }
        }
        if response != 1{
            response = 2
        }
        return response
    }

    //Function - save mediate music to database
    static func meditateMusicSaveFirebase(meditate: Meditate)-> Int{
        var response = 0
        let db = Firestore.firestore()
        let date = Date()
        let formatter = DateFormatter()
        let today = date.MMMMddyyyy
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let time = formatter.string(from: date)
        let user = Auth.auth().currentUser
        if let user = user {
            let userid = user.uid
            db.collection("users").document(userid).collection("daily").document(today).collection("meditate").getDocuments(){
            (QuerySnapshot, err) in
                if err != nil {
                    response = 1
                }else{
                    var count = 0
                    for _ in QuerySnapshot!.documents{
                        count += 1
                    }
                    let amount: String = String(count + 1)
                    //saves meditate to database
                    db.collection("users").document(userid).collection("daily").document(today).collection("meditate").document(amount).setData(["type" : meditate.type, "track" : meditate.track, "time" : time])
                    //updates tracking
                    db.collection("users").document(userid).collection("daily").document(today).setData(["date": today, "meditate":"tracked"], merge: true)
                    let docRef = db.collection("users").document(userid).collection("track").document("tracking")
                    docRef.getDocument { (document, err)in
                        if let document = document , document.exists{
                            if let doc = document.get("meditate") as? [String: Any]{
                                let meditateStreak = doc["streak"] as? String ?? "0"
                                let meditateDate = doc["date"] as? String ?? ""
                                let streak = Int(meditateStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if meditateDate != today {
                                    //Sstreak += 1
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["meditate":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                            if let all = document.get("all") as? [String: Any]{
                                let allStreak = all["streak"] as? String ?? "0"
                                let allDate = all["date"] as? String ?? ""
                                let streak = Int(allStreak)
                                let increase = streak! + 1
                                let newStreak = String(increase)
                                if allDate != today {
                                    db.collection("users").document(userid).collection("track").document("tracking").setData(["all":["date": today, "streak": newStreak]], merge: true)
                                }
                            }
                        }
                    }
                    response = 2
                }
            }
        }
        if response != 1{
            response = 2
        }
        return response
    }
    
    //Function - sign up database
    static func signUpAdminFirebase(user: User, admin: Bool)-> Int{
        var response = 0
        var uid: String = ""
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, err in
            if err != nil{
                response = 1
            }else {
                uid = result!.user.uid
                let db =  Firestore.firestore()
                db.collection("admin").document(uid).setData(["firstname": user.firstName, "lastname": user.lastName, "uid": uid, "admin": admin]) { err in
                    if err != nil{
                        response = 1
                    }
                }
            }
        }
        if response != 1 {
            response = 2
        }
    return response
    }
}
