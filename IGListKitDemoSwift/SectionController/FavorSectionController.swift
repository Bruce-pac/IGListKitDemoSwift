//
//  FavorSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/5.
//  Copyright © 2018年 bruce. All rights reserved.
//

import IGListKit

class FavorSectionController: ListSectionController {

    var object: Feed!
    lazy var viewModel: FavorCellModel = {
        let vm = FavorCellModel()
        vm.feed = object
        return vm
    }()

    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        return CGSize(width: width, height: 65)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: FavorCell.cellIdentifier, bundle: nil, for: self, at: index) as? FavorCell else { fatalError() }
        cell.bindViewModel(viewModel as Any)
        cell.favorOperation = {[weak self] cell in
            guard let self = self else { return }
            self.object.isFavor.toggle()
            let origin: UInt! = self.object.favor
            self.object.favor = self.object.isFavor ? (origin + 1) : (origin - 1)
            self.viewModel.feed = self.object
            self.collectionContext?.performBatch(animated: true, updates: { (batch) in
                batch.reload(in: self, at: IndexSet(integer: 0))
            }, completion: nil)
        }
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
    }
}
