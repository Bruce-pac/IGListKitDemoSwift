//
//  UserInfoCellModel.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

class UserInfoCellModel {
    var avatar: URL?
    var userName: String = ""
    init(avatar: URL?, userName: String) {
        self.avatar = avatar
        self.userName = userName
    }
}

extension UserInfoCellModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return userName as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object {
            return true
        }
        guard let obj = object as? UserInfoCellModel else { return false }
        return self.userName == obj.userName
    }
}
