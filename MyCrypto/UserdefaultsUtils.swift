//
//  UserdefaultsUtils.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import Foundation

enum DefaultName: String {
    case didShowInitialWelcomeScreen = "did_show_initial_welcome_screen"
}

class UserdefaultsUtils {
    static func set(_ value: Any, forKey defaultName: DefaultName) {
        UserDefaults.standard.set(value, forKey: defaultName.rawValue)
    }
    
    static func bool(forKey defaultName: DefaultName) -> Bool {
        return UserDefaults.standard.bool(forKey: defaultName.rawValue)
    }
}
