//
//  YearView.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 01/08/21.
//

import SwiftUI
import calendar_support

struct YearView: View {
    var item = YearItem(year: 2021)

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(String(item.year))")
                    .font(.system(size: 32))
                    .foregroundColor(item.isCurrentYear ? .red : .black)
                    .bold()
                Spacer()
            }
            Divider()
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 18, trailing: 0))
            VStack(spacing: 10) {
                ForEach(item.months, id: \.self) { months in
                    HStack(spacing: 8) {
                        ForEach(months, id: \.self) { month in
                            MonthVIew(item: month)
                        }
                    }
                }
            }
        }.onAppear {
            print("\(type(of: self)), \(item.year)")
        }
    }
}

struct YearView_Previews: PreviewProvider {
    static var previews: some View {
        YearView()
    }
}
