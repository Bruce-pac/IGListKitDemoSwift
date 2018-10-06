//
//  Extensions.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit

extension UIImage {
    static func image(with color: UIColor,size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UICollectionViewCell {
   static var cellIdentifier: String {
        get {
            let a = NSStringFromClass(self)
            let className = a.split(separator: ".").last
            return String(className!)
        }
    }
}
