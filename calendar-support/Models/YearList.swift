//
//  YearList.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 01/08/21.
//

import Foundation

public struct YearList {
    var items = [YearItem]()
    
    init() {
        let current = 2021
        for i in 0..<10 {
            items.append(.init(year: i-5+current))
        }
    }
    
}
