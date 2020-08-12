//
//  UIViewExtension.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit
extension UIImageView {
    func circleImageWithBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        clipsToBounds = true
        layer.cornerRadius = min(bounds.size.height, bounds.size.width) / 2.0
    }
}
