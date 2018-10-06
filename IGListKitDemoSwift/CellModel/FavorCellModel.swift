//
//  FavorCellModel.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/29.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit

class FavorCellModel: NSObject {
   private(set) var isFavor: Bool = false
   private(set) var favorNum: String = ""

    var feed: Feed! {
        didSet {
            isFavor = feed.isFavor
            favorNum = "\(feed.favor!)个👍"
        }
    }
}
