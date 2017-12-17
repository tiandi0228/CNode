//
//  Topic.swift
//  CNode
//
//  Created by sunyuchun on 2017/11/13.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import UIKit

struct Topics: Codable {
    var list:[Topic]? = []
    
    enum CodingKeys: String, CodingKey {
        case list
    }
}

struct Author: Codable {
    
    // 头像
    var avatar_url: String = ""
    // 昵称
    var loginname: String = ""
    
    enum CodingKeys: String, CodingKey {
        case avatar_url
        case loginname
    }
}

struct Topic: Codable {
    
    // ID
    var id: String = ""
    // 作者ID
    var author_id: String = ""
    // TAB
    var tab: String = "ask"
    // 内容
    var content: String = ""
    // 标题
    var title: String = ""
    // 回复时间
    var last_reply_at: String = ""
    // 精华
    var good: Bool = false
    // 置顶
    var top: Bool = false
    // 回复数
    var reply_count: Int = 0
    // 浏览量
    var visit_count: Int = 0
    // 发帖时间
    var create_at: String = ""
    // 作者信息
    var author: Author?
    
    enum CodingKeys: String, CodingKey {
        case id
        case author_id
        case tab
        case content
        case title
        case last_reply_at
        case good
        case top
        case reply_count
        case visit_count
        case create_at
        case author
    }
}
