//
//  UserDefaultsExtensions.swift
//  ArduinoCommands
//
//  Created by User on 09.09.2022.
//

import Foundation
import UIKit

//MARK: - Fast methods for Color type values save and get
public extension UserDefaults {
    
    //MARK: Public
    /// This saves value of type `UIColor` for a particular key from `UserDefaults` storage.
    /// - Parameters:
    ///   - color: new color;
    ///   - defaultName: key to a particular property.
    func set(_ color: UIColor?, forKey defaultName: String) {
        guard let data = color?.data else {
            removeObject(forKey: defaultName)
            return
        }
        set(data, forKey: defaultName)
    }
    
    /// This gets value of type `UIColor` for a particular key from `UserDefaults` storage.
    /// - Parameter defaultName: key to a particular property;
    /// - Returns: color type value from defaults storage.
    func color(forKey defaultName: String) -> UIColor? {
        data(forKey: defaultName)?.color
    }
}
