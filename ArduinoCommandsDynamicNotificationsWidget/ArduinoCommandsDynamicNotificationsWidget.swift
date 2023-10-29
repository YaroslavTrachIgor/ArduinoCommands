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
            static let mainBackgroundColorName = #colorLiteral(red: 0, green: 0.2448818684, blue: 0.5670689344, alpha: 1)
        }
        enum Text {
            
            //MARK: Static
            static let header = "Arduino"
            static let subtitle = "Command of the Day"
            static let stringSpacer = " "
            static let notImplemented = "Not Implemented"
        }
        enum Image {
            
            //MARK: Static
            static let arduinchikIconName = "arduinchikIcon"
            static let arduinchikProIconName = "arduinchikPro"
        }
    }
    enum Keys {
        enum PreviewContent {
            
            //MARK: Static
            static let displayName = "Command of the Day"
            static let description = "Do not forget to read at least one Arduino article per day."
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
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryInline, .accessoryRectangular])
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
struct ArduinoCommandsDynamicNotificationsWidgetEntryView: View {
    
    //MARK: Public
    @State var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    
    //MARK: View Configuration
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            DailyCommandSmallWidgetEntryView(commandPreview: entry.commandPreview)
        case .systemMedium:
            DailyCommandMediumWidgetEntryView(commandPreview: entry.commandPreview)
        case .accessoryInline:
            DailyCommandAccessoryInlineWidgetEntryView(commandPreview: entry.commandPreview)
        case .accessoryRectangular:
            DailyCommandAccessoryRectangularWidgetEntryView(commandPreview: entry.commandPreview)
        default:
            Text(Constants.UI.Text.notImplemented)
        }
    }
}


//MARK: - Main small Widget View
struct DailyCommandSmallWidgetEntryView: View {
    
    //MARK: Public
    var commandPreview: CommandPreview
    
    //MARK: View Configuration
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color(Constants.UI.Colors.mainBackgroundColorName).gradient)
                .ignoresSafeArea(.all)
                .padding(-20)
            
            Image(Constants.UI.Image.arduinchikIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .frame(width: 110, height: 110)
                .padding(.top, -30)
            
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                
                Text(commandPreview.title.dropLast().dropLast())
                    .foregroundStyle(Color.white.opacity(0.95))
                    .font(Font.system(size: 14, weight: .semibold))
                
                Text(Constants.UI.Text.subtitle.uppercased())
                    .foregroundStyle(Color.white.opacity(0.8))
                    .font(Font.system(size: 10, weight: .semibold))
            }
            .padding(.bottom, 16)
            .background(
                LinearGradient(
                    colors: [
                        Color(Constants.UI.Colors.mainBackgroundColorName).opacity(0.2),
                        Color.black.opacity(0.45)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .padding(-30)
            )
        }
    }
}


//MARK: - Main medium Widget View
struct DailyCommandMediumWidgetEntryView: View {
    
    //MARK: Public
    var commandPreview: CommandPreview
    
    //MARK: View Configuration
    var body: some View {
        ZStack(alignment: .leading) {
            ContainerRelativeShape()
                .fill(Color(Constants.UI.Colors.mainBackgroundColorName).gradient)
                .ignoresSafeArea(.all)
                .padding(-30)
            
            HStack {
                Spacer()
                
                Image(Constants.UI.Image.arduinchikProIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .frame(width: 140, height: 140)
                    .padding(.trailing, 20)
            }
            
            LinearGradient(
                colors: [
                    Color(Constants.UI.Colors.mainBackgroundColorName).opacity(0.2),
                    Color.black.opacity(0.45)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .padding(-30)
            
            VStack(alignment: .leading) {
                Text(Constants.UI.Text.subtitle.uppercased())
                    .foregroundStyle(Color(.white).opacity(0.8))
                    .font(Font.system(size: 10, weight: .semibold))
                    .padding(.top, 2)
                
                Spacer()
                
                Text(commandPreview.title.dropLast().dropLast())
                    .foregroundStyle(Color(.white).opacity(0.85))
                    .font(Font.system(size: 16, weight: .semibold))
                Text(commandPreview.previewContent)
                    .foregroundStyle(Color(.clear))
                    .overlay {
                        LinearGradient(
                            colors: [
                                Color(.white.withAlphaComponent(0.55)),
                                Color(.white.withAlphaComponent(0.25))
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            Text(commandPreview.previewContent)
                                .font(Font.system(size: 12, weight: .regular))
                        )
                    }
                    .frame(width: 150, height: 65)
                    .padding(.leading, -2)
                    .padding(.top, -12)
            }
            .padding([.top, .leading], 16)
            .padding([.bottom], 12)
        }
    }
}


//MARK: - Main accessory rectangular Widget View
struct DailyCommandAccessoryRectangularWidgetEntryView: View {
    
    //MARK: Public
    var commandPreview: CommandPreview
    
    //MARK: View Configuration
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: commandPreview.iconName)
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.trailing, -3)
                Text(Constants.UI.Text.header)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
            }
            Text(commandPreview.title)
                .font(.system(size: 15, weight: .regular))
                .lineLimit(1)
            Text(commandPreview.subtitle)
                .font(.system(size: 10, weight: .medium))
                .lineLimit(2)
                .opacity(0.6)
        }
    }
}


//MARK: - Main accessory inline Widget View
struct DailyCommandAccessoryInlineWidgetEntryView: View {
    
    //MARK: Public
    var commandPreview: CommandPreview
    
    //MARK: View Configuration
    var body: some View {
        HStack {
            Image(systemName: commandPreview.iconName)
            Text(Constants.UI.Text.stringSpacer + commandPreview.title)
        }
    }
}
