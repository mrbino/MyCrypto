//
//  TwitterUserModel.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/11.
//

import Foundation

class TwitterUserModel {
    var name : String
    var screen_name : String
    var avatar : String
    
    init(json: [String: Any]) {
        name = json.tryGetString(key: "name") ?? ""
        screen_name = json.tryGetString(key: "screen_name") ?? ""
        avatar = json.tryGetString(key: "profile_image_url_https") ?? ""
    }
}
