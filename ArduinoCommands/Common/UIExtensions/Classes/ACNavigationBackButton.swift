//
//  NavigationBackButton.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-11.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct ACNavigationBackButton: View {
    
    //MARK: Public
    var completion: ACBaseCompletionHandler
    
    //MARK: View Configuration
    var body: some View {
        Button(action: {
            completion()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(.label))
            }
        }
    }
}
