//
//  XYStatsPropertyUser.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/6.
//

import Foundation
import ObjectMapper_JX
import SWFrame
import QMUIKit

public struct XYStatsPropertyUser: ModelType, Codable {

    // 外部设置的属性
    public var id = "0"
    public var promotionId = ""
    public var spId = ""
    // 固定不变的属性
    var winType = 0
    var cookieId = UIDevice.current.uuid.nsString.qmui_md5

    public init() {
    }

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        id              <- map["uid"]
        winType         <- map["win_type"]
        cookieId        <- map["cookie_id"]
        promotionId     <- map["promotion_id"]
        spId            <- map["sp_id"]
    }

}
