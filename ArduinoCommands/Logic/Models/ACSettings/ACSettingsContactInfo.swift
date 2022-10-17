//
//  SettingsContactInfoModel.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import UIKit

//MARK: - Main model
public final class ACSettingsContactInfo {
    var link: String?
    var linkName: String?
    
    //MARK: Initialization
    init(link: String?,
         linkName: String?) {
        self.link = link
        self.linkName = linkName
    }
}


//MARK: - Cell model
public final class ACSettingsContactInfoCell: Identifiable {
    var content: ACSettingsContactInfo
    var iconName: String?
    var tintColor: UIColor?
    
    //MARK: Initialization
    init(content: ACSettingsContactInfo,
         iconName: String?,
         tintColor: UIColor?) {
        self.content = content
        self.iconName = iconName
        self.tintColor = tintColor
    }
}
