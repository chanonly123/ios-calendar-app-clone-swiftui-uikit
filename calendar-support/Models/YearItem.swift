//
//  MainItem.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 01/08/21.
//

import Foundation

public struct YearItem: Identifiable, Hashable {
    public let year: Int
    
    public let id: Int
    public var months = [[MonthItem]]()
    
    public init(year: Int) {
        self.year = year
        self.id = year
        var items = [MonthItem]()
        for i in 1...12 {
            items.append(MonthItem(year: year, month: i))
        }
        for i in 0..<4 {
            months.append([])
            for j in 0..<3 {
                months[i].append(items[i*3+j])
            }
        }
    }
    
    public static func == (lhs: YearItem, rhs: YearItem) -> Bool {
        return lhs.year == rhs.year
    }

    public var isCurrentYear: Bool {
        let cal = Calendar.current
        let comps = cal.dateComponents([.year], from: Date())
        return comps.year == year
    }
}
