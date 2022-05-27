//
//  XYStatistic.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/6.
//

import Foundation
import ObjectMapper_JX
import SwifterSwift
import SWFrame
import Alamofire

final public class XYStatistic {
    
    var propertyAPI = ""
    var eventAPI = ""
    var user = XYStatsPropertyUser.init()
    var event = XYStatsPropertyEvent.init()
    public static let shared = XYStatistic()
    
    public init() {
    }
    
    public func initialize(propertyAPI: String, eventAPI: String) {
        self.propertyAPI = propertyAPI
        self.eventAPI = eventAPI
    }
    
    public func update(user: XYStatsPropertyUser) {
        guard !self.propertyAPI.isEmpty else {
            logger.print("未设置propertyAPI！！！", module: .statistic)
            return
        }
        self.user = user
        let parameters = user.toJSON().mapValues { String(describing:$0) }
        AF.request(
            self.propertyAPI,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
            .validate()
            .responseDecodable(of: XYStatsResponse.self) { response in
                switch response.result {
                case let .success(xy):
                    if xy.code != 0 {
                        logger.print("上报错误（update）: \(xy.message ?? "")", module: .statistic)
                    }
                case let .failure(error):
                    logger.print("发生错误（update）: \(error)", module: .statistic)
                }
            }
    }
    
    public func update(event: XYStatsPropertyEvent) {
        self.event = event
    }
    
    public func trackEvent(_ event: XYStatsEvent, _ customInfo: [String: String]? = nil) {
        guard !self.eventAPI.isEmpty else {
            logger.print("未设置eventAPI！！！")
            return
        }
        var parameters = event.properties
        parameters += self.event.toJSON().mapValues { String(describing:$0) }
        if let customInfo = customInfo {
            parameters += customInfo
        }
        
        AF.request(
            self.eventAPI,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
            .validate()
            .responseDecodable(of: XYStatsResponse.self) { response in
                switch response.result {
                case let .success(xy):
                    if xy.code != 0 {
                        logger.print("上报错误（trackEvent）: \(xy.message ?? "")", module: .statistic)
                    }
                case let .failure(error):
                    logger.print("发生错误（trackEvent）: \(error)", module: .statistic)
                }
            }
    }
    
}
