//
//  XYStatsEvent.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/6.
//

import Foundation
import ObjectMapper_JX
import SWFrame

public struct XYStatsEvent: ModelType {

    var code = 0
    var message: String?

    public init() {
    }

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        code       <- map["code"]
        message    <- map["message"]
    }

}
