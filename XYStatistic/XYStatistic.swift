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
        let parameters = user.toJSON()
        
        AF.request(
            self.propertyAPI,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable(of: XYStatsResponse.self) { response in
            switch response.result {
            case let .success(xy):
                if xy.code != 0 {
                    logger.print("上报失败（user）: \(xy.message ?? "")", module: .statistic)
                } else {
                    logger.print(parameters.jsonString() ?? "", module: .statistic)
                }
            case let .failure(error):
                logger.print("上报错误（user）: \(error)", module: .statistic)
            }
        }
    }
    
    public func update(event: XYStatsPropertyEvent) {
        self.event = event
    }
     
    public func trackEvent(_ event: XYStatsEvent, _ customInfo: [String: Any]? = nil) {
        guard !self.eventAPI.isEmpty else {
            logger.print("未设置eventAPI！！！", module: .statistic)
            return
        }
        var parameters = event.properties
        parameters += self.event.toJSON()
        if let customInfo = customInfo {
            parameters += customInfo
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            AF.request(
                self.eventAPI,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default
            )
            .validate()
            .responseDecodable(of: XYStatsResponse.self) { response in
                switch response.result {
                case let .success(xy):
                    if xy.code != 0 {
                        logger.print("上报失败（event）: \(xy.message ?? "")", module: .statistic)
                    } else {
                        logger.print(parameters.jsonString() ?? "", module: .statistic)
                    }
                case let .failure(error):
                    logger.print("上报错误（event）: \(error)", module: .statistic)
                }
            }
        }
    }
    
}
