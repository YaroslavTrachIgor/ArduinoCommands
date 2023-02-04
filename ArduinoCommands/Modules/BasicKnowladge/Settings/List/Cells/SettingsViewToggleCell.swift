//
//  SettingsViewToggleCell.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View completion Handler
typealias SettingsParameterCellDisappearHandler = ((Bool) -> Void)


//MARK: - Main View
struct SettingsParameterCell: View {
    
    //MARK: Public
    @State var isOn: Bool
    @State var item: ACSettingsParameterCell
    @State var onDisappear: SettingsParameterCellDisappearHandler!
    
    //MARK: View Configuration
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack {
                toggleCellIcon
                toggleCellTitle
            }
        }
        .onDisappear(perform: {
            setNewParameterValue()
        })
        .disabled(!item.isEnabled!)
        .toggleStyle(SwitchToggleStyle(tint: .indigo))
        .padding(.trailing, -8)
    }
}


//MARK: - Main properties
private extension SettingsParameterCell {
    
    //MARK: Private
    var toggleCellIcon: some View {
        SettingsCellIcon(iconName: item.iconName!, tintColor: item.tintColor!)
            .frame(width: 26, height: 26, alignment: .center)
            .padding(.leading, -8)
    }
    var toggleCellTitle: some View {
        Text(item.content.name!)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Color(.label))
            .padding(.leading, 4)
    }
}

//MARK: - Main methods
private extension SettingsParameterCell {
    
    //MARK: Private
    func setNewParameterValue() {
        if item.isEnabled! {
            onDisappear(isOn)
        }
    }
}
