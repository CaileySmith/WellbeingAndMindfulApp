//
//  TrackViewController.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 13/12/2021.
//

import UIKit
import Firebase
import Charts

//ViewController Class - track screen
class TrackViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ChartViewDelegate  {
    
    //Variables - outlets for view
    @IBOutlet weak var InfoButton: UIBarButtonItem!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var monthlyViewButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    //Variables
    var colour = "green"
    var trackCat = ["Journal", "Breathe", "Ground", "Sleep", "Checkin", "Exercise", "Meditate"]
    var streakCount = ""
    var rec = false

    //Function - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //style elements
        switch colour {
        case "green": do {
            StyleSheet.styleFilledButtonLevel1(monthlyViewButton)
            StyleSheet.styleBarButtonLevel1(homeButton)
            StyleSheet.styleBarButtonLevel1(InfoButton)
        }
        case "purple": do {
            StyleSheet.styleFilledButtonLevel2(monthlyViewButton)
            StyleSheet.styleBarButtonLevel2(homeButton)
            StyleSheet.styleBarButtonLevel2(InfoButton)
        }
        case "blue": do {
            StyleSheet.styleFilledButtonLevel3(monthlyViewButton)
            StyleSheet.styleBarButtonLevel3(homeButton)
            StyleSheet.styleBarButtonLevel3(InfoButton)
        }
        case "orange": do {
            StyleSheet.styleFilledButtonExtra1(monthlyViewButton)
            StyleSheet.styleBarButtonExtra1(homeButton)
            StyleSheet.styleBarButtonExtra1(InfoButton)
        }
        case "pink" : do {
            StyleSheet.styleFilledButtonExtra2(monthlyViewButton)
            StyleSheet.styleBarButtonExtra2(homeButton)
            StyleSheet.styleBarButtonExtra2(InfoButton)
        }
        default: do {}
        }
        //set up picker
        categoryPicker.delegate = self
        categoryPicker.delegate?.pickerView?(categoryPicker, didSelectRow: 0, inComponent: 0)
        //create chart
        createChart()
    }
    
    //Action Function - back to home screen
    @IBAction func HomeButton(_ sender: UIBarButtonItem) {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController) as? HomeViewController
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
    }
    
    //Action Function - Shows information about page
    @IBAction func InfoPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "A graph of the streaks for each category is shown. Choose which category you wish to see the records for. On the next page the dates will be shown, by choosing a date you can see the records for that day.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay",style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    //Function - Number of components in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //Function - Number of rows per component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return trackCat.count
    }

    //Function - Filling rows for each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return String(trackCat[row])
    }
    
    //Function - Segue to date view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: TrackMonthlyViewController = segue.destination as! TrackMonthlyViewController
        secondVC.category = trackCat[categoryPicker.selectedRow(inComponent: 0)]
        secondVC.colour = colour
    }
    
    //Function - formats a message box
    func messageBox(message: String){
        let alert = UIAlertController(title: "Track", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
        (action:UIAlertAction!)in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Function - creating the pie chart based on the streaks for all categorys
    func createChart(){
        //create pie chart
        let pieChart = PieChartView()
        var tracks = [PieChartDataEntry]()
        pieChart.delegate = self
        pieChart.frame = CGRect(x: 0, y: 0, width: self.chartView.frame.size.width, height: self.chartView.frame.size.height)
        pieChart.center = chartView.center
        chartView.addSubview(pieChart)
        let db = Firestore.firestore()
        let cats = ["journal", "breathe", "ground", "sleep", "checkin", "exercise", "meditate"]
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
                            //add to pie chart
                            tracks.append(PieChartDataEntry(value: Double(streak)!, label: category))
                        }
                    }else {
                        print("error")
                    }
                }
            }
        }
        //delay to ensure all data is read then added to pie chart
        var x = 0.1
        for _ in 0...30{
            DispatchQueue.main.asyncAfter(deadline: .now() + x){
                let set = PieChartDataSet(entries: tracks, label: "Streaks")
                set.colors = [
                    //set colours for pie chart
                    NSUIColor(cgColor: UIColor.init(red: 109/255, green: 157/255, blue: 135/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 216/255, green: 238/255, blue: 227/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 157/255, green: 126/255, blue: 187/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 240/255, green: 217/255, blue: 255/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 57/255, green: 162/255, blue: 219/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 162/255, green: 219/255, blue: 250/255, alpha: 1).cgColor),
                    NSUIColor(cgColor: UIColor.init(red: 253/255, green: 207/255, blue: 232/255, alpha: 1).cgColor)
                ]
                //add data to pie chart
                let data = PieChartData(dataSet: set)
                pieChart.data = data
                }
            x = x + 0.1
        }
    }
}
