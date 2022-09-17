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
    @State var title: String
    @State var iconName: String
    
    //MARK: View preparations
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(.orange))
                Image(systemName: iconName)
                    .imageScale(.small)
                    .foregroundColor(.white)
            }
            .frame(width: 26, height: 26, alignment: .center)
            .padding(.leading, -8)
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(.label))
                .padding(.leading, 4)
            
            Spacer()
        }
    }
}
