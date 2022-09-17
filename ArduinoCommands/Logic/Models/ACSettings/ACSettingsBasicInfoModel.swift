//
//  SettingsBasicInfoModel.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation

//MARK: - Main model
public final class ACSettingsBasicInfoModel: Identifiable {
    var parameter: String?
    var value: String?
    
    //MARK: Initialization
    init(parameter: String?,
         value: String?) {
        self.parameter = parameter
        self.value = value
    }
}
