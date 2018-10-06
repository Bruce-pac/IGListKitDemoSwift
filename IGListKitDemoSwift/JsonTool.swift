//
//  JsonTool.swift
//  JsonTest
//
//  Created by gxy on 2018/7/29.
//  Copyright © 2018年 Dinghaotech. All rights reserved.
//

import Foundation

class JsonTool {
    open class func decode<T>(_: T.Type, jsonfileName json: String, from bundle: Bundle! = Bundle.main) throws -> T where T: Decodable {
        let url = bundle.url(forResource: json, withExtension: "json")
        var data = Data()
        if let gUrl = url { data = try Data(contentsOf: gUrl) }
        let decode = JSONDecoder()
        let items = try decode.decode(T.self, from: data)
        return items
    }
}
