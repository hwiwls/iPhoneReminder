//
//  UIView+addSubViews.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/14/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
