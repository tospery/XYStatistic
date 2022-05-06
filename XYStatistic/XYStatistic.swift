//
//  XYStatistic.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/6.
//

import Foundation
import Alamofire
import ObjectMapper_JX
import SWFrame

final public class XYStatistic {
    
    var propertiesAPI = ""
    var eventAPI = ""
    public static let shared = XYStatistic()
    
    public init() {
    }
    
    public func setup(propertiesAPI: String, eventAPI: String) {
        self.propertiesAPI = propertiesAPI
        self.eventAPI = eventAPI
    }
    
    public func updateProperties(with userId: String? = nil) {
        guard !self.propertiesAPI.isEmpty else {
            logger.print("未设置propertiesAPI！！！")
            return
        }
        let parameters: [String: String] = [
            "cookieID": "abc123",
            "uid": userId ?? "0"
        ]
        AF.request(
            self.propertiesAPI,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
            .validate()
            .responseDecodable(of: XYResponse.self) { response in
                switch response.result {
                case let .success(xy):
                    if xy.code != 0 {
                        logger.print("上报错误: \(xy.message ?? "")")
                    }
                case let .failure(error):
                    logger.print("发生错误: \(error)")
                }
            }
    }
    
    public func trackEvent(_ eventId: String, _ customInfo: [String: String]? = nil) {
        guard !self.eventAPI.isEmpty else {
            logger.print("未设置eventAPI！！！")
            return
        }
//        let parameters: [String: Any] = [
//            "eventId": eventId,
//            "customInfo": customInfo ?? [String: String].init()
//        ]
//        AF.request(
//            self.eventAPI,
//            method: .post,
//            parameters: parameters,
//            encoder: JSONParameterEncoder.default
//        )
//            .validate()
//            .responseDecodable(of: XYResponse.self) { response in
//                switch response.result {
//                case let .success(xy):
//                    if xy.code != 0 {
//                        logger.print("上报错误: \(xy.message ?? "")")
//                    }
//                case let .failure(error):
//                    logger.print("发生错误: \(error)")
//                }
//            }
    }
    
}
