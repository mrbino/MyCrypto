//
//  JSON+Extension.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/09.
//

import Foundation

extension Dictionary where Key == String {
    func tryGetString(key: String) -> String? {
        if let value = self[key] as? String {
            return value
        } else {
            return nil
        }
    }
    
    func tryGetDouble(key: String) -> Double? {
        if let value = self[key] as? String {
            return Double(value)
        } else if let value = self[key] as? Int {
            return Double(value)
        } else if let value = self[key] as? Float {
            return Double(value)
        } else if let value = self[key] as? Double {
            return value
        } else {
            return nil
        }
    }
    
    func tryGetJson(key: String) -> [String:Any]? {
        if let value = self[key] as? [String:Any] {
            return value
        } else {
            return nil
        }
    }
    
    func tryGetJsonArray(key: String) -> [[String:Any]]? {
        if let value = self[key] as? [[String:Any]] {
            return value
        } else {
            return nil
        }
    }

}
