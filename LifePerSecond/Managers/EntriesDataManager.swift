//
//  EntriesDataManager.swift
//  LifePerSecond
//
//  Created by Macbook on 04.10.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//
import Foundation
import Charts

class EntriesDataManager  {
    
    private let calendar = Calendar.current
    private let timeSetterManaager = TimeSetterManager()
    
    //MARK: - Creating & Receiving Entrie For All Pie
    func creatingAndReceivingEntrieFor(tasks: [Task], atSegmentFor index: Int? = nil) -> PieChartData {
        
        var pieChartEntries = [PieChartDataEntry]()
        
        for task in tasks {
            let timeForSpecificDate = timeSetterManaager.getSpecificTimeFor(task, atSegmentFor: index)
            
            let entrie = PieChartDataEntry(value: Double(timeForSpecificDate), label: "\(task.name ?? "")")
            if entrie.value > 0 {
                pieChartEntries.append(entrie)
            }
        }
        let dataSet = creatingAndReceivingSet(entries: pieChartEntries)
        let dataForCharts = creatingAndReceivingData(set: dataSet)
        
        return dataForCharts
    }
    
    private func creatingAndReceivingSet(entries: [PieChartDataEntry]) -> PieChartDataSet {
        let setForDataChart = PieChartDataSet(entries: entries, label: nil)
        
        setForDataChart.colors = ChartColorTemplates.pastel()
        
        return setForDataChart
    }
    
    private func creatingAndReceivingData(set: PieChartDataSet) -> PieChartData {
        let dataForCharts = PieChartData(dataSet: set)
        
        return dataForCharts
    }
    
    //MARK: - Creating & Receiving Entrie For All Bar
    
    //MARK: - Creating & Receiving Entrie For Information Bar
    func creatingAndReceivingEntrieFor(_ task: Task, atSegment index: Int? = nil) -> BarChartData? {
        var barChartEntries: [BarChartDataEntry]? = []
        
        guard let taskObject = task.setTimeAndDate else { return nil }
        guard let dictionaryBarChartEntries = getEntryDictionary(from: taskObject) else { return nil }
        switch index {
        case 1:
            guard let rangeOfMonth = calendar.range(of: .day, in: .month, for: Date()) else { return nil }
            barChartEntries = getListOfDaysIn(range: rangeOfMonth, from: dictionaryBarChartEntries)
        case 2:
            barChartEntries = getEntrieForYearFrom(entriesDictionary: dictionaryBarChartEntries)
        default:
            guard let rangeOfWeek = calendar.range(of: .day, in: .weekOfMonth, for: Date()) else { return nil }
            barChartEntries = getListOfDaysIn(range: rangeOfWeek, from: dictionaryBarChartEntries)
        }
        
        let dataSet = creatingAndReceivingSet(entries: barChartEntries)
        let dataForCharts = creatingAndReceivingData(set: dataSet)
        
        return dataForCharts
    }
    
    private func creatingAndReceivingSet(entries: [BarChartDataEntry]?) -> BarChartDataSet {
        let setForDataChart = BarChartDataSet(entries: entries, label: nil)
        setForDataChart.colors = ChartColorTemplates.pastel()
        return setForDataChart
    }
    
    private func creatingAndReceivingData(set: BarChartDataSet) -> BarChartData {
        let dataForCharts = BarChartData(dataSet: set)
        //dataForCharts.setDrawValues(false)
        
        return dataForCharts
    }
    //MARK: - {{{
    private func getEntryDictionary(from taskObject: NSOrderedSet) -> [String: Double]? {
        var dictionaryBarChartEntries = [String: Double]()
        
        var auxiliaryDate: DateComponents?
        var lastDateOnMonth: Date?
        var dayOnMonth: String?
        var valueForEntrie = 0.0
        
        for dataElement in taskObject {
            guard let timeDataObject = dataElement as? TimeAndDate else { return nil }
            let dateCompForTimeDataObject = calendar.dateComponents([.day, .month, .year], from: timeDataObject.date ?? Date())
            
            if auxiliaryDate == nil {
                auxiliaryDate = calendar.dateComponents([.day, .month, .year], from: timeDataObject.date ?? Date())
                dayOnMonth = dateFormatorFor(date: timeDataObject.date ?? Date())
            }
            
            if dateCompForTimeDataObject == auxiliaryDate  {
                valueForEntrie += Double(timeDataObject.timeCounter)
            } else {
                dictionaryBarChartEntries[dayOnMonth ?? "Key Error"] = valueForEntrie / 60
                auxiliaryDate = calendar.dateComponents([.day, .month, .year], from: timeDataObject.date ?? Date())
                dayOnMonth = dateFormatorFor(date: timeDataObject.date ?? Date())
                valueForEntrie = Double(timeDataObject.timeCounter)
            }
            lastDateOnMonth = timeDataObject.date
        }
        guard let lastDayOnMonth = dateFormatorFor(date: lastDateOnMonth) else { return nil}
        dictionaryBarChartEntries[lastDayOnMonth] = valueForEntrie / 60
        
        return dictionaryBarChartEntries
    }
    private func dateFormatorFor(date: Date?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.M.yy"
        guard let date = date else { return nil }
        let dayOnMonth = formatter.string(from: date)
        
        return dayOnMonth
    }
    //MARK: - }}} - Это все конечно же нужно как то по божески сделать, пока просто работает
    private func getListOfDaysIn(range: CountableRange<Int>, from entriesDictionary: [String : Double]) -> [BarChartDataEntry] {
        var barChartEntries = [BarChartDataEntry]()
        
        for day in range {
            barChartEntries.append(compareFor(day, from: entriesDictionary))
        }
        return barChartEntries
    }
    private func compareFor(_ DayOfMonth: Int, from entriesDictionary: [String : Double]) -> BarChartDataEntry {
        let customDay = monthAndYearFormatFor(DayOfMonth)
        
        for (dateKey, valueForEntrie) in entriesDictionary {
            if customDay == dateKey {
                return BarChartDataEntry(x: Double(DayOfMonth), y: valueForEntrie)
            }
        }
        return BarChartDataEntry(x: Double(DayOfMonth), y: 0)
    }
    private func monthAndYearFormatFor(_ day: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.yy"
        let monthAndYear = formatter.string(from: Date())
        let customDate = String(day) + "." + monthAndYear
        
        return customDate
    }
    
    private func getEntrieForYearFrom(entriesDictionary: [String : Double]) -> [BarChartDataEntry]? {
        var barChartEntries = [BarChartDataEntry]()
        
        guard let rangeOfYear = calendar.range(of: .month, in: .year, for: Date()) else { return nil }
        
        for month in rangeOfYear {
            barChartEntries.append(compareFor(month: month, entriesDictionary: entriesDictionary))
        }
        return barChartEntries
    }
    private func compareFor(month: Int, entriesDictionary: [String : Double]) -> BarChartDataEntry {
        var summForEntrie = 0.0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy"
        let year = formatter.string(from: Date())
        let customDate = ".\(month).\(year)"
        
        for (dateKey, valueForEntrie) in entriesDictionary {
            let index = dateKey.firstIndex(of: ".")
            let editDateKey = dateKey[(index!)...]
            
            if editDateKey == customDate {
                summForEntrie += valueForEntrie
            }
        }
        return BarChartDataEntry(x: Double(month), y: summForEntrie)
    }
}
