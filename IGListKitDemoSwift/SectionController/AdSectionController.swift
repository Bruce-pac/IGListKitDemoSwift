//
//  AdSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

class AdSectionController: ListSectionController {

    var object: Ad!

    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        return CGSize(width: width, height: 100)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: AdCell.self, for: self, at: index) as? AdCell else { fatalError() }
        cell.adTitle = object.adTitle
        return cell
    }
    override func didUpdate(to object: Any) {
        self.object = object as? Ad
    }
}
