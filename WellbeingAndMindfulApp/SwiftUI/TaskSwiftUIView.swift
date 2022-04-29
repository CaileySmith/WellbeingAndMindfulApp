//
//  TaskSwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 29/04/2022.
//

import SwiftUI

//Task Model and Sample Tasks ..
//array of tasks
struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

//total task meta view
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task : [Task]
    var taskDate: Date

}

//total task meta view
struct TrendMetaData: Identifiable {
    var id = UUID().uuidString
    var journal: [Journal]
    var breathe : [Breathe]
    var ground : [Ground]
    var sleep: [Sleep]
    var checkin: [CheckIn]
    var exercise: [Exercise]
    var meditate: [Meditate]
    var trendDate: String
    var taskDate: Date

}

//sample date for testing
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

//sample tasks
var tasks: [TaskMetaData] = [
TaskMetaData(task: [
    Task(title: "Task one"),
    Task(title: "Task two"),
    Task(title: "Task three")],taskDate: getSampleDate(offset: 1)),
TaskMetaData(task: [
    Task(title: "Task four")], taskDate: getSampleDate(offset: -3)),
TaskMetaData(task: [
    Task(title: "Task five")], taskDate: getSampleDate(offset: -8)),
TaskMetaData(task: [
    Task(title: "Task six")], taskDate: getSampleDate(offset: -7)),
TaskMetaData(task: [
    Task(title: "Task seven")], taskDate: getSampleDate(offset: -6)),
TaskMetaData(task: [
    Task(title: "Task eight")], taskDate: getSampleDate(offset: 5)),
]

