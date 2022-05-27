//
//  XYStatsPropertyEvent.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/6.
//

import Foundation
import ObjectMapper_JX
import SWFrame

public struct XYStatsPropertyEvent: ModelType {
    // 外部设置的属性
    var uid = "0"
    var versionId = "NA"
    var signInStatus = "NA"
    var loginMode = "NA"
    var loginChannel = "NA"
    var isVip = "NA"
    var isVipType = "NA"
    var memebershipRemainingTime = "NA"
    var accStatus = "NA"
    var accType = "NA"
    var rengionId = "NA"
    var serverId = "NA"
    var nodeId = "NA"
    var gameId = "NA"
    // 固定不变的属性
    var cookieId = UIDevice.current.uuid.nsString.qmui_md5
    var deviceId = UIDevice.current.uuid.nsString.qmui_md5
    var deviceType = "iPhone"
    var deviceVendors = "Apple"
    var deviceModel = QMUIHelper.deviceModel
    var deviceVersion = UIDevice.current.systemVersion

    public init() {
    }

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        uid                         <- map["uid"]
        cookieId                    <- map["cookie_id"]
        deviceId                    <- map["device_id"]
        deviceType                  <- map["device_type"]
        deviceVendors               <- map["device_vendors"]
        deviceModel                 <- map["device_model"]
        deviceVersion               <- map["device_version"]
        versionId                   <- map["version_id"]
        signInStatus                <- map["sign_in_status"]
        loginMode                   <- map["login_mode"]
        loginChannel                <- map["login_channel"]
        isVip                       <- map["is_vip"]
        isVipType                   <- map["is_vip_type"]
        memebershipRemainingTime    <- map["memebership_remaining_time"]
        accStatus                   <- map["acc_status"]
        accType                     <- map["acc_type"]
        rengionId                   <- map["rengion_id"]
        serverId                    <- map["server_id"]
        nodeId                      <- map["node_id"]
        gameId                      <- map["game_id"]
    }

}
