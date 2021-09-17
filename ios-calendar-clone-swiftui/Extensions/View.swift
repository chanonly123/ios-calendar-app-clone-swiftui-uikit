//
//  View.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 01/08/21.
//

import SwiftUI

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
