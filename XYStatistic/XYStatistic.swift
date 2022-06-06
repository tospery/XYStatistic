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
    var datas = [[String : Any]].init()
    let queue = OperationQueue()
    let lock = NSLock.init()
    public static let shared = XYStatistic()
    
    public init() {
        self.queue.maxConcurrentOperationCount = 1
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
        
        self.queue.addOperation {
            self.lock.lock()
            logger.print("update线程: \(Thread.current)开始", module: .statistic)
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
                logger.print("update线程: \(Thread.current)结束", module: .statistic)
                self.lock.unlock()
            }
        }
    }
    
    public func update(event: XYStatsPropertyEvent) {
        self.event = event
    }
     
    public func trackEvent(_ event: XYStatsEvent) {
        guard !self.eventAPI.isEmpty else {
            logger.print("未设置eventAPI！！！", module: .statistic)
            return
        }
        var parameters = event.properties
        parameters += self.event.toJSON()
        
        self.queue.addOperation {
            self.lock.lock()
            logger.print("trackEvent线程: \(Thread.current)开始", module: .statistic)
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
                logger.print("trackEvent线程: \(Thread.current)结束", module: .statistic)
                self.lock.unlock()
            }
        }
    }
    
}
