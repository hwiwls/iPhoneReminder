//
//  UIButton + Configuration.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/15/24.
//

import UIKit

extension UIImage {
    func resizedImage(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIButton {
    func trailingBtnConfiguration(title: String, font: UIFont, foregroundColor: UIColor, padding: Int, image: UIImage?, imageSize: CGSize) {
        let resizedImg = image?.resizedImage(to: imageSize)
        
        var config = UIButton.Configuration.plain()
        config.image = resizedImg
        config.imagePadding = CGFloat(padding)
        config.imagePlacement = .trailing
        
        var titleAttr = AttributedString.init(title)
        titleAttr.foregroundColor = foregroundColor
        titleAttr.font = font
        config.attributedTitle = titleAttr
        config.baseForegroundColor = foregroundColor
        self.backgroundColor = .darkGray
        
        self.configuration = config
    }
}
