//
//  SettingsToggleParameterModel.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI
import UIKit

//MARK: - Main model
public final class ACSettingsParameter {
    let name: String?
    var value: Bool?
    
    //MARK: Initialization
    init(name: String?,
         value: Bool?) {
        self.value = value
        self.name = name
    }
}


//MARK: - UI model
public final class ACSettingsParameterUIModel: Identifiable {
    var content: ACSettingsParameter
    let iconName: String?
    let tintColor: UIColor?
    let isEnabled: Bool?
    
    //MARK: Initialization
    init(content: ACSettingsParameter,
         iconName: String?,
         tintColor: UIColor?,
         isEnabled: Bool?) {
        self.content = content
        self.iconName = iconName
        self.tintColor = tintColor
        self.isEnabled = isEnabled
    }
}
