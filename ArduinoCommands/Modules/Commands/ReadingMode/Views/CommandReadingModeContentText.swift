//
//  CommandReadingModeContentText.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-03.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct CommandReadingModeContentText: View {
    
    //MARK: Public
    var text: String
    var font: UIFont
    var foregroundColor: UIColor
    
    //MARK: View Configuration
    var body: some View {
        Text(text)
            .foregroundColor(Color(foregroundColor).opacity(0.88))
            .font(Font(font))
            .lineSpacing(7)
    }
}
