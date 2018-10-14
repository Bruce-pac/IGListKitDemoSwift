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
        return viewModels.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        return CGSize(width: width, height: 44)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: CommentCell.cellIdentifier, bundle: nil, for: self, at: index) as? CommentCell else { fatalError() }
        cell.bindViewModel(viewModels[index])
        cell.onClickDelete = {[weak self] (deleteCell) in
            guard let self = self else {
                return
            }
            self.collectionContext?.performBatch(animated: true, updates: { (batch) in
                let deleteIndex: Int! = self.collectionContext?.index(for: deleteCell, sectionController: self)
                self.viewModels.remove(at: deleteIndex)
                batch.delete(in: self, at: IndexSet(integer: deleteIndex))
            }, completion: nil)
        }
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
    }
}
