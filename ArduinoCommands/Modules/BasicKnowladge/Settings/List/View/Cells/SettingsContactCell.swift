//
//  SettingsContactCell.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsContactCell: View {
    
    //MARK: Public
    @State var item: ACSettingsContactInfoCell
    
    //MARK: View Configuration
    var body: some View {
        HStack {
            contactCellIcon
            contactCellTitle
            Spacer()
            contactCellLinkButton
        }
    }
}


//MARK: - Main properties
private extension SettingsContactCell {
    
    //MARK: Private
    var contactCellIcon: some View {
        SettingsCellIcon(iconName: item.iconName!, tintColor: item.tintColor!)
            .frame(width: 26, height: 26, alignment: .center)
            .padding(.leading, -8)
    }
    var contactCellTitle: some View {
        Text(item.content.linkName!)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.label))
            .padding(.leading, 4)
    }
    var contactCellLinkButton: some View {
        Button {
            openResourceLink()
        } label: {
            contactCellLinkIcon
        }
        .accentColor(Color(.systemGray2))
    }
    var contactCellLinkIcon: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .semibold, design: .rounded))
    }
}


//MARK: - Main methods
private extension SettingsContactCell {
    
    //MARK: Static
    func openResourceLink() {
        let stringURL = item.content.link!
        let url = URL(string: stringURL)
        let canOpenUrl = UIApplication.shared.canOpenURL(url!)
        guard let url = url, canOpenUrl else { return }
        UIApplication.shared.open(url as URL)
    }
}
