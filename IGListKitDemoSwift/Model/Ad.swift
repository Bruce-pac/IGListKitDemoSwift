//
//  Ad.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

class Ad: Codable {
    var adTitle: String = ""
    var adUrl: String = ""
}

extension Ad: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return adTitle as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Ad else { return false }
        return adTitle == object.adTitle
    }
}
