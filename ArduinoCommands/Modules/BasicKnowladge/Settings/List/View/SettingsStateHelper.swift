//
//  SettingsStateHelper.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation

//MARK: - Settings navigation State Helper
final class SettingsStateHelper: ObservableObject {
    
    //MARK: @Published
    /**
     The varible below is needed for costom transitions
     between `Views` in SwiftUI files.
     
     We will use Settings State Helper properties in order to
     present `IntroView` without Navigation Bar on the top.
     */
    @Published var movedToRoot: Bool = false
}
