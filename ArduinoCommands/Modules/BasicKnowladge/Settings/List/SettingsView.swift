//
//  SettingsView.swift
//  ArduinoCommands
//
//  Created by User on 12.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsView: View {
    
    //MARK: Private
    @State
    private var introSheetPresented = false
    
    //MARK: View Configuration
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    settingsPreviewSection
                    settingsParametersSection
                    settingsContactInfoSection
                    settingsAboutAppSection
                }
            }
            .padding(.top, -15)
            .navigationBarTitle("Settings".transformInTitle(), displayMode: .inline)
            .configureNavigationBar {
                configureNavigationBar(for: $0.navigationBar)
            }
        }
    }
}


//MARK: - Main properties
private extension SettingsView {
    
    //MARK: Private
    var settingsPreviewSection: some View {
        Section(header: Text(ACSettingsStorage.PreviewSection.header.uppercased()),
                footer: Text(ACSettingsStorage.PreviewSection.footer)) {
            ForEach(ACSettingsStorage.PreviewSection.content) { item in
                SettingsPreviewCell(item: item)
                .onTapGesture {
                    introSheetPresented.toggle()
                }
                .sheet(isPresented: $introSheetPresented) {
                    IntroView()
                }
            }
        }
    }
    var settingsContactInfoSection: some View {
        Section(header: Text(ACSettingsStorage.ContactInfoSection.header.uppercased()),
                footer: Text(ACSettingsStorage.ContactInfoSection.footer)) {
            ForEach(ACSettingsStorage.ContactInfoSection.content) { item in
                SettingsContactCell(item: item)
            }
        }
    }
    var settingsParametersSection: some View {
        Section(header: Text(ACSettingsStorage.ParametersSection.header.uppercased()),
                footer: Text(ACSettingsStorage.ParametersSection.footer)) {
            SettingsParameterCell(isOn: ACSettingsManager.shared.allowsNotifications,
                                  item: ACSettingsStorage.ParametersSection.allowsNotificationsCell) { isOn in
                ACSettingsManager.shared.allowsNotifications = isOn
            }
        }
    }
    var settingsAboutAppSection: some View {
        Section(header: Text(ACSettingsStorage.BasicInfoSection.header.uppercased()),
                footer: Text(ACSettingsStorage.BasicInfoSection.footer)) {
            ForEach(ACSettingsStorage.BasicInfoSection.content) { item in
                SettingsBasicInfoCell(item: item)
            }
        }
    }
}


//MARK: - Main methods
private extension SettingsView {
    
    //MARK: Private
    func configureNavigationBar(for navigationBar: UINavigationBar) {
        let shadowImage = UIImage()
        let backgroundColor = UIColor.ACTable.backgroundColor
        navigationBar.setBackgroundImage(shadowImage, for: .default)
        navigationBar.backgroundColor = backgroundColor
        navigationBar.shadowImage = shadowImage
    }
}
