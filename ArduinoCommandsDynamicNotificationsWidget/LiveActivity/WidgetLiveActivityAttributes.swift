//
//  ArduinoCommandsDynamicNotificationsWidgetAttributes.swift
//  ArduinoCommands
//
//  Created by User on 17.12.2022.
//

import Foundation
import ActivityKit

//MARK: - Main LiveActivity Attributes
struct ArduinoCommandsDynamicNotificationsWidgetAttributes: ActivityAttributes {
    
    //MARK: ContentState
    public struct ContentState: Codable, Hashable {
        var value: Int
    }
    
    //MARK: Public
    var name: String
}
