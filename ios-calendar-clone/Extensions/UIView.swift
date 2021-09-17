//
//  UIView.swift
//  ios-calendar-clone-uikit
//
//  Created by Chandan Karmakar on 17/09/21.
//

import UIKit

public extension UIView {
    func addPinConstraints(_ val: CGFloat = 0) {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: val).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -val).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: val).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -val).isActive = true
    }

    func addPinConstraints(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if let left = left {
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: left).isActive = true
        }
        if let right = right {
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -right).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: parent.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -bottom).isActive = true
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIView {
    func swiftUIView() -> SwiftUIView {
        return SwiftUIView(view: self)
    }
}

struct SwiftUIView: UIViewRepresentable {
    let view: UIView
    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {}
}
#endif
