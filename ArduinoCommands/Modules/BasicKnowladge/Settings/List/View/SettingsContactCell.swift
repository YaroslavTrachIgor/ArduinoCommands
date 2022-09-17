//
//  SettingsContactCell.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Keys
private extension SettingsContactCell {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Button {
                
                //MARK: Static
                static let chevronIconName = "chevron.right"
            }
        }
    }
}


//MARK: - Main View
struct SettingsContactCell: View {
    
    //MARK: Public
    @State var link: String
    @State var linkName: String
    @State var iconName: String
    @State var tintColor: UIColor
    
    
    //MARK: View preparations
    var body: some View {
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
            
            Text(linkName)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(.label))
                .padding(.leading, 4)
            
            Spacer()
            
            Button {
                guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url as URL)
            } label: {
                Image(systemName: Keys.UI.Button.chevronIconName)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }
    }
}
