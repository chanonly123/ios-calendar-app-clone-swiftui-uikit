//
//  CalMonthVIew.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 30/07/21.
//

import SwiftUI
import calendar_support

struct MonthVIew: View {
    var item = MonthItem(year: 2021, month: 8)

    var body: some View {
        VStack(spacing: 1) {
            if !item.days.isEmpty {
                HStack(spacing: 0) {
                    Text(item.monthName)
                        .font(Font.system(size: 18))
                        .bold()
                        .foregroundColor(item.isCurrentMonth ? .red : .black)
                    Spacer()
                }
                .frame(maxHeight: .infinity)

                ForEach(item.days, id: \.self) { array in
                    HStack(spacing: 0) {
                        ForEach(array, id: \.self) { dayItem in
                            DayView(item: dayItem)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }.aspectRatio(0.9, contentMode: .fit)
    }
}

struct CalMonthVIew_Previews: PreviewProvider {
    static var previews: some View {
        MonthVIew()
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
