//
//  CommandReadingModeSubtitleText.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-03.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct CommandReadingModeSubtitleText: View {
    
    //MARK: Public
    var text: String
    var font: UIFont
    var foregroundColor: UIColor
    
    //MARK: View Configuration
    var body: some View {
        Text(text.uppercased())
            .padding([.top], 8)
            .font(Font(font))
            .foregroundColor(Color(foregroundColor).opacity(0.9))
    }
}
