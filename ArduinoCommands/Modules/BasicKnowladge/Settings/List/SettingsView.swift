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
                    if #available(iOS 16.0, *) {
                        settingsPersonalParametersSection
                    }
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
        .accentColor(.red)
    }
}


//MARK: - Main properties
private extension SettingsView {
    
    //MARK: Private
    var settingsPreviewSection: some View {
        Section(header: Text(SettingsContentStorage.Preview.header.uppercased()),
                footer: Text(SettingsContentStorage.Preview.footer)) {
            ForEach(SettingsContentStorage.Preview.content) { item in
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
    @available(iOS 16.0, *)
    var settingsPersonalParametersSection: some View {
        Section(header: Text(SettingsContentStorage.Personal.header.uppercased()),
                footer: Text(SettingsContentStorage.Personal.footer)) {
            NavigationLink(destination: AnalyticsView()) {
                SettingsPersonalParameterCell(item: SettingsContentStorage.Personal.analyticsCell)
            }
        }
    }
    var settingsContactInfoSection: some View {
        Section(header: Text(SettingsContentStorage.ContactInfo.header.uppercased()),
                footer: Text(SettingsContentStorage.ContactInfo.footer)) {
            ForEach(SettingsContentStorage.ContactInfo.content) { item in
                SettingsContactCell(item: item)
            }
        }
    }
    var settingsParametersSection: some View {
        Section(header: Text(SettingsContentStorage.Parameters.header.uppercased())) {
            SettingsParameterCell(isOn: ACSettingsParametersManager.shared.allowNotifications,
                                  item: SettingsContentStorage.Parameters.allowsNotificationsCell) { isOn in
                ACSettingsParametersManager.shared.allowNotifications = isOn
            }
        }
    }
    var settingsAboutAppSection: some View {
        Section(header: Text(SettingsContentStorage.BasicInfo.header.uppercased()),
                footer: Text(SettingsContentStorage.BasicInfo.footer)) {
            ForEach(SettingsContentStorage.BasicInfo.content) { item in
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
