//
//  SettingsContactInfoModel.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import UIKit

//MARK: - Main model
public final class SettingsContactInfo {
    var link: String?
    var linkName: String?
    
    //MARK: Initialization
    init(link: String?,
         linkName: String?) {
        self.link = link
        self.linkName = linkName
    }
}


//MARK: - UI model
public final class ACSettingsContactInfoUIModel: Identifiable {
    var content: SettingsContactInfo
    var iconName: String?
    var tintColor: UIColor?
    
    //MARK: Initialization
    init(content: SettingsContactInfo,
         iconName: String?,
         tintColor: UIColor?) {
        self.content = content
        self.iconName = iconName
        self.tintColor = tintColor
    }
}
