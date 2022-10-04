//
//  SettingsViewToggleCell.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsViewToggleCell: View {
    
    //MARK: Public
    @State var iconName: String
    @State var tintColor: UIColor
    @State var parameterName: String
    @State var parameterValue: Bool
    
    
    //MARK: View preparations
    var body: some View {
        Toggle(isOn: $parameterValue) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(tintColor))
                    Image(systemName: iconName)
                        .imageScale(.small)
                        .foregroundColor(.white)
                }
                .frame(width: 26, height: 26, alignment: .center)
                .padding(.leading, -8)
                
                Text(parameterName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(.label))
                    .padding(.leading, 4)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .indigo))
        .padding(.trailing, -8)
    }
}
