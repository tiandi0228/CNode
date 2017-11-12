//
//  Api.swift
//  CNode
//
//  Created by sunyuchun on 2017/11/12.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

typealias Success = ((Data) -> Void)
typealias Failure = ((String) -> Void)

enum RequestCode: String {
    case failError = "0"
    case success = "1"
}

enum API {
    case topics(page: Int, tab: String, limit:Int) // 主题首页
    case getTopic(id: String, mdrender: String, accesstoken: String) // 主题详情
    case postTopics(accesstoken: String, title: String, tab: String, content: String) // 新建主题
    case updateTopics(accesstoken: String, topic_id: String, title: String, tab: String, content: String) // 编辑主题
    case collect(accesstoken: String, topic_id: String) // 收藏主题
    case deCollect(accesstoken: String, topic_id: String) // 取消主题
}

extension API: TargetType {
    
    var baseURL: URL {
        return NSURL(string: Config.baseUrl)! as URL
    }
    
    var path: String {
        switch self {
        case .topics(_, _, _):
            return "/api/v1/topics"
        case .getTopic(_, _, _):
            return "/api/v1/topic/"
        case .postTopics(_, _, _, _):
            return "/api/v1/topics"
        case .updateTopics(_, _, _, _, _):
            return "/api/v1/topics/update"
        case .collect(_, _):
            return "/api/v1/topic_collect/collect"
        case .deCollect(_, _):
            return "/api/v1/topic_collect/de_collect"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topics(_, _, _), .getTopic(_, _, _):
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
