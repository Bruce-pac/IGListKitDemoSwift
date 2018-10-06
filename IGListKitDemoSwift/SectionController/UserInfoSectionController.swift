//
//  UserInfoSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

final class UserInfoSectionController: ListSectionController {

    var object: Feed!
    lazy var viewModel: UserInfoCellModel = {
        let model = UserInfoCellModel(avatar: URL(string: object.avatar), userName: object.userName)
        return model
    }()


    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        return CGSize(width: width, height: 30)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "UserInfoCell", bundle: nil, for: self, at: index) as? UserInfoCell else { fatalError() }
        cell.bindViewModel(viewModel as Any)
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
    }
}
