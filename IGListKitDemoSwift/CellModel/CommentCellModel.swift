//
//  CommentCellModel.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class CommentCellModel: NSObject {
    private(set) var commentStr: NSAttributedString!

    var comment: Comment! {
        didSet {
            let str: String = comment.person + "回复了:" + comment.comment
            let attr: NSMutableAttributedString = NSMutableAttributedString(string: str)
            let nsrange = NSRange(location: 0, length: comment.person.count)
            attr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], range: nsrange)
            commentStr = attr
        }
    }
}

extension CommentCellModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object {
            return true
        }
        guard let obj = object as? CommentCellModel else { return false }
        return self.commentStr == obj.commentStr
    }
}
