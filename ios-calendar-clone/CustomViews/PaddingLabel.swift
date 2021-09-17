//
//  PaddingLabel.swift
//  ios-calendar-clone-uikit
//
//  Created by Chandan Karmakar on 17/09/21.
//

import UIKit

class PaddingLabel: UILabel {

    var contentInset: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + contentInset.left + contentInset.right,
                      height: size.height + contentInset.top + contentInset.bottom)
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (contentInset.left + contentInset.right)
        }
    }
}
