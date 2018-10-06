//
//  Feed.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

final class Feed: Codable {
    var feedId: UInt
    var avatar: String = ""
    var userName: String = ""
    var content: String? = ""
    var isFavor: Bool! = false
    var favor: UInt!
    var images: [String]! = []
    var comments: [Comment]?

}

extension Feed: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return feedId as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Feed else { return false }
        return feedId == object.feedId
    }
}
