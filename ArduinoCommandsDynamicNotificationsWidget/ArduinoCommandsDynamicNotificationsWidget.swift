//
//  ArduinoCommandsDynamicNotificationsWidget.swift
//  ArduinoCommandsDynamicNotificationsWidget
//
//  Created by User on 05.11.2022.
//

import WidgetKit
import SwiftUI

//MARK: - Fast hex Color transformation initialization
public extension UIColor {
    
    //MARK: Public
    /// In the code below, we create a special formatter that will allow us to convert hes code to UIColor.
    /// Some parameters(for instance, `scanLocation`) have been removed in new versions of iOS,
    /// so in the future you will need to find a replacement for them.
    ///
    /// This initialization will typically be used to format JSON content.
    /// - Parameters:
    ///   - hexString: hex color code.
    ///   - alpha: color opacity.
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let set              = CharacterSet.whitespacesAndNewlines
        let hexString        = hexString.trimmingCharacters(in: set)
        let scanner          = Scanner(string: hexString)
        var color: UInt32    = 0
        scanner.scanLocation = 1
        scanner.scanHexInt32(&color)
        let maxValue         = 255.0
        let mask             = 0x000000FF
        let rInt             = Int(color >> 16) & mask
        let gInt             = Int(color >> 8) & mask
        let bInt             = Int(color) & mask
        let red              = CGFloat(rInt) / maxValue
        let blue             = CGFloat(bInt) / maxValue
        let green            = CGFloat(gInt) / maxValue
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

//MARK: - Constants
private enum Constants {
    
    //MARK: Private
    enum UI {
        enum Colors {
            
            //MARK: Static
            static let mainBackgroundColorName = UIColor(hexString: "#034394")
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
                ContainerRelativeShape()
                    .fill(Color(Constants.UI.Colors.mainBackgroundColorName).gradient)
                    .ignoresSafeArea(.all)
                    .padding(-20)
                
                Image("arduinchikIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .frame(width: 110, height: 110)
                    .padding(.top, -30)
                
                VStack(alignment: .leading, spacing: 2) {
                    Spacer()
                    
                    Text(entry.commandPreview.title.dropLast(2))
                        .foregroundStyle(Color.white.opacity(0.95))
                        .font(Font.system(size: 14, weight: .semibold))
                    
                    
                    Text("Command of The Day".uppercased())
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(Font.system(size: 10, weight: .semibold))
                    
                }
                .padding(.bottom, 2)
                .background(
                    LinearGradient(colors: [Color(Constants.UI.Colors.mainBackgroundColorName).opacity(0.2), Color.black.opacity(0.45)], startPoint: .top, endPoint: .bottom)
                        .padding(-30)
                )
            }
        case .systemMedium:
            ZStack(alignment: .leading) {
                ContainerRelativeShape()
                    .fill(Color(Constants.UI.Colors.mainBackgroundColorName).gradient)
                    .ignoresSafeArea(.all)
                    .padding(-30)
                
                HStack {
                    Spacer()
                    
                    Image("arduinchikPro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .frame(width: 140, height: 140)
                        .padding(.trailing, 20)
                }
                
                LinearGradient(colors: [Color(Constants.UI.Colors.mainBackgroundColorName).opacity(0.2), Color.black.opacity(0.45)], startPoint: .top, endPoint: .bottom)
                    .padding(-30)
                
                VStack(alignment: .leading) {
                    Text("Command of The Day".uppercased())
                        .foregroundStyle(Color(.white).opacity(0.8))
                        .font(Font.system(size: 10, weight: .semibold))
                        .padding(.top, 2)
                    
                    Spacer()
                    
                    Text(entry.commandPreview.title.dropLast(2))
                        .foregroundStyle(Color(.white).opacity(0.75))
                        .font(Font.system(size: 16, weight: .semibold))
                    
                    Text(entry.commandPreview.previewContent)
                        .foregroundStyle(Color(.clear))
                        .overlay {
                            LinearGradient(
                                colors: [Color(.white.withAlphaComponent(0.55)), Color(.white.withAlphaComponent(0.25))],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Text(entry.commandPreview.previewContent)
                                    .font(Font.system(size: 12, weight: .regular))
                            )
                        }
                        .frame(width: 150, height: 65)
                        .padding(.leading, -2)
                        .padding(.top, -9)
                }
                .padding(4)
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
    
}
