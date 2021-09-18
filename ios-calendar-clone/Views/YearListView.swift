//
//  MonthView.swift
//  ios-calendar-clone-uikit
//
//  Created by Chandan Karmakar on 17/09/21.
//

import calendar_support
import Combine
import UIKit

class YearListView: UIView {
    var bag = Set<AnyCancellable>()
    
    @Published
    var item = YearList()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let interItemSpacing: CGFloat = 8
    let lineSpacing: CGFloat = 8
    let horizontalPadding: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .white
                
        addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(YearView.self, forCellWithReuseIdentifier: "YearView")
                
        $item.dropFirst().sink { [unowned self] _ in
            self.collectionView.reloadData()
        }.store(in: &bag)
        
        DispatchQueue.main.async {
            let index = self.item.years.count / 2
            self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .top, animated: false)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension YearListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearView", for: indexPath) as! YearView
        cell.item = item.years[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - horizontalPadding * 2
        let height = width * 1.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: horizontalPadding, bottom: 0, right: horizontalPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct YearListViewPreview: PreviewProvider {
    static var previews: some View {
        YearListView()
            .swiftUIView()
    }
}
#endif
