//
//  FavorCellModel.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/29.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

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

extension FavorCellModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: (self.feed?.feedId)!)
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object {
            return true
        }
        guard let obj = object as? FavorCellModel else { return false }
        return (self.isFavor == obj.isFavor) && (self.favorNum == obj.favorNum)
    }
}
