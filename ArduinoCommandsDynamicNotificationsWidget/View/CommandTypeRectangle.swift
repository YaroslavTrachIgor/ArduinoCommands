//
//  CommandTypeRectangle.swift
//  ArduinoCommands
//
//  Created by User on 17.12.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct CommandTypeRectangle: View {
    
    //MARK: Public
    @State var tintColor: UIColor
    
    //MARK: View Configuration
    var body: some View {
        Rectangle()
            .foregroundColor(Color(uiColor: tintColor))
            .frame(width: 22, height: 4)
            .cornerRadius(2)
            .opacity(0.4)
            .padding(0)
            .padding(.leading, -2)
    }
}
