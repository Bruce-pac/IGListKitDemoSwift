//
//  Comment.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation

class Comment: Codable {
    var comment: String = ""
    var person: String = ""
}

extension Comment: Equatable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return (lhs.comment == rhs.comment) && (lhs.person == rhs.person)
    }
}
