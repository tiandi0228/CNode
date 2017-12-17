//
//  NSDate+Extension.swift
//  CNode
//
//  Created by sunyuchun on 2017/12/15.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import Foundation
import SwiftDate

extension String {
    
    // 时间格式化
    func currentDateIntoString() -> String {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date1  = formatter.date(from: "\(self)")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let resultTime = formatter.string(from: date1!)
        return String(describing: resultTime)
    }
    
    func fromNow() -> String {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let ONE_MINUTE = 60.0
        let ONE_HOUR = 60 * ONE_MINUTE
        let ONE_DAY = 24 * ONE_HOUR
        let ONE_MONTH = 30 * ONE_DAY
        let date1  = formatter.date(from: "\(self)")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let resultTime = formatter.string(from: date1!)
        print(resultTime)
        return resultTime
    }
}
