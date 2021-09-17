//
//  DayItem.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 30/07/21.
//

import Foundation
import SwiftUI
import UIKit

public struct DayItem: Identifiable, Hashable {
    var empty = false
    var text = ""
    var date = Date()
    
    public let id: Int
    let comps: DateComponents
    let isToday: Bool
    
    public init(empty: Bool = false, text: String = "", date: Date = Date()) {
        self.empty = empty
        self.text = text
        self.date = date
        
        let cal = Calendar.current
        isToday = cal.isDate(date, inSameDayAs: Date())
        comps = cal.dateComponents([.day, .month, .year], from: date)
        id = (comps.year! * 100 + comps.month!) * 100 + comps.day!
    }
    
    public enum DayItemType { case date, text, empty}
    
    public var type: DayItemType { empty ? .empty : (text.isEmpty ? .date : .text) }
    
    public var textShow: String {
        switch type {
        case .date:
            return "\(comps.day ?? -1)"
        case .text:
            return text
        case .empty:
            return ""
        }
    }
    
    public var backgroundUIColor : UIColor {
        return UIColor(backgroundColor)
    }
    
    public var backgroundColor: Color {
        switch type {
        case .date:
            return isToday ? .red : .clear
        case .text:
            return .clear
        case .empty:
            return .clear
        }
    }
    
    public var foregroundUIColor : UIColor {
        return UIColor(foregroundColor)
    }
    
    public var foregroundColor: Color {
        switch type {
        case .date:
            return isToday ? .white : .black
        case .text:
            return .black
        case .empty:
            return .clear
        }
    }
}
