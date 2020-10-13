//
//  TimeSetterManager.swift
//  LifePerSecond
//
//  Created by Macbook on 04.10.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//
import Foundation

class TimeSetterManager {
    
    func getAllTimeFor(task: Task) -> Int64 {
        var allTime: Int64 = 0
        guard let timeSet = task.setTimeAndDate else { return 0 }
        for object in timeSet {
            let timeDataOmbject = object as? TimeAndDate
            allTime += timeDataOmbject?.timeCounter ?? 0
        }
        return allTime / 60
    }
//MARK: - {{{
    func getSpecificTimeFor(_ task: Task, atSegmentFor index: Int? = nil) -> Int64 {
        var timeForSpecificDate: Int64 = 0
        
        guard let time = task.setTimeAndDate else { return 0 }
        for object in time {
            let timeDataOmbject = object as? TimeAndDate
            let calendar = Calendar.current

            var dateComponentsForObject: DateComponents?
            var dateComponentsForDate: DateComponents?
            
            switch index {
            case 1:
                dateComponentsForObject = calendar.dateComponents([.weekOfMonth, .month, .year], from: timeDataOmbject?.date ?? Date())
                dateComponentsForDate = calendar.dateComponents([.weekOfMonth, .month, .year], from: (Date()))
            case 2:
                dateComponentsForObject = calendar.dateComponents([.month, .year], from: timeDataOmbject?.date ?? Date())
                dateComponentsForDate = calendar.dateComponents([.month, .year], from: (Date()))
            case 3:
                dateComponentsForObject = calendar.dateComponents([.year], from: timeDataOmbject?.date ?? Date())
                dateComponentsForDate = calendar.dateComponents([.year], from: (Date()))
            default:
                dateComponentsForObject = calendar.dateComponents([.day, .month, .year], from: timeDataOmbject?.date ?? Date())
                dateComponentsForDate = calendar.dateComponents([.day, .month, .year], from: (Date()))
            }
            
            if dateComponentsForObject == dateComponentsForDate {
                timeForSpecificDate += timeDataOmbject?.timeCounter ?? 0
            }
        }
        return timeForSpecificDate / 60
    }
    //MARK: - }}} Подумать 
}
