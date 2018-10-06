//
//  UserInfoCellModel.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation

class UserInfoCellModel {
    var avatar: URL?
    var userName: String = ""
    init(avatar: URL?, userName: String) {
        self.avatar = avatar
        self.userName = userName
    }
}
