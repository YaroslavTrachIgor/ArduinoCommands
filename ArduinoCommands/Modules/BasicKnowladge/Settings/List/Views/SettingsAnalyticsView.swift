//
//  SettingsAnalyticsView.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-08.
//

import Foundation
import SwiftUI
import Charts

//MARK: - Main View
@available(iOS 16.0, *)
struct SettingsAnalyticsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("dailyGoal")
    private var dailyGoal: Int = 0
    @AppStorage("analyticsAreAvailable")
    private var analyticsAreAvailable: Bool = true
    @State
    private var viewDays: [ViewDay] = ACCommandsAnalyticsManager.shared.fetchViewDays()
    
    //MARK: View Configuration
    var body: some View {
        Form {
            Section(header: Text("Parameters".uppercased())) {
                Toggle(isOn: $analyticsAreAvailable.animation(.easeInOut(duration: 0.4))) {
                    HStack {
                        SettingsCellIcon(iconName: "chart.bar.xaxis", tintColor: .systemTeal)
                            .frame(width: 26, height: 26, alignment: .center)
                            .padding(.leading, -8)
                        Text("Allow Analytics")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.label))
                            .padding(.leading, 4)
                    }
                }
                .onDisappear(perform: {
                    ACCommandsAnalyticsManager.shared.allow(analyticsAreAvailable)
                })
                .toggleStyle(SwitchToggleStyle(tint: Color(.systemTeal)))
                .padding(.trailing, -8)
            }
            if analyticsAreAvailable {
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
                            RuleMark(y: .value("Goal", dailyGoal))
                                .foregroundStyle(Color(.systemGreen).opacity(0.5))
                                .lineStyle(StrokeStyle(lineWidth: 1.25, dash: [4]))
                                .annotation(alignment: .leading) {
                                    Text("Goal")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color(.systemGreen).opacity(0.5))
                                        .padding(.leading, 4)
                                }
                            ForEach(viewDays) { viewDay in
                                BarMark(
                                    x: .value("Day", viewDay.date, unit: .day),
                                    y: .value("# of Articles", viewDay.articlesCount)
                                )
                                .foregroundStyle(Color(.systemTeal).gradient)
                                .cornerRadius(5)
                            }
                        }
                        .frame(height: 200)
                        .padding()
                        .chartYScale(domain: 0...((viewDays.max()?.articlesCount) ?? 6)+1)
                    }
                }
                Section(header: Text("Daily Goal".uppercased())) {
                    Stepper(value: $dailyGoal, in: 1...10, step: 1) {
                        HStack {
                            SettingsCellIcon(iconName: "chart.line.flattrend.xyaxis", tintColor: .systemGreen)
                                .frame(width: 26, height: 26, alignment: .center)
                                .padding(.leading, -4)
                            Text("Change Goal")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(.label))
                                .padding(.leading, 4)
                            Text("1-10")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    .frame(height: 36)
                    .padding(.trailing, -4)
                }
            }
        }
        .navigationBarTitle("Analytics".transformInTitle(), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(.label))
            }
        }
    }
}

struct ViewDay: Identifiable, Comparable, Codable {
    var id = UUID()
    let date: Date
    let articlesCount: Int
    var animate: Bool = false
    
    static func ==(lhs: ViewDay, rhs: ViewDay) -> Bool {
        return lhs.articlesCount == rhs.articlesCount
    }

    static func <(lhs: ViewDay, rhs: ViewDay) -> Bool {
        return lhs.articlesCount < rhs.articlesCount
    }
}

