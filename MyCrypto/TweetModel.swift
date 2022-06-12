//
//  TweetModel.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/10.
//

import Foundation

class TweetModel {
    var tweet : String
    var date : String
    var user : TwitterUserModel
    
    init(json: [String: Any]) {
        tweet = json.tryGetString(key: "text") ?? ""
        date = json.tryGetString(key: "created_at") ?? ""
        user = TwitterUserModel(json: json.tryGetJson(key: "user") ?? [:])
    }
}
