//
//  SettingsContentStorage.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import UIKit

//MARK: - Settings content Storage
public enum ACSettingsStorage {
    
    //MARK: Static
    static var title = "Settings"
    
    
    //MARK: Public
    enum PreviewSection {
        
        //MARK: Static
        static let header = "Preview"
        static let footer = "You can learn the latest Arduino Commands features by viewing by viewing Application Intro."
        static let content: [ACSettingsPreviewModel] = [
            ACSettingsPreviewModel(
                title: "Show Intro",
                iconName: "eyes"
            )
        ]
    }
    enum BasicInfoSection {
        
        //MARK: Static
        static let header =  "About App"
        static let footer = "Basic information about the Application from the App Store."
        static let content: [ACSettingsBasicInfoModel] = [
            ACSettingsBasicInfoModel(
                parameter: "Version",
                value: "1.0.0"
            ),
            ACSettingsBasicInfoModel(
                parameter: "Category",
                value: "Education"
            ),
            ACSettingsBasicInfoModel(
                parameter: "Age Category",
                value: "+12"
            ),
            ACSettingsBasicInfoModel(
                parameter: "Language",
                value: "English"
            ),
            ACSettingsBasicInfoModel(
                parameter: "Compatibility",
                value: "iPhone"
            ),
            ACSettingsBasicInfoModel(
                parameter: "Designed",
                value: "by Trach Yarsolav"
            )
        ]
    }
    enum ToggleParametersSection {
        
        //MARK: Static
        static let header = "Parameters"
        static let content: [ACSettingsToggleParameterCellModel] = [
            ACSettingsToggleParameterCellModel(
                content: ACSettingsToggleParameterModel(
                    parameterName: "Allow Notifications",
                    parameterValue: true
                ),
                iconName: "app.badge",
                tintColor: .systemPurple
            ),
            ACSettingsToggleParameterCellModel(
                content: ACSettingsToggleParameterModel(
                    parameterName: "Show Ads",
                    parameterValue: true
                ),
                iconName: "a.square.fill",
                tintColor: .systemGreen
            )
        ]
    }
    enum ContactInfoSection {
        
        //MARK: Static
        static let header = "Contact Info"
        static let footer = "View different Arduino Commands resources, which can help you to learn some more about the App or get a needed help."
        static let content: [ACSettingsContactInfoCellModel] = [
            ACSettingsContactInfoCellModel(
                content: ACSettingsContactInfoModel(
                    link: "https://yaroslavtrachigor.github.io/ArduinoCommandsInfo",
                    linkName: "Website"
                ),
                iconName: "globe",
                tintColor: .systemTeal
            ),
            ACSettingsContactInfoCellModel(
                content: ACSettingsContactInfoModel(
                    link: "https://www.instagram.com/axcigrpvicj/",
                    linkName: "Instagram"
                ),
                iconName: "link",
                tintColor: .systemPink
            ),
            ACSettingsContactInfoCellModel(
                content: ACSettingsContactInfoModel(
                    link: "https://yaroslavtrachigor.github.io/ArduinoCommandsInfo",
                    linkName: "Privacy Policy"
                ),
                iconName: "lock.fill",
                tintColor: .systemIndigo
            )
        ]
    }
}
