//
//  UIStoryboard+Extension.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import UIKit

fileprivate let _main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

extension UIStoryboard {
    
    static var main: UIStoryboard {
        get {
            return _main
        }
    }
}
