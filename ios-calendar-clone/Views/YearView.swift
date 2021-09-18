//
//  MonthView.swift
//  ios-calendar-clone-uikit
//
//  Created by Chandan Karmakar on 17/09/21.
//

import calendar_support
import Combine
import UIKit

class YearView: UICollectionViewCell {
    var bag = Set<AnyCancellable>()
    
    @Published
    var item = YearItem(year: 2021)

    let lblYear = UILabel()
    let line = UIView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let interItemSpacing: CGFloat = 8
    let lineSpacing: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func commonInit() {
        backgroundColor = .white
        
        contentView.addSubview(lblYear)
        lblYear.font = .boldSystemFont(ofSize: 32)
        lblYear.textColor = item.isCurrentYear ? .red : .black
        
        contentView.addSubview(line)
        line.backgroundColor = .gray
                
        contentView.addSubview(collectionView)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonthView.self, forCellWithReuseIdentifier: "MonthView")
        
        $item.map { "\($0.year)" }
            .assign(to: \.text, on: lblYear)
            .store(in: &bag)
                
        $item.dropFirst().sink { [unowned self] _ in
            self.collectionView.reloadData()
        }.store(in: &bag)
        
        collectionView.addPinConstraints(top: nil, left: 0, bottom: 0, right: 0)
        lblYear.addPinConstraints(top: 0, left: 0, bottom: nil, right: 0)
        collectionView.topAnchor.constraint(equalTo: lblYear.bottomAnchor, constant: 16)
            .isActive = true
        line.addPinConstraints(left: 0, right: 0)
        line.heightAnchor.constraint(equalToConstant: pixelSize).isActive = true
        line.topAnchor.constraint(equalTo: lblYear.bottomAnchor, constant: 2)
            .isActive = true
    }
}

extension YearView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.monthsFlat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthView", for: indexPath) as! MonthView
        cell.item = item.monthsFlat[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        var height = collectionView.bounds.height
        if isPortrait {
            width = (width - (interItemSpacing*2)) / 3
            height = (height - (lineSpacing*3)) / 4
        } else {
            width = (width - (interItemSpacing*5)) / 6
            height = (height - (lineSpacing*1)) / 2
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct YearViewPreview: PreviewProvider {
    static var previews: some View {
        YearView()
            .swiftUIView()
    }
}
#endif
