//
//  YearListView.swift
//  CalendarCloneSwiftUI
//
//  Created by Chandan Karmakar on 01/08/21.
//

import ASCollectionView
import SwiftUI
import calendar_support

struct YearListView: View {
    var items: [YearItem] = (1900 ... 2100).map { YearItem(year: $0) }

    var body: some View {
        ASCollectionView(data: items, dataID: \.year) { item, _ in
            YearView(item: item)
        }
        .layout {
            return ASCollectionLayoutSection.list(itemSize: NSCollectionLayoutDimension.estimated(400), spacing: 0, sectionInsets: NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20), insetSupplementaries: false, stickyHeader: false, stickyFooter: false)
        }
    }
}

struct YearListView_Previews: PreviewProvider {
    static var previews: some View {
        YearListView()
    }
}
