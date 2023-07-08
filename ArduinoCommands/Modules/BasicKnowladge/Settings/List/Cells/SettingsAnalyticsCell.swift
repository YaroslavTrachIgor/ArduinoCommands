//
//  SettingsAnalyticsCell.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-05.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsAnalyticsCell: View {
    
    //MARK: View Configuration
    var body: some View {
        HStack {
            analyticsCellIcon
            VStack(alignment: .leading) {
                analyticsCellTitle
                analyticsCellSubtitle
            }
            .padding(.leading, 4)
        }
    }
}


//MARK: - Main properties
private extension SettingsAnalyticsCell {
    
    //MARK: Private
    var analyticsCellIcon: some View {
        SettingsCellIcon(iconName: "chart.bar.xaxis", tintColor: .systemTeal )
            .frame(width: 26, height: 26, alignment: .center)
            .padding(.leading, -8)
    }
    var analyticsCellTitle: some View {
        Text("Anaylytics")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Color(.label))
            .multilineTextAlignment(.leading)
            .padding(.leading, 0)
    }
    var analyticsCellSubtitle: some View {
        Text("Command Articles Anaylytics")
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(Color(.secondaryLabel))
            .multilineTextAlignment(.leading)
    }
}
