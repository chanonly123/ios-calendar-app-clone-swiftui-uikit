//
//  MonthView.swift
//  ios-calendar-clone-uikit
//
//  Created by Chandan Karmakar on 17/09/21.
//

import calendar_support
import Combine
import UIKit

class MonthView: UICollectionViewCell {
    var bag = Set<AnyCancellable>()
    
    @Published
    var item = MonthItem(year: 2021, month: 9)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let lblMonth = UILabel()
    
    convenience init(item: MonthItem) {
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
        backgroundColor = .white
        
        contentView.addSubview(lblMonth)
        lblMonth.font = .systemFont(ofSize: 18)
        
        $item.map { $0.monthName }
            .assign(to: \.text, on: lblMonth)
            .store(in: &bag)
        
        contentView.addSubview(collectionView)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonthViewCell.self, forCellWithReuseIdentifier: "MonthViewCell")
        
        $item.dropFirst().sink { [unowned self] _ in
            self.collectionView.reloadData()
        }.store(in: &bag)
        
        lblMonth.addPinConstraints(top: 4, left: 0, bottom: nil, right: 0)
        collectionView.addPinConstraints(top: nil, left: 0, bottom: 0, right: 0)
        collectionView.topAnchor.constraint(equalTo: lblMonth.bottomAnchor, constant: 2)
            .isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    class MonthViewCell: UICollectionViewCell {
        let dayView = DayView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(dayView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            dayView.frame = bounds
        }
    }
}

extension MonthView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        item.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.days[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthViewCell", for: indexPath) as! MonthViewCell
        cell.dayView.item = item.days[indexPath.section][indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 7
        let height = collectionView.bounds.height / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MonthViewPreview: PreviewProvider {
    static var previews: some View {
        MonthView()
            .swiftUIView()
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
#endif
