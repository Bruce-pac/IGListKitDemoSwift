//
//  ListModel.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

typealias DecodableListDiffable = Decodable & ListDiffable

enum DataType<T: DecodableListDiffable, U: DecodableListDiffable> {
    case ad(ListModel<T>)
    case feed(ListModel<U>)
    func value() -> DecodableListDiffable {
        switch self {
        case let .ad(r):
            return r.data
        case let .feed(r):
            return r.data
        }
    }
}

extension DataType: Decodable where T: Decodable, U: Decodable {
    init(from decoder: Decoder) throws {
        if let value = try? ListModel<T>(from: decoder) {
            self = .ad(value)
        }else if let value = try? ListModel<U>(from: decoder){
            self = .feed(value)
        }else{
            let context = DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription:
                "Cannot decode \(T.self) or \(U.self)"
            )
            throw DecodingError.dataCorrupted(context)
        }
    }
}

class ListModel<T: DecodableListDiffable>: Decodable {
     var data: T!
}
