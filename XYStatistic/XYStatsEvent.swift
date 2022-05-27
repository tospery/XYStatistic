//
//  XYStatsEvent.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/27.
//

import Foundation

public enum XYStatsEvent {
    case appStart
    case userLogin
    
    public var properties: [String: String] {
        switch self {
        case .appStart: return [
            "x_event_id": "r_start",
            "x_page": "NA",
            "x_source": "NA",
            "x_feature": "success",
            "x_content": "NA",
            "x_action": "NA"
        ]
        case .userLogin: return [
            "x_event_id": "r_login",
            "x_page": "NA",
            "x_source": "NA",
            "x_feature": "success",
            "x_content": "NA",
            "x_action": "NA"
        ]
        }
    }
    
}
