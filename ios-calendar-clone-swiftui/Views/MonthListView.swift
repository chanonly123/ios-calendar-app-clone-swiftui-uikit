//
//  MonthList.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 02/08/21.
//

import SwiftUI
import ASCollectionView
import calendar_support

struct MonthListView: View {
    var items: [MonthItem] = (7...12).map({ MonthItem(year: 2021, month: $0) })
    
    var body: some View {
        ASCollectionView(data: items, dataID: \.id) { item, _ in
            MonthVIew(item: item)
        }
        .layout {
            return ASCollectionLayoutSection.list(itemSize: NSCollectionLayoutDimension.estimated(400), spacing: 0, sectionInsets: NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20), insetSupplementaries: false, stickyHeader: false, stickyFooter: false)
        }
    }
}

struct MonthList_Previews: PreviewProvider {
    static var previews: some View {
        MonthListView()
    }
}
