//
//  SettingsView.swift
//  ArduinoCommands
//
//  Created by User on 12.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct SettingsView: View {
    
    //MARK: Private
    @State
    private var introSheetPresented = false
    
    //MARK: View Configuration
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    settingsPreviewSection
                    if #available(iOS 16.0, *) {
                        settingsAnalyticsSection
                    }
                    settingsParametersSection
                    settingsContactInfoSection
                    settingsAboutAppSection
                }
            }
            .padding(.top, -15)
            .navigationBarTitle("Settings".transformInTitle(), displayMode: .inline)
            .configureNavigationBar {
                configureNavigationBar(for: $0.navigationBar)
            }
        }
        .accentColor(.red)
    }
}


//MARK: - Main properties
private extension SettingsView {
    
    //MARK: Private
    var settingsPreviewSection: some View {
        Section(header: Text(ACSettingsStorage.PreviewSection.header.uppercased()),
                footer: Text(ACSettingsStorage.PreviewSection.footer)) {
            ForEach(ACSettingsStorage.PreviewSection.content) { item in
                SettingsPreviewCell(item: item)
                .onTapGesture {
                    introSheetPresented.toggle()
                }
                .sheet(isPresented: $introSheetPresented) {
                    IntroView()
                }
            }
        }
    }
    @available(iOS 16.0, *)
    var settingsAnalyticsSection: some View {
        Section(header: Text("Personal".uppercased()),
                footer: Text("Track your progress in learning Arduino commands and set personal Commands Goals.")) {
            NavigationLink(destination: SettingsAnalyticsView()) {
                SettingsAnalyticsCell()
            }
            .accentColor(.red)
        }
    }
    var settingsContactInfoSection: some View {
        Section(header: Text(ACSettingsStorage.ContactInfoSection.header.uppercased()),
                footer: Text(ACSettingsStorage.ContactInfoSection.footer)) {
            ForEach(ACSettingsStorage.ContactInfoSection.content) { item in
                SettingsContactCell(item: item)
            }
        }
    }
    var settingsParametersSection: some View {
        Section(header: Text(ACSettingsStorage.ParametersSection.header.uppercased())) {
            SettingsParameterCell(isOn: ACSettingsManager.shared.allowNotifications,
                                  item: ACSettingsStorage.ParametersSection.allowsNotificationsCell) { isOn in
                ACSettingsManager.shared.allowNotifications = isOn
            }
        }
    }
    var settingsAboutAppSection: some View {
        Section(header: Text(ACSettingsStorage.BasicInfoSection.header.uppercased()),
                footer: Text(ACSettingsStorage.BasicInfoSection.footer)) {
            ForEach(ACSettingsStorage.BasicInfoSection.content) { item in
                SettingsBasicInfoCell(item: item)
            }
        }
    }
}


//MARK: - Main methods
private extension SettingsView {
    
    //MARK: Private
    func configureNavigationBar(for navigationBar: UINavigationBar) {
        let shadowImage = UIImage()
        let backgroundColor = UIColor.ACTable.backgroundColor
        navigationBar.setBackgroundImage(shadowImage, for: .default)
        navigationBar.backgroundColor = backgroundColor
        navigationBar.shadowImage = shadowImage
    }
}



//MARK: - Main View
struct SettingsAnalyticsCell: View {
    
    //MARK: View Configuration
    var body: some View {
        HStack {
            analyticsCellIcon
            VStack(alignment: .leading) {
                analyticsCellTitle
                analyticsCellSubtitle
            }
            .padding(.leading, 4)
        }
    }
}


//MARK: - Main properties
private extension SettingsAnalyticsCell {
    
    //MARK: Private
    var analyticsCellIcon: some View {
        SettingsCellIcon(iconName: "chart.bar.xaxis", tintColor: .systemRed)
            .frame(width: 26, height: 26, alignment: .center)
            .padding(.leading, -8)
    }
    var analyticsCellTitle: some View {
        Text("Anaylytics")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Color(.label))
            .multilineTextAlignment(.leading)
            .padding(.leading, 0)
    }
    var analyticsCellSubtitle: some View {
        Text("Commands Articles Anaylytics")
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(Color(.secondaryLabel))
            .multilineTextAlignment(.leading)
    }
}

import Charts

//MARK: - Main View
@available(iOS 16.0, *)
struct SettingsAnalyticsView: View {
    
    let viewDays: [ViewDay] = [
        ViewDay(date: Date.from(year: 2023, month: 1, day: 1), articlesCount: 2),
        ViewDay(date: Date.from(year: 2023, month: 1, day: 2), articlesCount: 1),
        ViewDay(date: Date.from(year: 2023, month: 1, day: 3), articlesCount: 4),
        ViewDay(date: Date.from(year: 2023, month: 1, day: 4), articlesCount: 3),
        ViewDay(date: Date.from(year: 2023, month: 1, day: 5), articlesCount: 6),
        ViewDay(date: Date.from(year: 2023, month: 1, day: 6), articlesCount: 4),
        ViewDay(date: Date.from(year: 2023, month: 1, day: 7), articlesCount: 3)
    ]
    
    //MARK: View Configuration
    var body: some View {
        Form {
            Section(header: Text("Parameters".uppercased())) {
                SettingsParameterCell(isOn: ACSettingsManager.shared.allowAnalytics,
                                      item: ACSettingsParameterUIModel(content: ACSettingsParameter(name: "Allow Analytics", value: ACSettingsManager.shared.allowAnalytics), iconName: "chart.bar.xaxis", tintColor: .systemRed, isEnabled: true)) { isOn in
                    ACSettingsManager.shared.allowAnalytics = isOn
                }
            }
            Section(header: Text("Daily Progress"), footer: Text("View your daily progress in learning Arduino commands.\n\nAn article read by you on a certain day would be counted towards the total number of articles read per day if you spent more than three minutes studying it.")) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Commands Article Views")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color(.label))
                        Text("Total: \(viewDays.reduce(0, { $0 + $1.articlesCount}))")
                            .fontWeight(.regular)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, -8)
                    
                    Chart {
                        RuleMark(y: .value("Goal", 3))
                            .foregroundStyle(Color.secondary.opacity(0.5))
                            .lineStyle(StrokeStyle(dash: [4]))
                            .annotation(alignment: .leading) {
                                Text("Goal")
                                    .font(.caption)
                                    .foregroundColor(Color.secondary)
                                    .padding(.leading, 4)
                            }
                        ForEach(viewDays) { viewDay in
                            BarMark(
                                x: .value("Day", viewDay.date, unit: .day),
                                y: .value("# of Articles", viewDay.articlesCount)
                            )
                            .foregroundStyle(Color(.systemRed).gradient)
                            .cornerRadius(5)
                        }
                    }
                    .frame(height: 200)
                    .padding()
                    .chartYScale(domain: 0...(viewDays.max()?.articlesCount)!+1)
                }
            }
        }
        .navigationBarTitle("Analytics".transformInTitle(), displayMode: .inline)
    }
}

struct ViewDay: Identifiable, Comparable {
    let id = UUID()
    let date: Date
    let articlesCount: Int
    
    static func ==(lhs: ViewDay, rhs: ViewDay) -> Bool {
        return lhs.articlesCount == rhs.articlesCount
    }

    static func <(lhs: ViewDay, rhs: ViewDay) -> Bool {
        return lhs.articlesCount < rhs.articlesCount
    }
}

