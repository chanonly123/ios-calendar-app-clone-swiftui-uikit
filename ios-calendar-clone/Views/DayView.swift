//
//  DayView.swift
//  ios-calendar-clone-uikit
//
//  Created by Chandan Karmakar on 17/09/21.
//

import calendar_support
import Combine
import UIKit

final class DayView: UICollectionViewCell {
    let lbl = PaddingLabel()
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
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        addSubview(lbl)
        
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.font = .systemFont(ofSize: 16)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.01
        lbl.baselineAdjustment = .alignCenters
        lbl.contentInset = .init(top: 2, left: 2, bottom: 2, right: 2)
        
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
