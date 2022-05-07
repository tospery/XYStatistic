//
//  XYStatistic.swift
//  XYStatistic
//
//  Created by liaoya on 2022/5/6.
//

import Foundation
import Alamofire
import ObjectMapper_JX
import SwifterSwift
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
    
    public func updateProperties(_ user: XYStatsUser, _ event: XYStatsEvent) {
        guard !self.propertiesAPI.isEmpty else {
            logger.print("未设置propertiesAPI！！！")
            return
        }
        let parameters: [String: String] = [
            "cookie_id": "abc123",
            "uid": userId ?? "0"
        ]
        AF.request(
            self.propertiesAPI,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
            .validate()
            .responseDecodable(of: XYStatsResponse.self) { response in
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
        
//        {
//          "uid": "0",
//          "sign_in_status": 2,
//          "sdkType": "js",
//          "x_event_id": "my_event_id",
//          "cookie_id": "180920a8dc5ad7-0c6534ed88b76e-9771a3f-2073600-180920a8dc6a7c",
//          "windows_version": "Win10",
//          "user_browser": "chrome",
//          "title": "Document",
//          "web_url": "https://tj.xunyou.com/tj-new-sdk/demo/index.html",
//          "name": "蔡婷",
//          "x_page": "24",
//          "x_feature": "123",
//          "x_content": "50",
//          "x_action": "wechat",
//          "_": "1651825898484"
//        }
        
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
