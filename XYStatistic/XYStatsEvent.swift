//
//  XYStatsEvent.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/27.
//

import Foundation
import SwifterSwift

public enum XYStatsEvent {
    case appStart
    case userLogin(feature: NormalFeature, content: String)
    case userRegister(feature: NormalFeature, content: String)
    case pluginAccelerate(feature: NormalFeature, content: String)
    case pluginUpdate(feature: NormalFeature, content: String)
    case pluginBind(feature: NormalFeature, content: String, mac: String)
    case pluginUnbind(feature: NormalFeature, content: String, mac: String)
    case phoneAccelerate(page: phoneAcceleratePage, feature: NormalFeature, content: String)
    case payClick
    case paySuccess(productId: String, price: String)
    case payFail(productId: String, price: String)
    
    public var properties: [String: Any] {
        var parameters: [String: Any] = [
            "x_page": "N/A",
            "x_source": "N/A",
            "x_feature": "N/A",
            "x_content": "N/A",
            "x_action": "N/A"
        ]
        switch self {
        case .appStart:
            parameters += [
                "x_event_id": "r_start",
                "x_feature": "success"
            ]
        case let .userLogin(feature, content):
            parameters += [
                "x_event_id": "r_login",
                "x_feature": feature.rawValue,
                "x_content": content
            ]
        case let .userRegister(feature, content):
            parameters += [
                "x_event_id": "r_sign_up",
                "x_feature": feature.rawValue,
                "x_content": content
            ]
        case let .pluginAccelerate(feature, content):
            parameters += [
                "x_event_id": "r_router_acc",
                "x_source": "iosapp",
                "x_feature": feature.rawValue,
                "x_content": content
            ]
        case let .pluginUpdate(feature, content):
            parameters += [
                "x_event_id": "r_update",
                "x_feature": feature.rawValue,
                "x_content": content
            ]
        case let .pluginBind(feature, content, mac):
            parameters += [
                "x_event_id": "r_bind",
                "x_feature": feature.rawValue,
                "x_content": content,
                "x_action": mac
            ]
        case let .pluginUnbind(feature, content, mac):
            parameters += [
                "x_event_id": "r_unbind",
                "x_feature": feature.rawValue,
                "x_content": content,
                "x_action": mac
            ]
        case let .phoneAccelerate(page, feature, content):
            parameters += [
                "x_event_id": "r_mobile_acc",
                "x_page": page.rawValue,
                "x_source": "iosapp",
                "x_feature": feature.rawValue,
                "x_content": content
            ]
        case .payClick:
            parameters += [
                "x_event_id": "r_pay_click"
            ]
        case let .paySuccess(productId, price):
            parameters += [
                "x_event_id": "r_pay_success",
                "x_feature": "applepay",
                "x_content": productId,
                "x_action": price
            ]
        case let .payFail(productId, price):
            parameters += [
                "x_event_id": "r_pay_fail",
                "x_feature": "applepay",
                "x_content": productId,
                "x_action": price
            ]
        }
        return parameters
    }
    
    public enum NormalFeature: String {
        case success
        case fail
    }
    
    public enum phoneAcceleratePage: String {
        case wifi = "wifi_acc"
        case hotspot = "hotspot_acc"
    }
    
}
