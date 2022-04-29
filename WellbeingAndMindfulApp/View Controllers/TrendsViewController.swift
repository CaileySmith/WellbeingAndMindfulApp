//
//  TrendsViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 20/03/2022.
//

import UIKit
import Firebase
import Charts

//ViewController Class - trend screen
class TrendsViewController: UIViewController, ChartViewDelegate{
    
    //Variables - outlets for view
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    @IBOutlet weak var Trend1: UILabel!
    @IBOutlet weak var Trend2: UILabel!
    @IBOutlet weak var Trend3: UILabel!
    @IBOutlet weak var Trend4: UILabel!
    @IBOutlet weak var Trend5: UILabel!
    @IBOutlet weak var Trend6: UILabel!
    @IBOutlet weak var Trend7: UILabel!
    @IBOutlet weak var ChartView: UIView!

    //Variables
    var colour = "green"
    let categories = ["Streaks", "Journal", "Breathe", "Ground", "Sleep", "Checkin", "Exercise", "Meditate"]
    
    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up for view
        Trend2.alpha = 1
        Trend3.alpha = 1
        Trend4.alpha = 1
        Trend5.alpha = 1
        Trend6.alpha = 1
        Trend7.alpha = 1
        //load trends and chart
        loadTrends()
        //set up for view
        switch colour {
        case "green": do {
            StyleSheet.styleBarButtonLevel1(HomeButton)
        }
        case "purple": do {
            StyleSheet.styleBarButtonLevel2(HomeButton)
        }
        case "blue": do {
            StyleSheet.styleBarButtonLevel3(HomeButton)
        }
        case "orange": do {
            StyleSheet.styleBarButtonExtra1(HomeButton)
        }
        case "pink" : do {
            StyleSheet.styleBarButtonExtra2(HomeButton)
        }
        default: do {}
        }
    }
    
    //Action Function - back to home screen
    @IBAction func HomePressed(_ sender: UIBarButtonItem) {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Function - loading the trends and chart from the database
    func loadTrends(){
        //create the inital pie chart
        let pieChart = PieChartView()
        var weeks = [PieChartDataEntry]()
        pieChart.delegate = self
        view.addSubview(pieChart)
        pieChart.frame = CGRect(x: 35, y: 500, width: 330, height: 280)
        //get the week dates
        let week = Date().daysOfWeek(using: .gregorian).map(\.MMMMddyyyy)
        //variables for formatting
        var techList: Array<String> = []
        var lengthList: Array<Int> = []
        var hourList: Array<Int> = []
        var minList : Array<Int> = []
        var sleepHList: Array<Int> = []
        var sleepMList : Array<Int> = []
        var moodList: Array<String> = []
        var ratingList : Array<Int> = []
        var silentList : Array<String> = []
        var musicList: Array<String> = []
        var count = 0
        var weekList : Array<Double> = [0,0,0,0,0,0,0]
    
        //For each day in the week
        for day in week{
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            if let user = user {
                let userid = user.uid
                //get daily document
                db.collection("users").document(userid).collection("daily").document("\(day)").getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                        weekList[count] = 1.0
                        //adds day to pie chart
                        weeks.append(PieChartDataEntry(value: 1.0, label: day))
                        //get breathe documents
                        let breathedb = Firestore.firestore()
                        breathedb.collection("users").document(userid).collection("daily").document("\(day)").collection("breathe").getDocuments{ (breatheSnap , err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            }else{
                                for doc in breatheSnap!.documents {
                                    let technique = doc.get("technique") as? String ?? ""
                                    let time = doc.get("minutes") as? Int ?? 0
                                    techList.append(technique)
                                    lengthList.append(time)
                                }
                            }
                        }
                        //get exercise documents
                        let exercisedb = Firestore.firestore()
                        exercisedb.collection("users").document(userid).collection("daily").document("\(day)").collection("exercise").getDocuments{ (exerciseSnap , err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            }else{
                                for doc in exerciseSnap!.documents {
                                    let hour = doc.get("hour") as? Int ?? 0
                                    let min = doc.get("minutes") as? Int ?? 0
                                    hourList.append(hour)
                                    minList.append(min)
                                }
                            }
                        }
                        //get sleep documents
                        let sleepdb = Firestore.firestore()
                        sleepdb.collection("users").document(userid).collection("daily").document("\(day)").collection("sleep").getDocuments{ (sleepSnap , err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            }else{
                                for doc in sleepSnap!.documents {
                                    let hour = doc.get("hour") as? Int ?? 0
                                    let min = doc.get("minute") as? Int ?? 0
                                    sleepHList.append(hour)
                                    sleepMList.append(min)
                                }
                            }
                        }
                        //get checkin documents
                        let checkindb = Firestore.firestore()
                        checkindb.collection("users").document(userid).collection("daily").document("\(day)").collection("checkin").getDocuments{ (checkinSnap , err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            }else{
                                for doc in checkinSnap!.documents {
                                    let mood = doc.get("mood") as? String ?? ""
                                    let rating = doc.get("rating") as? Int ?? 0
                                    moodList.append(mood)
                                    ratingList.append(rating)
                                }
                            }
                        }
                        //get meditate documents
                        let meditatedb = Firestore.firestore()
                        meditatedb.collection("users").document(userid).collection("daily").document("\(day)").collection("meditate").getDocuments{ (meditateSnap , err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            }else{
                                for doc in meditateSnap!.documents {
                                    let type = doc.get("type") as? String ?? ""
                                    if type == "Music" {
                                        musicList.append(type)
                                    }else if type == "Silent" {
                                        silentList.append(type)
                                    }
                                }
                            }
                        }
                    } else {
                        //add no record
                        weekList[count] = 0
                    }
                    count += 1
                }
            }
        }
    
        //delay in showing data as database has delay
        var x = 0.1
        for _ in 0...20{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){
                //set pie chart up
                let set = PieChartDataSet(entries: weeks, label: "Days Tracked")
                set.colors = [
                    NSUIColor(cgColor: UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 216/255, green: 238/255, blue: 227/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 240/255, green: 217/255, blue: 255/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 162/255, green: 219/255, blue: 250/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 253/255, green: 207/255, blue: 232/255, alpha: 1).cgColor)
                ]
                let data = PieChartData(dataSet: set)
                pieChart.data = data
            
                //show trends
                self.Trend2.alpha = 1
                self.Trend3.alpha = 1
                self.Trend4.alpha = 1
                self.Trend5.alpha = 1
                self.Trend6.alpha = 1
                self.Trend7.alpha = 1
                //ensure there are records for the week
                var rec = 0
                for w in weekList {
                    rec += Int(w)
                }
                if rec == 0 {
                    self.noRecords()
                } else {
                    //trend 5 and 6
                    let totalLen = lengthList.reduce(0, +)
                    self.Trend5.text = "- Your most used breathing technique has been \(self.mostCommonElementsInArray(stringArray: techList))"
                    self.Trend6.text = "- You have done a total of \(totalLen) minutes breathing exercises"
                    
                    //trend 4
                    let hourCount = hourList.count
                    let minCount = minList.count
                    if hourCount != 0 || minCount != 0 {
                        var totalH = 0
                        for h in hourList {
                            totalH += h
                        }
                        var totalM = 0
                        for m in minList{
                            totalM += m
                        }
                        var avgH = 0
                        var avgM = 0
                        if totalH == 0 {
                            avgH = 0
                            avgM = totalM/minCount
                            if totalM == 0 {
                                avgM = 0
                            }
                        }else if totalM == 0 {
                            avgM = 0
                            avgH = totalH/hourCount
                        }else {
                            avgH = totalH/hourCount
                            avgM = totalM/minCount
                        }
                        self.Trend4.text = "- You have averaged a total of \(avgH) hours and \(avgM) minutes of exercise"
                    }else {
                        self.Trend4.text = "..."
                    }
                    
                    //trend 3
                    let sleepHCount = sleepHList.count
                    let sleepMCount = sleepMList.count
                    if sleepHCount != 0 || sleepMCount != 0 {
                        var totalsleepH = 0
                        for sh in sleepHList {
                            totalsleepH += sh
                        }
                        var totalsleepM = 0
                        for sm in sleepMList{
                            totalsleepM += sm
                        }
                        var avgsleepH = 0
                        var avgsleepM = 0
                        if totalsleepH == 0 {
                            avgsleepH = 0
                            avgsleepM = totalsleepM/sleepMCount
                            if totalsleepM == 0 {
                                avgsleepM = 0
                            }
                        }else if totalsleepM == 0 {
                            avgsleepM = 0
                            avgsleepH = totalsleepH/sleepHCount
                        }else {
                            avgsleepH = totalsleepH/sleepHCount
                            avgsleepM = totalsleepM/sleepMCount
                        }
                        self.Trend3.text = "- You have averaged a total of \(avgsleepH) hours and \(avgsleepM) minutes of sleep"
                    }else {
                        self.Trend3.text = "..."
                    }
                    
                    //trend 1
                    self.Trend1.text = "- Your most common mood has been \(self.mostCommonElementsInArray(stringArray: moodList))"
                    
                    //trend 2
                    let ratingCount = ratingList.count
                    var avgRating = 0
                    if ratingCount != 0 {
                        var totalRating = 0
                        for rate in ratingList {
                            totalRating += rate
                        }
                        if totalRating == 0 {
                            avgRating = 0
                        }else {
                            avgRating = totalRating/ratingCount
                        }
                    }
                    self.Trend2.text = "- Your average feeling rating this week was \(avgRating) / 10"
                    
                    //trend 7
                    self.Trend7.text = "- You have meditated silently \(silentList.count) times and with music \(musicList.count) times"
                }
                }
            x = x + 0.1
        }
    }
    
    //Function - no records for the week
    func noRecords(){
        self.Trend1.text = "No trends available for this week yet"
        self.Trend2.alpha = 0
        self.Trend3.alpha = 0
        self.Trend4.alpha = 0
        self.Trend5.alpha = 0
        self.Trend6.alpha = 0
        self.Trend7.alpha = 0
    }
    
    //Function - finding the most common elements in an array
    func mostCommonElementsInArray(stringArray: [String])->String{
        let dict = Dictionary(grouping: stringArray, by: {$0})
        let newDict = dict.mapValues({$0.count})
        return newDict.sorted(by: {$0.value > $1.value}).first?.key ?? "..."
    }
}

