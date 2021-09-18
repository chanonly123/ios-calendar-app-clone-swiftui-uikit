//
//  YearList.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 01/08/21.
//

import Foundation

public struct YearList {
    public var years = [YearItem]()
    public let current: Int
    
    public init() {
        let cal = Calendar.current
        current = cal.component(.year, from: Date())
        let min = current-50
        let max = current+50
        for i in min...max {
            years.append(.init(year: i))
        }
    }
    
}
