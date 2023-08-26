//
//  SettingsAnalyticsCell.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-05.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsPersonalParameterCell: View {
    
    //MARK: Public
    @State var item: SettingsPersonalParameter
    
    //MARK: View Configuration
    var body: some View {
        HStack {
            personalParameterCellIcon
            VStack(alignment: .leading) {
                personalParameterCellTitle
                personalParameterCellSubtitle
            }
            .padding(.leading, 4)
        }
    }
}


//MARK: - Main properties
private extension SettingsPersonalParameterCell {
    
    //MARK: Private
    var personalParameterCellIcon: some View {
        SettingsCellIcon(iconName: item.iconName, tintColor: item.tintColor)
            .frame(width: 26, height: 26, alignment: .center)
            .padding(.leading, -8)
    }
    var personalParameterCellTitle: some View {
        Text(item.title)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Color(.label))
            .multilineTextAlignment(.leading)
            .padding(.leading, 0)
    }
    var personalParameterCellSubtitle: some View {
        Text(item.subtitle!)
            .font(.system(size: 9.5, weight: .regular))
            .foregroundColor(Color(.secondaryLabel))
            .multilineTextAlignment(.leading)
    }
}
