//
//  CommandReadingModeSubheadlineText.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-03.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct CommandReadingModeSubheadlineText: View {
    
    //MARK: Public
    var text: String
    var font: UIFont
    var foregroundColor: UIColor
    
    //MARK: View Configuration
    var body: some View {
        Text(text)
            .foregroundColor(Color(foregroundColor))
            .font(Font(font))
            .padding([.trailing, .leading, .top], 12)
    }
}
