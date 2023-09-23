//
//  SettingsPersonalParameter.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-11.
//

import Foundation
import UIKit

//MARK: - Main model
public final class SettingsPersonalParameter: Identifiable {
    let title: String
    let subtitle: String?
    let iconName: String
    let tintColor: UIColor
    
    //MARK: Initialization
    init(title: String,
         subtitle: String?,
         iconName: String,
         tintColor: UIColor) {
        self.title = title
        self.subtitle = subtitle
        self.iconName = iconName
        self.tintColor = tintColor
    }
}
