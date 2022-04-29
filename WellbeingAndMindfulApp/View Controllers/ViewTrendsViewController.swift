//
//  ViewTrendsViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 22/03/2022.
//

import UIKit
import Firebase
import Charts

class ViewTrendsViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var TitleLabel: UINavigationItem!
    @IBOutlet weak var LabelView: UILabel!
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var TopView: UIView!
    var colour = "green"
    var chosen = ""
    var pieChart = PieChartView()
    var cats = ["journal", "breathe", "ground", "sleep", "checkin", "exercise", "meditate"]
    var tracks = [PieChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        switch chosen {
        case "Streaks": do {
            loadStreaks()
        }
        case "Journal": do {
            loadJournal()
        }
        case "Breathe": do {
            loadBreathe()
        }
        case "Ground": do {
            //no
        }
        case "Sleep": do {
            
        }
        case "Checkin": do {
            
        }
        case "Exercise": do {
            
        }
        case "Meditate": do {
            
        }
        default: do {
            
        }
        }

    }
    
    func loadStreaks(){
        pieChart.delegate = self
        pieChart.frame = CGRect(x: 20, y: 60, width: self.TopView.frame.size.width, height: self.TopView.frame.size.height)
        pieChart.center = TopView.center
        TopView.addSubview(pieChart)
        let db = Firestore.firestore()
        for x in cats{
            let category: String = x
            let user = Auth.auth().currentUser
            if let user = user {
                let userid = user.uid
                let docRef = db.collection("users").document(userid).collection("track").document("tracking")
                docRef.getDocument { (document, err)in
                    if let document = document , document.exists{
                        if let doc = document.get("\(category)") as? [String: Any]{
                            let streak = doc["streak"] as? String ?? "0"
                            self.tracks.append(PieChartDataEntry(value: Double(streak)!, label: category))
                        }
                    }else {
                        self.LabelView.text = "error"
                    }
                }
            }
        }
        var x = 0.1
        for _ in 0...30{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){
                let set = PieChartDataSet(entries: self.tracks)
                set.colors = ChartColorTemplates.joyful()
                let data = PieChartData(dataSet: set)
                
                self.pieChart.data = data
                }
            x = x + 0.1
        }
    }
    
    func loadJournal(){
        let week = Date().daysOfWeek(using: .gregorian).map(\.MMMMddyyyy)
        var amount = 0
        for day in week{
            var count = 1
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            if let user = user {
                let userid = user.uid
                db.collection("users").document(userid).collection("daily").document("\(day)").getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                        amount = amount + 1
                    } else {
                        print("Document does not exist")
                    }
                }
            }
            count = count + 1
        }
        var x = 0.1
        for _ in 0...30{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){

                }
            x = x + 0.1
        }
        
    }
    
    func loadBreathe(){
        var breathePie = PieChartView()
        breathePie.frame = CGRect(x: 20, y: 60, width: self.TopView.frame.size.width, height: self.TopView.frame.size.height)
        breathePie.center = TopView.center
        TopView.addSubview(breathePie)
        var list: Array<String> = []
        var breathes = [PieChartDataEntry]()
        var fourSevenEight = 0
        var box = 0
        var altNostril = 0
        var diagpham = 0
        var resonant = 0
        let db = Firestore.firestore()
              let user = Auth.auth().currentUser
                if let user = user {
                    let userid = user.uid
                    db.collection("users").document(userid).collection("daily").whereField("breathe", isEqualTo: "tracked").getDocuments{ (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        }else{
                            for document in querySnapshot!.documents {
                                list.insert(document.documentID, at: list.count)
                                let databse = Firestore.firestore()
                                databse.collection("users").document(userid).collection("daily").document(document.documentID).collection("breathe").getDocuments{ (docs, error) in
                                    if let error = error {
                                        print("Error getting documents: \(error)")
                                    }else {
                                        for doc in docs!.documents {
                                           let technique = doc.get("technique") as? String ?? ""
                                           print(technique)
                                           switch technique{
                                           case "4-7-8": do {
                                               fourSevenEight += 1
                                           }
                                           case "Box Breath": do {
                                               box += 1
                                           }
                                           case "Alternative Nostril": do{
                                               altNostril += 1
                                           }
                                           case "Diaphragmatic": do{
                                               diagpham += 1
                                           }
                                           case "Resonant /Coherent":do{
                                               resonant += 1
                                           }
                                           default : do{
                                           }
                                           }
                                       }
                                }
                            }
                        }
                        }
                            var x = 0.1
                           for _ in 0...60{
                                DispatchQueue.main.asyncAfter(deadline: .now() + x){
                                    breathes.removeAll()
                                    breathes.append(PieChartDataEntry(value: Double(fourSevenEight), label: "4-7-8"))
                                    breathes.append(PieChartDataEntry(value: Double(box), label: "Box Breath"))
                                    breathes.append(PieChartDataEntry(value: Double(altNostril), label: "Alternative Nostril"))
                                    breathes.append(PieChartDataEntry(value: Double(diagpham), label: "Diaphragmatic"))
                                    breathes.append(PieChartDataEntry(value: Double(resonant), label: "Resonant /Coherent"))
                                    let set = PieChartDataSet(entries: breathes, label: "breathing techniques")
                                    set.colors = ChartColorTemplates.joyful()
                                    let data = PieChartData(dataSet: set)
                                    breathePie.data = data
                            }
                                x = x + 0.1
                            }
                            print("\(box)")
                    }
                }
            }
    }
    
    func loadSleep(){
        
    }

//
//extension Calendar {
//    static let iso8601 = Calendar(identifier: .iso8601)
//    static let gregorian = Calendar(identifier: .gregorian)
//}
//
//extension Date {
//    func byAdding(component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .current) -> Date? {
//        calendar.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
//    }
//    func dateComponents(_ components: Set<Calendar.Component>, using calendar: Calendar = .current) -> DateComponents {
//        calendar.dateComponents(components, from: self)
//    }
//    func startOfWeek(using calendar: Calendar = .current) -> Date {
//        calendar.date(from: dateComponents([.yearForWeekOfYear, .weekOfYear], using: calendar))!
//    }
//    var noon: Date {
//        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
//    }
//    func daysOfWeek(using calendar: Calendar = .current) -> [Date] {
//        let startOfWeek = self.startOfWeek(using: calendar).noon
//        return (0...6).map { startOfWeek.byAdding(component: .day, value: $0, using: calendar)! }
//    }
//}
//
//extension Formatter {
//    static let MMMMddyyyy: DateFormatter = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.calendar = Calendar(identifier: .iso8601)
//        dateFormatter.locale = .init(identifier: "en_US_POSIX")
//        dateFormatter.dateStyle = .long
//        return dateFormatter
//    }()
//}
//
//extension Date {
//    var MMMMddyyyy: String { Formatter.MMMMddyyyy.string(from: self) }
//}
