//
//  NetError.swift
//  CNode
//
//  Created by sunyuchun on 2017/12/10.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import Foundation

import UIKit
import Moya

enum NetError: Swift.Error {
    case sessionError(resultCode: Bool?, resultMsg: String?)
    case jsonMappingError
    case noNeedHandleError
    case bizError(resultCode: Bool?, resultMsg: String?)
}

extension NetError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .sessionError(_, let resultMsg):
            return resultMsg
        case .jsonMappingError:
            return "服务端返回对象解析错误"
        case .noNeedHandleError:
            return nil
        case .bizError(_, let resultMsg):
            return resultMsg
        }
    }
}
