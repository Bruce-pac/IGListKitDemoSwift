//
//  CommentSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

class CommentSectionController: ListSectionController {

    var object: Feed!
    lazy var viewModels: [CommentCellModel] = {
        let vms: [CommentCellModel]  = object.comments?.map({ (comment) -> CommentCellModel in
            let vm = CommentCellModel()
            vm.comment = comment
            return vm
        }) ?? []
        return vms
    }()

    override func numberOfItems() -> Int {
        return object.comments?.count ?? 0
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        return CGSize(width: width, height: 44)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: CommentCell.cellIdentifier, bundle: nil, for: self, at: index) as? CommentCell else { fatalError() }
        cell.bindViewModel(viewModels[index])
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
    }
}
