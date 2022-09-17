//
//  SettingsToggleParameterModel.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import UIKit

//MARK: - Main Model
public final class ACSettingsToggleParameterModel {
    let parameterName: String?
    let parameterValue: Bool?
    
    //MARK: Initialization
    init(parameterName: String?,
         parameterValue: Bool?) {
        self.parameterName = parameterName
        self.parameterValue = parameterValue
    }
}


//MARK: - Cell model
public final class ACSettingsToggleParameterCellModel: Identifiable {
    let content: ACSettingsToggleParameterModel
    let iconName: String?
    let tintColor: UIColor?
    
    //MARK: Initialization
    init(content: ACSettingsToggleParameterModel,
         iconName: String?,
         tintColor: UIColor?) {
        self.content = content
        self.iconName = iconName
        self.tintColor = tintColor
    }
}
