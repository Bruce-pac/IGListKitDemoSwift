//
//  ImageSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

class ImageSectionController: ListSectionController {

    let padding: CGFloat = 10

    var object: Feed!
    lazy var viewModel: ImagesCollectionCellModel = {
        let vm = ImagesCollectionCellModel()
        vm.imageNames = object.images
        return vm
    }()

    override func numberOfItems() -> Int {
        if object.images.count == 0 {
            return 0
        }
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        let itemWidth: CGFloat = (width - padding * 2) / 3
        let row: Int = (object.images.count - 1) / 3 + 1
        let h: CGFloat = CGFloat(row) * itemWidth + CGFloat(row - 1) * padding
        return CGSize(width: width, height: h)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ImageCollectionCell", bundle: nil, for: self, at: index) as? ImageCollectionCell else { fatalError() }
        cell.bindViewModel(viewModel)
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
        self.inset = UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
    }
}

