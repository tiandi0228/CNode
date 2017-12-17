//
//  Observable+Codable.swift
//  CNode
//
//  Created by sunyuchun on 2017/12/10.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension Response {
    /// Maps data received from the signal into a Decodable object.
    ///
    /// - parameter atKeyPath: Optional key path at which to parse object.
    /// - parameter using: A `JSONDecoder` instance which is used to decode data to an object.
    func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder()) throws -> D {
        let jsonData: Data
        if let keyPath = keyPath {
            guard let jsonDictionary = try mapJSON() as? NSDictionary else {
                throw MoyaError.jsonMapping(self)
            }
            guard let success = jsonDictionary.value(forKeyPath: "success") as? Bool else {
                throw MoyaError.jsonMapping(self)
            }
            let msg = jsonDictionary.value(forKeyPath: "error_msg") as? String ?? ""
            guard let jsonObject = jsonDictionary.value(forKeyPath: keyPath) else {
                throw NetError.bizError(resultCode: success, resultMsg: msg)
            }
            do {
                jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
            } catch {
                throw MoyaError.jsonMapping(self)
            }
        } else {
            jsonData = data
        }
        do {
            return try decoder.decode(D.self, from: jsonData)
        } catch let error {
//            print(error)
            throw MoyaError.objectMapping(error, self)
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    /// Maps received data at key path into a Decodable object. If the conversion fails, the signal errors.
    public func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder()) -> Single<D> {
        return flatMap { response -> Single<D> in
            return Single.just(try response.map(type, atKeyPath: keyPath, using: decoder))
        }
    }
}
