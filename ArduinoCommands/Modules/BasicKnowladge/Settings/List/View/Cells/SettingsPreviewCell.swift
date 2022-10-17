//
//  SettingsPreviewCell.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsPreviewCell: View {
    
    //MARK: Public
    @State var item: ACSettingsPreview
    
    //MARK: View Configuration
    var body: some View {
        HStack {
            previewCellIcon
            previewCellTitle
            Spacer()
        }
    }
}


//MARK: - Main properties
private extension SettingsPreviewCell {
    
    //MARK: Private
    var previewCellIcon: some View {
        SettingsCellIcon(iconName: item.iconName!, tintColor: .orange)
            .frame(width: 26, height: 26, alignment: .center)
            .padding(.leading, -8)
    }
    var previewCellTitle: some View {
        Text(item.title!)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.label))
            .padding(.leading, 4)
    }
}
