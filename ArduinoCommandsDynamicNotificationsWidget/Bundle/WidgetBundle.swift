//
//  ArduinoCommandsDynamicNotificationsWidgetBundle.swift
//  ArduinoCommandsDynamicNotificationsWidget
//
//  Created by User on 05.11.2022.
//

import WidgetKit
import SwiftUI

//MARK: - Main Widget Bundle
@main
@available(iOSApplicationExtension 16.0, *)
struct ArduinoCommandsDynamicNotificationsWidgetBundle: WidgetBundle {
    
    //MARK: Widget Configuration
    var body: some Widget {
        ArduinoCommandsDynamicNotificationsWidget()
    }
}