//Extension - calender
extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
    static let gregorian = Calendar(identifier: .gregorian)
}

//Extenstion date
extension Date {
    
    //Function - by adding
    func byAdding(component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }
    
    //Function - date compondents
    func dateComponents(_ components: Set<Calendar.Component>, using calendar: Calendar = .current) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
    
    //Function - get start of week
    func startOfWeek(using calendar: Calendar = .current) -> Date {
        calendar.date(from: dateComponents([.yearForWeekOfYear, .weekOfYear], using: calendar))!
    }
    
    //Function - get noon
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    //Function - get days of week
    func daysOfWeek(using calendar: Calendar = .current) -> [Date] {
        let startOfWeek = self.startOfWeek(using: calendar).noon
        return (0...6).map { startOfWeek.byAdding(component: .day, value: $0, using: calendar)! }
    }
    
    //Function - get 90 days
    func days90(using calendar: Calendar = .current) -> [Date] {
        let start90 = Date()
        return (-90...0).map { start90.byAdding(component: .day, value: $0, using: calendar)! }
    }
}

//Extension - Formatter
extension Formatter {
    static let MMMMddyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
}

//Extension date format
extension Date {
    var MMMMddyyyy: String { Formatter.MMMMddyyyy.string(from: self) }
}

//Extension - Int parse
extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

