//
//  CustomDatePickerSwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 29/04/2022.
//

import SwiftUI

struct CustomDatePickerSwiftUIView: View {
    @Binding var currentDate: Date
    
    //month update on arrow button click
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35) {
            //Days...
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack(spacing:20){
                Button {
                    //Back to view controller
                }label: {
                    Image(systemName: "arrow.left")
                }
                VStack(alignment: .leading, spacing: 10){
                    Text(extraDate()[1])
                        .font(.caption)
                        .fontWeight(.bold)
                    Text(extraDate()[0])
                        .font(.title.bold())
                    
                }
                Spacer(minLength: 0)
                Button {
                    withAnimation{
                        currentMonth -= 1
                    }
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation{
                        currentMonth += 1
                    }
                }label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }.padding(.horizontal)
            //day View ....
            HStack(spacing: 0){
                ForEach(days, id: \.self){ day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            //Dates..
            //lazy grid..
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()){ value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(.blue)
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            VStack(spacing: 15) {
                Text("Entries")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical,20)
                
                if let task = tasks.first(where: {task in
                    return isSameDay(date1: task.taskDate, date2: currentDate)
                }){
                    ForEach(task.task){task in
                        VStack (alignment: .leading, spacing: 10){
                            //For custom timeing...
                            Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
                            Text(task.title)
                                .font(.title2.bold())
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.blue).opacity(0.5).cornerRadius(10)
                        
                    }
                
                }else{
                    Text("No Entires Found")
                }
                
            }
            .padding()
            
            
            
        }
        .onChange(of: currentMonth) {newValue in
            //updating month
            currentDate = getCurrentMonth()
            //get tracks
          
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        VStack {
            if value.day != -1 {
                
                if let task = tasks.first(where: {task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white: .primary)
                        .frame(minWidth: 60)
                    
                    Spacer()
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .blue)
                        .frame(width: 8, height: 8)
                }
                else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white: .primary)
                        .frame(minWidth: 60)
                    Spacer()
                }
                
            }
        }.padding(.vertical, 9)
            .frame(height: 60, alignment: .top)
       
    }
    
    //checking dates..
    //change to match string and date
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //extracting year and month string
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        let date = formatter.string(from:currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date{
        
        let calendar = Calendar.current
        //Getting current month date ...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    
    
    func extractDate()->[DateValue]{
        let calendar = Calendar.current
        //Getting current month date ...
       let currentMonth = getCurrentMonth()
       var days = currentMonth.getAllDates().compactMap{ date -> DateValue in
            //getting day...
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        //adding offset days to get exact week day ...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

//struct CustomDatePickerSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeSwiftUIView()
//    }
//}


//extending date to get current month date...
extension Date {
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        //getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        //getting date..
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}


