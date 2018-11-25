//
//  FeedBindingSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/11/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class FeedBindingSectionController: ListBindingSectionController<ListDiffable>,ListBindingSectionControllerDataSource,ListBindingSectionControllerSelectionDelegate {

    var comments: [Comment]? = []

    var expanded: Bool = false
    let padding: CGFloat = 10

    override init() {
        super.init()
        dataSource = self
        selectionDelegate = self
    }

    override func didUpdate(to object: Any) {
        guard let obj = object as? Feed else { fatalError() }
        comments = obj.comments
        super.didUpdate(to: object)
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        switch viewModel {
        case is String:
            expanded.toggle()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.6, options: [], animations: {
                self.collectionContext?.invalidateLayout(for: self, completion: nil)
            }, completion: nil)
        default:
            return
        }
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        guard let obj = object as? Feed else { return [] }
        var vms: [ListDiffable] = []
        let userInfo = UserInfoCellModel(avatar: URL(string: obj.avatar), userName: obj.userName)
        vms.append(userInfo)
        if let content = obj.content {
            vms.append(content as ListDiffable)
        }
        if obj.images.count != 0 {
            let vm = ImagesCollectionCellModel()
            vm.imageNames = obj.images
            vms.append(vm)
        }
        let favor = FavorCellModel()
        favor.feed = obj
        vms.append(favor)

        let comments: [CommentCellModel]  = self.comments?.map({ (comment) -> CommentCellModel in
            let vm = CommentCellModel()
            vm.comment = comment
            return vm
        }) ?? []
        vms.append(contentsOf: comments)
        return vms
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
        switch viewModel {
        case is UserInfoCellModel:
            return userInfoCell(at: index)
        case is String:
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: ContentCell.cellIdentifier, bundle: nil, for: self, at: index) as? ContentCell else { fatalError() }
            return cell
        case is ImagesCollectionCellModel:
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: ImageCollectionCell.cellIdentifier, bundle: nil, for: self, at: index) as? ImageCollectionCell else { fatalError() }
            return cell
        case is FavorCellModel:
            return favorCell(at: index)
        case is CommentCellModel:
            return commentCell(at: index)
        default:
            fatalError()
        }
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        guard let object = self.object as? Feed else { fatalError() }

        switch viewModel {
        case is UserInfoCellModel:
            return CGSize(width: width, height: 30)
        case is String:
            let content: String = viewModel as! String
            let height = expanded ? ContentCell.height(for: content as NSString, limitwidth: width) : ContentCell.lineHeight()
            return CGSize(width: width, height: height + 5)
        case is ImagesCollectionCellModel:
            let itemWidth: CGFloat = (width - padding * 2) / 3
            let row: Int = (object.images.count - 1) / 3 + 1
            let h: CGFloat = CGFloat(row) * itemWidth + CGFloat(row - 1) * padding
            return CGSize(width: width, height: h)
        case is FavorCellModel:
            return CGSize(width: width, height: 65)
        case is CommentCellModel:
            return CGSize(width: width, height: 44)
        default:
            fatalError()
        }
    }

    // MARK: cell
    func userInfoCell(at index: Int) -> UserInfoCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "UserInfoCell", bundle: nil, for: self, at: index) as? UserInfoCell else { fatalError() }
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

    func favorCell(at index: Int) -> FavorCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: FavorCell.cellIdentifier, bundle: nil, for: self, at: index) as? FavorCell else { fatalError() }
        cell.favorOperation = {[weak self] cell in
            guard let self = self else { return }
            guard let object = self.object as? Feed else { fatalError() }
            object.isFavor.toggle()
            let origin: UInt! = object.favor
            object.favor = object.isFavor ? (origin + 1) : (origin - 1)
            self.update(animated: true, completion: nil)
        }
        return cell
    }

    func commentCell(at index: Int) -> CommentCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: CommentCell.cellIdentifier, bundle: nil, for: self, at: index) as? CommentCell else { fatalError() }
        cell.onClickDelete = {[weak self] (deleteCell) in
            guard let self = self else {
                return
            }
            let deleteComment: Comment = (deleteCell.viewModel?.comment)!
            self.comments?.removeAll(where: { (c) -> Bool in
                let f = c == deleteComment
                return f
            })
            self.update(animated: true, completion: nil)
        }
        return cell
    }

}
