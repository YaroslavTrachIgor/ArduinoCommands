//
//  Intro.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main model
final class IntroCard: Identifiable {
    var id = UUID()
    let title: String?
    let subtitle: String?
    let content: String?
    
    //MARK: Initialization
    init(title: String?,
         subtitle: String?,
         content: String?) {
        self.title = title
        self.subtitle = subtitle
        self.content = content
    }
}
