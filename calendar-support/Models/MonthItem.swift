//
//  MonthItem.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 01/08/21.
//

import Foundation

public struct MonthItem: Identifiable, Hashable {
    public let id: Int
    
    let year: Int
    let month: Int
    
    public var days = [[DayItem]]()
    public var monthName = "Month"
    
    public init(year: Int, month: Int) {
        self.year = year
        self.month = month
        id = year * 100 + month
        populateArray()
    }
    
    mutating func populateArray() {
        let cal = Calendar.current
        let comps = DateComponents(year: year, month: month)
        guard let startOfMonth = cal.date(from: comps) else { return }
        guard let count = cal.range(of: .day, in: .month, for: startOfMonth)?.count else { return }
        let startWeekDay = cal.component(.weekday, from: startOfMonth)
        var allDays = [DayItem]()
        for _ in 0..<startWeekDay - 1 {
            allDays.append(DayItem(empty: true))
        }
        for i in 0..<count {
            allDays.append(DayItem(date: startOfMonth.addingTimeInterval(TimeInterval(24*60*60*i))))
        }
        for _ in 0..<42-allDays.count {
            allDays.append(DayItem(empty: true))
        }
        let df = DateFormatter(); df.dateFormat = "MMM"
        monthName = df.string(from: startOfMonth)
        for i in 0..<6 {
            days.append([])
            for j in 0..<7 {
                days[i].append(allDays[i*7+j])
            }
        }
    }

    func getSunday() -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.hour, .minute, .second], from: Date())
        comps.weekday = 1
        let date = cal.nextDate(after: Date(), matching: comps, matchingPolicy: .nextTime)!
        return date
    }

    func getDayName(date: Date, offset: Int) -> String {
        let df = DateFormatter()
        df.dateFormat = "EEEEE"
        let newDate = date.addingTimeInterval(TimeInterval(offset*24*60*60))
        return df.string(from: newDate)
    }
    
    public var isCurrentMonth: Bool {
        let cal = Calendar.current
        let comps = cal.dateComponents([.month, .year], from: Date())
        return month == comps.month && comps.year == year
    }
}
