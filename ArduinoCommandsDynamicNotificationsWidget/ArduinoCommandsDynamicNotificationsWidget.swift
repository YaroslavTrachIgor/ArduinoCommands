//
//  ArduinoCommandsDynamicNotificationsWidget.swift
//  ArduinoCommandsDynamicNotificationsWidget
//
//  Created by User on 05.11.2022.
//

import WidgetKit
import SwiftUI

//MARK: - Constants
private enum Constants {
    
    //MARK: Private
    enum UI {
        enum Colors {
            
            //MARK: Static
            static let mainBackgroundColorName = "WidgetBackground"
            static let seconadaryBackgroundColorName = "WidgetSecondaryBackground"
        }
        enum Text {
            
            //MARK: Static
            static let header = "Daily Command"
            static let stringSpacer = " "
            static let notImplemented = "Not Implemented"
        }
    }
    enum Keys {
        enum PreviewContent {
            
            //MARK: Static
            static let displayName = "Daily Command"
            static let description = "Different Arduino Сommands for daily reading."
        }
        
        //MARK: Static
        static let kind = "ArduinoCommandsDynamicNotificationsWidget"
    }
}


//MARK: - Main Widget
@available(iOSApplicationExtension 16.0, *)
struct ArduinoCommandsDynamicNotificationsWidget: Widget {

    //MARK: - Widget Configuration
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: Constants.Keys.kind, provider: Provider()) { entry in
            ArduinoCommandsDynamicNotificationsWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .accessoryInline, .accessoryRectangular])
        .configurationDisplayName(Constants.Keys.PreviewContent.displayName)
        .description(Constants.Keys.PreviewContent.description)
    }
}



//MARK: - Main Widget Entry
struct PreviewEntry: TimelineEntry {
    let date: Date
    let commandPreview: CommandPreview
}


//MARK: - Main Widget Provider
struct Provider: TimelineProvider {
    
    //MARK: Public
    /// Provides a timeline entry representing a placeholder version of the widget.
    /// - Parameter context: An object that describes the context in which to show the widget.
    /// - Returns: A timeline entry that represents a placeholder version of the widget.
    func placeholder(in context: Context) -> PreviewEntry {
        PreviewEntry(date: Date(), commandPreview: CommandPreviewStorage.randomPreview())
    }
    
    /// Provides a timeline entry that represents the current time and state of a widget.
    /// - Parameters:
    ///   - context: An object describing the context to show the widget in.
    ///   - completion: The completion handler to call after you create the snapshot entry.
    func getSnapshot(in context: Context, completion: @escaping (PreviewEntry) -> ()) {
        let entry = PreviewEntry(date: Date(), commandPreview: CommandPreviewStorage.randomPreview())
        completion(entry)
    }
    
    /// Provides an array of timeline entries for the current time
    /// and, optionally, any future times to update a widget.
    /// - Parameters:
    ///   - context: An object describing the context to show the widget in.
    ///   - completion: The completion handler to call after you create the timeline.
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [PreviewEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = PreviewEntry(date: entryDate, commandPreview: CommandPreviewStorage.randomPreview())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


//MARK: - Main Widget View
@available(iOSApplicationExtension 16.0, *)
struct ArduinoCommandsDynamicNotificationsWidgetEntryView: View {
    
    //MARK: Public
    @State var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    
    //MARK: View Configuration
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            ZStack {
                backgroundGradient
                VStack {
                    VStack(alignment: .leading) {
                        commandHeader
                    }
                    .padding(.leading, 0)
                    .background(Color(.systemTeal).gradient)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            commandTitles
                            commandSubtitle
                        }
                        commandTypeRectangles
                        commandContectTextView
                    }
                    .padding([.leading, .trailing], 14)
                }
            }
        case .accessoryRectangular:
            HStack {
                HStack {
                    Image(systemName: entry.commandPreview.iconName)
                        .font(.system(size: 25, weight: .regular))
                    Rectangle()
                        .frame(width: 1.2, height: 44)
                        .padding([.trailing, .leading], 4)
                        .opacity(0.6)
                    VStack(alignment: .leading) {
                        Text(entry.commandPreview.title)
                            .font(.system(size: 14, weight: .semibold))
                            .lineLimit(1)
                        Text(entry.commandPreview.subtitle)
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(2)
                            .opacity(0.8)
                    }
                }
            }
        case .accessoryInline:
            HStack {
                Image(systemName: entry.commandPreview.iconName)
                Text(Constants.UI.Text.stringSpacer + entry.commandPreview.title)
            }
        default:
            Text(Constants.UI.Text.notImplemented)
        }
    }
}


//MARK: - Main properties
private extension ArduinoCommandsDynamicNotificationsWidgetEntryView {
    
    //MARK: Private
    var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(
            colors: [
                Color(Constants.UI.Colors.mainBackgroundColorName),
                Color(Constants.UI.Colors.seconadaryBackgroundColorName)
            ]), startPoint: .top, endPoint: .bottom)
    }
    var commandHeader: some View {
        Text(Constants.UI.Text.header.uppercased())
            .multilineTextAlignment(.leading)
            .foregroundColor(.white)
            .font(Font(UIFont.systemFont(ofSize: 13, weight: .medium)))
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .frame(height: 30)
            .padding(.leading, 14)
    }
    var commandTitles: some View {
        Text(entry.commandPreview.title.uppercased())
            .font(Font(UIFont.ACFont(ofSize: 14, weight: .bold)))
            .lineLimit(2)
            .padding(.bottom, 0)
            .lineLimit(1)
    }
    var commandSubtitle: some View {
        Text(entry.commandPreview.subtitle.uppercased())
            .font(Font(UIFont.ACFont(ofSize: 8, weight: .bold)))
            .lineLimit(1)
    }
    var commandContectTextView: some View {
        Text(entry.commandPreview.previewContent)
            .font(Font(UIFont.systemFont(ofSize: 10, weight: .regular)))
            .padding(.bottom, 16)
            .padding(.trailing, 10)
            .opacity(0.6)
            .lineLimit(4)
    }
    var commandTypeRectangles: some View {
        HStack() {
            CommandTypeRectangle(tintColor: .systemIndigo)
                .padding(.leading, 2)
            
            if entry.commandPreview.isInitial {
                CommandTypeRectangle(tintColor: .systemTeal)
            } else {
                CommandTypeRectangle(tintColor: .systemPurple)
            }
            
            if entry.commandPreview.returns {
                CommandTypeRectangle(tintColor: .red)
            }
        }
        .padding([.top, .bottom], 0)
    }
}
