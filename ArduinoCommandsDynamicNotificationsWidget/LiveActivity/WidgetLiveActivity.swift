//
//  ArduinoCommandsDynamicNotificationsWidgetLiveActivity.swift
//  ArduinoCommandsDynamicNotificationsWidget
//
//  Created by User on 05.11.2022.
//

import ActivityKit
import WidgetKit
import SwiftUI

//MARK: - Main LiveActivity Widget
@available(iOS 16.1, *)
struct ArduinoCommandsDynamicNotificationsWidgetLiveActivity: Widget {
    
    //MARK: View Configuration
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ArduinoCommandsDynamicNotificationsWidgetAttributes.self) { context in
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {}
                DynamicIslandExpandedRegion(.trailing) {}
                DynamicIslandExpandedRegion(.bottom) {}
            } compactLeading: {} compactTrailing: {} minimal: {}
        }
    }
}
