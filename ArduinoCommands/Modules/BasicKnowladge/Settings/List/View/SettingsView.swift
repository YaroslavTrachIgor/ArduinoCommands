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
    
    //MARK: @EnvironmentObject
    @EnvironmentObject var appState: SettingsStateHelper
    
    //MARK: @State
    @State private var isRootActive: Bool = false
    
    //MARK: Private
    private var uiModel: SettingsUIModelProtocol {
        return SettingsUIModel()
    }
    
    
    //MARK: Main View
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header: Text(uiModel.previewSectionHeader),
                            footer: Text(uiModel.previewSectionFooter)) {
                        NavigationLink(destination: IntroView(), isActive: $isRootActive) {
                            ForEach(uiModel.previewSectionContent) { previewCell in
                                SettingsPreviewCell(
                                    title: previewCell.title!,
                                    iconName: previewCell.iconName!
                                )
                            }
                        }
                        .isDetailLink(false)
                    }
                    Section(header: Text(uiModel.parametersSectionHeader)) {
                        ForEach(uiModel.parametersSectionContent) { toggleCell in
                            SettingsViewToggleCell(
                                iconName: toggleCell.iconName!,
                                tintColor: toggleCell.tintColor!,
                                parameterName: toggleCell.content.parameterName!,
                                parameterValue: toggleCell.content.parameterValue!
                            )
                        }
                    }
                    Section(header: Text(uiModel.contactInfoSectionHeader),
                            footer: Text(uiModel.contactInfoSectionFooter)) {
                        ForEach(uiModel.contactInfoSectionContent) { contactInfoCell in
                            SettingsContactCell(
                                link: contactInfoCell.content.link!,
                                linkName: contactInfoCell.content.linkName!,
                                iconName: contactInfoCell.iconName!,
                                tintColor: contactInfoCell.tintColor!
                            )
                        }
                    }
                    Section(header: Text(uiModel.aboutAppSectionHeader),
                            footer: Text(uiModel.aboutAppSectionFooter)) {
                        ForEach(uiModel.aboutAppSectionContent) { basicInfoCell in
                            SettingsBasicInfoCell(
                                parameter: basicInfoCell.parameter!,
                                value: basicInfoCell.value!
                            )
                        }
                    }
                }
            }
            .onReceive(appState.$movedToRoot) { moveToDashboard in
                if moveToDashboard {
                    isRootActive = false
                    appState.movedToRoot = false
                }
            }
            .listStyle(InsetListStyle())
            .padding(.top, -35)
            .navigationBarTitle(uiModel.title, displayMode: .inline)
            .configureNavigationBar {
                $0.navigationBar.backgroundColor = .systemGroupedBackground
                $0.navigationBar.setBackgroundImage(UIImage(), for: .default)
                $0.navigationBar.shadowImage = UIImage()
            }
        }
    }
}
