//
//  Html+Extension.swift
//  CNode
//
//  Created by sunyuchun on 2017/12/15.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import Foundation

extension String {
    var replacingHTMLEntities: String? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil).string
        } catch {
            return nil
        }
    }
}
