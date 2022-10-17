//
//  UIColorExtensions.swift
//  ArduinoCommands
//
//  Created by User on 25.06.2022.
//

import Foundation
import UIKit

//MARK: - Costom Colors
public extension UIColor {
    
    //MARK: Public
    enum ACDetails {
        
        //MARK: Static
        public static var backgroundColor: UIColor {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        public static var secondaryBackgroundColor: UIColor {
            return #colorLiteral(red: 0.07412604243, green: 0.07412604243, blue: 0.07412604243, alpha: 1)
        }
        public static var tintColor: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    enum ACTable {
        
        //MARK: Static
        public static var backgroundColor: UIColor {
            return .systemGroupedBackground
        }
        public static var cellBackgroundColor: UIColor {
            return .tertiarySystemBackground.withAlphaComponent(0.55)
        }
    }
    enum ACShadow {
        
        //MARK: Static
        public static let neuLightShadowColor = UIColor(named: "NeuLightShadowColor")!
        public static let neuDarkShadowColor = UIColor(named: "NeuDarkShadowColor")!
    }
}


//MARK: - Fast Theme adaptable Color initialization
public extension UIColor {

    //MARK: Public
    /// Creates a color object that generates its color data dynamically using the specified colors. For early SDKs creates light color.
    /// - Parameters:
    ///   - light: The color for light mode.
    ///   - dark: The color for dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
}


//MARK: - Fast hex Color transformation initialization
public extension UIColor {
    
    //MARK: Public
    /// In the code below, we create a special formatter that will allow us to convert text to color.
    /// Some parameters(for instance, `scanLocation`) have been removed in new versions of iOS,
    /// so in the future you will need to find a replacement for them.
    ///
    /// This initialization will typically be used to format JSON content.
    /// - Parameters:
    ///   - hexString: hex color code.
    ///   - alpha: color opacity.
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let set              = CharacterSet.whitespacesAndNewlines
        let hexString        = hexString.trimmingCharacters(in: set)
        let scanner          = Scanner(string: hexString)
        var color: UInt32    = 0
        scanner.scanLocation = 1
        scanner.scanHexInt32(&color)
        let maxValue         = 255.0
        let mask             = 0x000000FF
        let rInt             = Int(color >> 16) & mask
        let gInt             = Int(color >> 8) & mask
        let bInt             = Int(color) & mask
        let red              = CGFloat(rInt) / maxValue
        let blue             = CGFloat(bInt) / maxValue
        let green            = CGFloat(gInt) / maxValue
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


//MARK: - Fast Color helpful properties for saving to defaults setup extension
public extension UIColor {
    
    //MARK: Public
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        return getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        ? (red, green, blue, alpha) : nil
    }
    var data: Data? {
        guard let rgba = rgba else { return nil }
        let redData      = rgba.red.data
        let greenData    = rgba.green.data
        let blueData     = rgba.blue.data
        let alphaData    = rgba.alpha.data
        return redData + greenData + blueData + alphaData
    }
    
    
    //MARK: Initialization
    /// This configures color value from `Data` type
    /// and will be used in Data extension to convert values to `UIColor` type.
    /// - Parameter data: color code.
    convenience init(data: Data) {
        let size = MemoryLayout<CGFloat>.size
        self.init(red:   data.subdata(in: size*0..<size*1).object(),
                  green: data.subdata(in: size*1..<size*2).object(),
                  blue:  data.subdata(in: size*2..<size*3).object(),
                  alpha: data.subdata(in: size*3..<size*4).object())
    }
}
