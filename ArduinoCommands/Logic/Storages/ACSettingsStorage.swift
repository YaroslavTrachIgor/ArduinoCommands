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
    
    //MARK: Public
    enum PreviewSection {
        
        //MARK: Static
        static let header = "Preview"
        static let footer = "In this section, you can learn the latest Arduino Commands features by viewing App Intro."
        static let content: [ACSettingsPreview] = [
            ACSettingsPreview(
                title: "Show Intro",
                iconName: "eyes"
            )
        ]
    }
    enum BasicInfoSection {
        
        //MARK: Static
        static let header = "About App"
        static let footer = "In this section, you can view the basic information about the App, which also exists on App Store."
        static let content: [ACSettingsBasicInfo] = [
            ACSettingsBasicInfo(
                parameter: "Version",
                value: "1.3.0"
            ),
            ACSettingsBasicInfo(
                parameter: "Category",
                value: "Education"
            ),
            ACSettingsBasicInfo(
                parameter: "Age Category",
                value: "+12"
            ),
            ACSettingsBasicInfo(
                parameter: "Language",
                value: "English"
            ),
            ACSettingsBasicInfo(
                parameter: "Compatibility",
                value: "iPhone"
            ),
            ACSettingsBasicInfo(
                parameter: "Designed",
                value: "by Trach Yarsolav"
            )
        ]
    }
    enum ContactInfoSection {
        
        //MARK: Static
        static let header = "Contact Info"
        static let footer = "View different Arduino Commands resouces, which can help you to learn some more about the App or get the needed help."
        static let content: [ACSettingsContactInfoUIModel] = [
            ACSettingsContactInfoUIModel(
                content: ACSettingsContactInfo(
                    link: "https://www.instagram.com/axcigrpvicj/",
                    linkName: "Instagram"
                ),
                iconName: "link",
                tintColor: .systemPink
            ),
            ACSettingsContactInfoUIModel(
                content: ACSettingsContactInfo(
                    link: "https://yaroslavtrachigor.github.io/ArduinoCommandsInfo",
                    linkName: "Privacy Policy"
                ),
                iconName: "lock.fill",
                tintColor: .systemIndigo
            )
        ]
    }
    enum ParametersSection {
        
        //MARK: Static
        static let header = "Parameters"
        static let footer = "In this section, you can lock all the unnecessary and unlock the needed features of Arduino Commands."
        static let allowsNotificationsCell = ACSettingsParameterUIModel(
            content: ACSettingsParameter(
                name: "Allow Notifications",
                value: ACSettingsManager.shared.allowNotifications
            ),
            iconName: "app.badge",
            tintColor: .systemPurple,
            isEnabled: true
        )
        static let removeAdsCell = ACSettingsParameterUIModel(
            content: ACSettingsParameter(
                name: "Remove Ads",
                value: true
            ),
            iconName: "a.square.fill",
            tintColor: .systemGreen,
            isEnabled: false
        )
    }
}
