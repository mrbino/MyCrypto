//
//  CryptoModel.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import Foundation

class CryptoModel {
    var fullName : String
    var coinName : String
    var name : String
    var id : String
    
    init(json: [String: Any]) {
        fullName = json.tryGetString(key: "FullName") ?? ""
        coinName = json.tryGetString(key: "CoinName") ?? ""
        name = json.tryGetString(key: "Name") ?? ""
        id = json.tryGetString(key: "Id") ?? ""
    }
}
