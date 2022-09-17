//
//  SettingsViewModel.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation

//MARK: - ViewModel protocol
protocol SettingsUIModelProtocol {
    var title: String! { get }
    var previewSectionHeader: String! { get }
    var previewSectionFooter: String! { get }
    var previewSectionContent: [ACSettingsPreviewModel]! { get }
    var parametersSectionHeader: String! { get }
    var parametersSectionContent: [ACSettingsToggleParameterCellModel]! { get }
    var contactInfoSectionHeader: String! { get }
    var contactInfoSectionFooter: String! { get }
    var contactInfoSectionContent: [ACSettingsContactInfoCellModel]! { get }
    var aboutAppSectionHeader: String! { get }
    var aboutAppSectionFooter: String! { get }
    var aboutAppSectionContent: [ACSettingsBasicInfoModel]! { get }
}


//MARK: - Main ViewModel
final public class SettingsUIModel {
    var contactInfoSectionContent: [ACSettingsContactInfoCellModel]!
    var parametersSectionContent: [ACSettingsToggleParameterCellModel]!
    var aboutAppSectionContent: [ACSettingsBasicInfoModel]!
    var previewSectionContent: [ACSettingsPreviewModel]!
    
    //MARK: Initialization
    init(parametersSectionContent: [ACSettingsToggleParameterCellModel] = ACSettingsStorage.ToggleParametersSection.content,
         contactInfoSectionContent: [ACSettingsContactInfoCellModel] = ACSettingsStorage.ContactInfoSection.content,
         aboutAppSectionContent: [ACSettingsBasicInfoModel] = ACSettingsStorage.BasicInfoSection.content,
         previewSectionContent: [ACSettingsPreviewModel]! = ACSettingsStorage.PreviewSection.content) {
        self.contactInfoSectionContent = contactInfoSectionContent
        self.parametersSectionContent = parametersSectionContent
        self.aboutAppSectionContent = aboutAppSectionContent
        self.previewSectionContent = previewSectionContent
    }
}


//MARK: - ViewModel protocol extension
extension SettingsUIModel: SettingsUIModelProtocol {
    
    //MARK: Internal
    /**
     In the code bellow we use  `SettingsStorage` static properties
     to prepare `SettingsView` screen basic content.
     
     The majority of the values bellow will be used in `Section` footers and titles.
     We don't initialize storage in the `View`  to separate the logic of different application entities from each other.
     */
    internal var title: String! {
        ACSettingsStorage.title.transformInTitle()
    }
    
    internal var previewSectionHeader: String! {
        ACSettingsStorage.PreviewSection.header.uppercased()
    }
    internal var previewSectionFooter: String! {
        ACSettingsStorage.PreviewSection.footer
    }
    internal var parametersSectionHeader: String! {
        ACSettingsStorage.ToggleParametersSection.header.uppercased()
    }
    internal var contactInfoSectionHeader: String! {
        ACSettingsStorage.ContactInfoSection.header.uppercased()
    }
    internal var contactInfoSectionFooter: String! {
        ACSettingsStorage.ContactInfoSection.footer
    }
    internal var aboutAppSectionHeader: String! {
        ACSettingsStorage.BasicInfoSection.header.uppercased()
    }
    internal var aboutAppSectionFooter: String! {
        ACSettingsStorage.BasicInfoSection.footer
    }
}
