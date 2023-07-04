//
//  SettingsCellIcon.swift
//  ArduinoCommands
//
//  Created by User on 15.10.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsCellIcon: View {
    
    //MARK: Public
    @State var iconName: String
    @State var tintColor: UIColor
    
    //MARK: View Configuration
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(tintColor))
            Image(systemName: iconName)
                .imageScale(.small)
                .foregroundColor(.white)
        }
    }
}

//MARK: - Main View
struct SettingsCellDestinationArrow: View {
    
    //MARK: View Configuration
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .semibold, design: .rounded))
    }
}

