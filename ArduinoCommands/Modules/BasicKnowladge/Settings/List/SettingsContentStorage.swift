//
//  SettingsContentStorage.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import UIKit

//MARK: - Settings content Storage
public enum SettingsContentStorage {
    
    //MARK: Public
    enum Preview {
        
        //MARK: Static
        static let header = "Preview"
        static let footer = "In this section, you can learn the latest Arduino Commands features by viewing App Intro."
        static let content: [SettingsPreview] = [
            SettingsPreview(
                title: "Show Intro",
                iconName: "eyes"
            )
        ]
    }
    enum Personal {
        
        //MARK: Static
        static let header = "Personal"
        static let footer = "Track your personal progress and achievements in discovering Arduino Commands using the weekly analytics and daily reading goals."
        static let analyticsCell = SettingsPersonalParameter(
            title: "Anaylytics",
            subtitle: "Daily Reading Progress",
            iconName: "chart.xyaxis.line",
            tintColor: .systemTeal
        )
    }
    enum BasicInfo {
        
        //MARK: Static
        static let header = "About App"
        static let footer = "In this section, view the basic information about the App, which also exists on App Store."
        static let content: [SettingsBasicInfo] = [
            SettingsBasicInfo(
                parameter: "Version",
                value: ACApplicationCheckManager.Keys.currentVersion
            ),
            SettingsBasicInfo(
                parameter: "Category",
                value: "Education"
            ),
            SettingsBasicInfo(
                parameter: "Age Category",
                value: "+12"
            ),
            SettingsBasicInfo(
                parameter: "Language",
                value: "English"
            ),
            SettingsBasicInfo(
                parameter: "Compatibility",
                value: "iPhone"
            ),
            SettingsBasicInfo(
                parameter: "Designed",
                value: "by Trach Yarsolav"
            )
        ]
    }
    enum ContactInfo {
        
        //MARK: Static
        static let header = "Contact Info"
        static let footer = "View different Arduino Commands resouces, which can help you to learn some more about the App or get the needed help."
        static let content: [ACSettingsContactInfoUIModel] = [
            ACSettingsContactInfoUIModel(
                content: SettingsContactInfo(
                    link: "https://instagram.com/axcigrpvicj_fake/",
                    linkName: "Instagram"
                ),
                iconName: "link",
                tintColor: .systemPink
            ),
            ACSettingsContactInfoUIModel(
                content: SettingsContactInfo(
                    link: "https://yaroslavtrachigor.github.io/ArduinoCommandsInfo",
                    linkName: "Privacy Policy"
                ),
                iconName: "lock.fill",
                tintColor: .systemIndigo
            )
        ]
    }
    enum Parameters {
        
        //MARK: Static
        static let header = "Parameters"
        static let footer = "In this section, you can lock all the unnecessary and unlock the needed features of Arduino Commands."
        static let allowsNotificationsCell = ACSettingsParameterUIModel(
            content: SettingsParameter(
                name: "Allow Notifications",
                value: ACSettingsParametersManager.shared.allowNotifications
            ),
            iconName: "app.badge",
            tintColor: .systemPurple,
            isEnabled: true
        )
        static let removeAdsCell = ACSettingsParameterUIModel(
            content: SettingsParameter(
                name: "Remove Ads",
                value: true
            ),
            iconName: "a.square.fill",
            tintColor: .systemGreen,
            isEnabled: false
        )
    }
}
