//
//  FeedSectionController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit



class FeedSectionController: ListSectionController {
    var object: Feed!
    var hasContent: Bool = false
    var hasImage: Bool = false
    var hasComment: Bool = false

    var expanded: Bool = false
    let padding: CGFloat = 10

    lazy var viewModels: [Any] = {
        var vms: [Any] = []
        let userInfo = UserInfoCellModel(avatar: URL(string: object.avatar), userName: object.userName)
        vms.append(userInfo)
        if let content = object.content {
            hasContent = true
            vms.append(content)
        }
        if object.images.count != 0 {
            hasImage = true
            let vm = ImagesCollectionCellModel()
            vm.imageNames = object.images
            vms.append(vm)
        }
        let favor = FavorCellModel()
        favor.feed = object
        vms.append(favor)

        let comments: [CommentCellModel]  = object.comments?.map({ (comment) -> CommentCellModel in
            let vm = CommentCellModel()
            vm.comment = comment
            return vm
        }) ?? []
        hasComment = comments.count > 0
        vms.append(contentsOf: comments)
        return vms
    }()

    // MARK: override

    override func numberOfItems() -> Int {
        return viewModels.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat! = collectionContext?.containerSize(for: self).width
        switch index {
        case 0:
            return CGSize(width: width, height: 30)
        case 1:
            return sizeForItemAtIndex1(width: width)
        case 2:
            return sizeForItemAtIndex2(width: width)
        case 3:
            return sizeForItemAtIndex3(width: width)
        default:
            return CGSize(width: width, height: 44)
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            return userInfoCell(at: index)
        case 1:
            return cellForItemAtIndex1(at: index)
        case 2:
            return cellForItemAtIndex2(at: index)
        case 3:
            return cellForItemAtIndex3(at: index)
        default:
            return commentCell(at: index)
        }
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Feed
        self.inset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }

    override func didSelectItem(at index: Int) {
        if let _ = collectionContext?.cellForItem(at: index, sectionController: self) as? ContentCell {
            expanded.toggle()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.6, options: [], animations: {
                self.collectionContext?.invalidateLayout(for: self, completion: nil)
            }, completion: nil)
        }
    }

    // MARK: size
    func sizeForItemAtIndex1(width: CGFloat) -> CGSize {
        if hasContent {
            guard let content = viewModels[1] as? String else {
                fatalError()
            }
            let height = expanded ? ContentCell.height(for: content as NSString, limitwidth: width) : ContentCell.lineHeight()
            return CGSize(width: width, height: height + 5)
        }
        if hasImage {
            let itemWidth: CGFloat = (width - padding * 2) / 3
            let row: Int = (object.images.count - 1) / 3 + 1
            let h: CGFloat = CGFloat(row) * itemWidth + CGFloat(row - 1) * padding
            return CGSize(width: width, height: h)
        }
        return CGSize(width: width, height: 65)
    }

    func sizeForItemAtIndex2(width: CGFloat) -> CGSize {
        if hasContent && hasImage {
            let itemWidth: CGFloat = (width - padding * 2) / 3
            let row: Int = (object.images.count - 1) / 3 + 1
            let h: CGFloat = CGFloat(row) * itemWidth + CGFloat(row - 1) * padding
            return CGSize(width: width, height: h)
        }
        if hasContent || hasImage {
            return CGSize(width: width, height: 65)
        }
        if hasComment {
            return CGSize(width: width, height: 44)
        }
        return .zero
    }

    func sizeForItemAtIndex3(width: CGFloat) -> CGSize {
        if hasContent && hasImage {
            return CGSize(width: width, height: 65)
        }
        if hasComment {
            return CGSize(width: width, height: 44)
        }
        return .zero
    }

    // MARK: cell
    func userInfoCell(at index: Int) -> UserInfoCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "UserInfoCell", bundle: nil, for: self, at: index) as? UserInfoCell else { fatalError() }
        cell.bindViewModel(viewModels[index] as Any)
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
        cell.bindViewModel(viewModels[index] as Any)
        cell.favorOperation = {[weak self] cell in
            guard let self = self else { return }
            self.object.isFavor.toggle()
            let origin: UInt! = self.object.favor
            self.object.favor = self.object.isFavor ? (origin + 1) : (origin - 1)
            guard let favor = self.viewModels[index] as? FavorCellModel else { fatalError() }
            favor.feed = self.object
            self.collectionContext?.performBatch(animated: true, updates: { (batch) in
                batch.reload(in: self, at: IndexSet(integer: index))
            }, completion: nil)
        }
        return cell
    }

    func commentCell(at index: Int) -> CommentCell {
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

    func cellForItemAtIndex1(at index: Int) -> UICollectionViewCell {
        if hasContent {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: ContentCell.cellIdentifier, bundle: nil, for: self, at: index) as? ContentCell else { fatalError() }
            cell.bindViewModel(viewModels[index] as Any)
            return cell
        }
        if hasImage {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: ImageCollectionCell.cellIdentifier, bundle: nil, for: self, at: index) as? ImageCollectionCell else { fatalError() }
            cell.bindViewModel(viewModels[index])
            return cell
        }
        return favorCell(at: index)
    }

    func cellForItemAtIndex2(at index: Int) -> UICollectionViewCell {
        if hasContent && hasImage {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: ImageCollectionCell.cellIdentifier, bundle: nil, for: self, at: index) as? ImageCollectionCell else { fatalError() }
            cell.bindViewModel(viewModels[index])
            return cell
        }
        if hasContent || hasImage {
            return favorCell(at: index)
        }
        if hasComment {
            return commentCell(at: index)
        }
        fatalError()
    }

    func cellForItemAtIndex3(at index: Int) -> UICollectionViewCell {
        if hasContent && hasImage {
            return favorCell(at: index)
        }
        if hasComment {
            return commentCell(at: index)
        }
        fatalError()
    }

}
