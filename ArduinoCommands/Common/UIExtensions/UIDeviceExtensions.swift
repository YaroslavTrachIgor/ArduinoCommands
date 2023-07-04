//
//  UIDeviceExtensions.swift
//  ArduinoCommands
//
//  Created by User on 2023-04-08.
//

import Foundation
import UIKit

//MARK: - Device names
enum DeviceDiagonalName {
    case iPod
    case iPhone14
    case iPhone14Pro
    case iPhone14ProMax
    case iPhone14Plus
    case iPhoneMini
    case iPhoneX
    case iPhoneXSMax
    case iPhoneXR
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneSimulator
    case undefined
}


//MARK: - Fast Device methods
extension UIDevice {
    
    //MARK: Static
    static var diagonalModelName: DeviceDiagonalName? {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machine = systemInfo.machine
        let machineMirror = Mirror(reflecting: machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            let elementCode = String(UnicodeScalar(UInt8(value)))
            return identifier + elementCode
        }
        /**
         After the code name of user's iOS Device was received,
         we combine the devices with different names but the same diagonal,
         and transform them into the cases from `DeviceDiagonalName` enumaration.
         
         This will be used to analyze what properties values do we need to set for particular UI elements in VC's,
         since some of the UIKit components, like UIToolBar, don't see the difference between old and new iPhones.
         */
        switch identifier {
        case "i386", "x86_64", "arm64"                                          : return .iPhoneSimulator
        case "iPod1,1", "iPod2,1", "iPod3,1", "iPod5,1", "iPod7,1", "iPod9,1"   : return .iPod
        case "iPhone12,1", "iPhone13,2", "iPhone14,7", "iPhone14,5"             : return .iPhone14
        case "iPhone15,2", "iPhone12,3", "iPhone14,2", "iPhone13,3"             : return .iPhone14Pro
        case "iPhone12,5", "iPhone15,3", "iPhone13,4", "iPhone14,3"             : return .iPhone14ProMax
        case "iPhone10,6", "iPhone11,2", "iPhone10,3"                           : return .iPhoneX
        case "iPhone11,4", "iPhone11,6"                                         : return .iPhoneXSMax
        case "iPhone13,1", "iPhone14,4"                                         : return .iPhoneMini
        case "iPhone12,8", "iPhone14,6"                                         : return .iPhoneSE
        case "iPhone10,5", "iPhone10,2"                                         : return .iPhone8Plus
        case "iPhone10,4", "iPhone10,1"                                         : return .iPhone8
        case "iPhone14,8"                                                       : return .iPhone14Plus
        case "iPhone11,8"                                                       : return .iPhoneXR
        default                                                                 : return .undefined
        }
    }
}
