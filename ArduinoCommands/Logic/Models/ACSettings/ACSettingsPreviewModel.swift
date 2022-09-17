//
//  SettingsPreviewModel.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation

//MARK: - Main model
public final class ACSettingsPreviewModel: Identifiable {
    var title: String?
    var iconName: String?
    
    //MARK: Initialization
    init(title: String?,
         iconName: String?) {
        self.title = title
        self.iconName = iconName
    }
}
