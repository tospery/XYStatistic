//
//  XYStatsUser.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/6.
//

import Foundation
import ObjectMapper_JX
import SWFrame

public struct XYStatsUser: ModelType {

    var id = "0"
    var winType = 4

    public init() {
    }

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        id          <- map["uid"]
        winType     <- map["win_type"]
    }

}
