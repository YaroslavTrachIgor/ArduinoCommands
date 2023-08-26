//
//  CommandReadingModeBarButton.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-03.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct CommandReadingModeBarButton: View {
    
    //MARK: Public
    var action: ACBaseCompletionHandler
    var imageName: String
    var foregroundColor: UIColor
    var strokeColor: UIColor
    
    //MARK: View Configuration
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: imageName)
                .font(Font(UIFont.systemFont(ofSize: 16.5, weight: .medium)))
                .foregroundColor(Color(foregroundColor))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(strokeColor).opacity(0.3), lineWidth: 1)
                        .frame(width: 40, height: 40)
                )
        }
    }
}
