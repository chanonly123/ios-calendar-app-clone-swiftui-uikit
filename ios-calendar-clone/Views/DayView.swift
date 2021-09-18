//
//  DayView.swift
//  ios-calendar-clone-uikit
//
//  Created by Chandan Karmakar on 17/09/21.
//

import calendar_support
import Combine
import UIKit

class DayView: UICollectionViewCell {
    let lbl = UILabel()
    var bag = Set<AnyCancellable>()
    
    @Published
    var item: DayItem = DayItem(text: "-")
    
    convenience init(item: DayItem) {
        self.init(frame: .zero)
        self.item = item
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        contentView.addSubview(lbl)
        
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.font = .systemFont(ofSize: 10)
        lbl.baselineAdjustment = .alignCenters
        
        $item.map { $0.backgroundUIColor }
            .assign(to: \.backgroundColor, on: lbl)
            .store(in: &bag)
        
        $item.map { $0.textShow }
            .assign(to: \.text, on: lbl)
            .store(in: &bag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lbl.layer.cornerRadius = lbl.bounds.height / 2
        let size = min(bounds.width, bounds.height)
        lbl.frame = CGRect(x: 0, y: 0, width: size, height: size)
        lbl.center = center
    }
}

extension DayItem {
    public var backgroundUIColor : UIColor {
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct DayViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            DayView(item: DayItem(date: Date()))
                .swiftUIView()
                .background(Color.gray.opacity(0.2))
            DayView(item: DayItem(empty: true))
                .swiftUIView()
                .background(Color.gray.opacity(0.2))
            DayView(item: DayItem(text: "M"))
                .swiftUIView()
                .background(Color.gray.opacity(0.2))
        }
        .previewLayout(.fixed(width: 20, height: 110))
    }
}
#endif
