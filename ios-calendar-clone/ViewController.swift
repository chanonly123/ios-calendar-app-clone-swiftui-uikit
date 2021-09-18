//
//  ViewController.swift
//  ios-calendar-clone
//
//  Created by Chandan Karmakar on 17/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    let yearListView = YearListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = yearListView
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        yearListView.collectionView.collectionViewLayout.invalidateLayout()
//    }
}

