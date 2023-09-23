//
//  SettingsCellDestinationArrow.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-11.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsCellDestinationArrow: View {
    
    //MARK: View Configuration
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .semibold, design: .rounded))
    }
}
