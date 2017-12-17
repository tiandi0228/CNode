//
//  Api.swift
//  CNode
//
//  Created by sunyuchun on 2017/11/12.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import Foundation
import Moya

let Api = MoyaProvider<API>().rx

enum API {
    case topics(page: Int?, tab: String?, limit:Int?) // 主题首页
    case getTopic(id: String, mdrender: String?, accesstoken: String?) // 主题详情
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
            return "/api/v1/topic"
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
    
    var parameters: [String: Any]? {
        switch self {
        case .topics(let page, let tab, let limit):
            return ["page":page ?? 1, "tab":tab ?? "all", "limit":limit ?? 10]
        case .getTopic(let id, let mdrender, let accesstoken):
            return ["id": id, "mdrender":mdrender ?? "", "accesstoken":accesstoken ?? ""]
        case .postTopics(let accesstoken, let title, let tab, let content):
            return ["accesstoken":accesstoken, "title":title, "tab":tab, "content":content]
        case .updateTopics(let accesstoken, let topic_id, let title, let tab, let content):
            return ["accesstoken":accesstoken, "topic_id":topic_id, "title":title, "tab":tab, "content":content]
        case .collect(let accesstoken, let topic_id):
            return ["accesstoken":accesstoken, "topic_id":topic_id]
        case .deCollect(let accesstoken, let topic_id):
            return ["accesstoken":accesstoken, "topic_id":topic_id]
        }
    }
    
    var sampleData: Data {
        return "{}".utf8Encoded
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default // Send parameters as JSON in request body
    }
    
    var task: Task {
        switch self {
        case .topics(let page, let tab, let limit):
            var params: [String: Any] = [:]
            params["limit"] = limit
            params["page"] = page
            params["tab"] = tab
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getTopic(let id, let mdrender, let accesstoken):
            var params: [String: Any] = [:]
            params["id"] = id
            params["mdrender"] = mdrender
            params["accesstoken"] = accesstoken
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var validate: Bool {
        return false
    }
    
    var headers: [String : String]? {
        return nil
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
