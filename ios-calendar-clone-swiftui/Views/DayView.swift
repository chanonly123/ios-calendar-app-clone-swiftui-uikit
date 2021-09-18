//
//  DayView.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 30/07/21.
//

import SwiftUI
import calendar_support

struct DayView: View {
    var item: DayItem = DayItem(text: "-")
    var size: CGFloat = 35

    var body: some View {
            VStack {
                Text(item.textShow)
                    .font(.system(size: 16))
                    .minimumScaleFactor(0.01)
                    .padding(2)
            }
            .frame(maxWidth: size, maxHeight: size)
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(item.foregroundColor)
            .background(
                Circle()
                    .fill(item.backgroundColor)
            )
    }
}

extension DayItem {
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

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DayView(item: DayItem(date: Date()))
            DayView(item: DayItem(empty: true))
            DayView(item: DayItem(text: "M"))
        }
        .background(Color.gray)
            .previewLayout(.fixed(width: 200, height: 500))
    }
}
