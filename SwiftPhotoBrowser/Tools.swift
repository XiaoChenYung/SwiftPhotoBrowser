//
//  Tools.swift
//  SwiftPhotoBrowser
//
//  Created by tm on 2017/9/25.
//  Copyright © 2017年 tm. All rights reserved.
//

import Foundation

public enum Device {
    
    @discardableResult
    public static func iOS_9_1_Later() -> Bool {
        let _v = UIDevice.current.systemVersion
        return Float(_v)! >= Float(9.1)
    }
    
    @discardableResult
    public static func iPhone6s_Later() -> Bool {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        if identifier == "x86_64" {
            return false
        }
        let systemStringNumber = identifier[identifier.index(identifier.startIndex, offsetBy: 6)..<identifier.index(identifier.startIndex, offsetBy: 7)]
        
        if identifier.hasPrefix("iPhone") && Int(systemStringNumber)! > 7 {
            return true
        }
        return false
    }
}
