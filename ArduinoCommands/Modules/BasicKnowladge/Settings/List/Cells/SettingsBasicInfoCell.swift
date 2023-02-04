//
//  SettingsBasicInfoCell.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsBasicInfoCell: View {
    
    //MARK: Public
    @State var item: ACSettingsBasicInfo
    
    //MARK: View Configuration
    var body: some View {
        HStack {
            parameterTitle
            Spacer()
            parameterSubtitle
        }
    }
}


//MARK: - Main properties
private extension SettingsBasicInfoCell {
    
    //MARK: Private
    var parameterTitle: some View {
        Text(item.parameter!)
            .font(.system(size: 16, weight: .regular))
    }
    var parameterSubtitle: some View {
        Text(item.value!)
            .font(.system(size: 15.5, weight: .regular))
            .foregroundColor(Color(.tertiaryLabel))
    }
}
