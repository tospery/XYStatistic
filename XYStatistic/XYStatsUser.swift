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

    var uid = "0"
    var winType = 4

    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        uid         <- map["uid"]
        winType     <- map["win_type"]
    }

}
