//
//  ImagesCollectionCellModel.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit

class ImagesCollectionCellModel {
    private(set) var images: [UIImage] = []
    var imageNames: [String] = [] {
        didSet {
            let a: [UIImage] = imageNames.map { (color) -> UIImage in
                var image: UIImage?
                switch color {
                case "red":
                    image = UIImage.image(with: UIColor.red)
                case "blue":
                    image = UIImage.image(with: UIColor.blue)
                case "yellow":
                    image = UIImage.image(with: UIColor.yellow)
                case "green":
                    image = UIImage.image(with: UIColor.green)
                default:
                    image = UIImage.image(with: UIColor.gray)
                }
                return image!
            }
            images = a
        }
    }
}
