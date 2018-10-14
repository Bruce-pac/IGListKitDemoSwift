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
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: UserInfoCell.cellIdentifier, bundle: nil, for: self, at: index) as? UserInfoCell else { fatalError() }
        cell.bindViewModel(viewModel as Any)
        cell.onClickArrow = {[weak self] cell in
            guard let self = self else { return }
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "share", style: .default, handler: nil))
            actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            actionSheet.addAction(UIAlertAction(title: "delete", style: .default, handler: { (action) in
                NotificationCenter.default.post(name: Notification.Name.custom.delete, object: self.object)
            }))
            self.viewController?.present(actionSheet, animated: true, completion: nil)
        }
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
    }
}

extension Notification.Name {
    struct custom {
        static let delete = Notification.Name("delete")
    }
}
