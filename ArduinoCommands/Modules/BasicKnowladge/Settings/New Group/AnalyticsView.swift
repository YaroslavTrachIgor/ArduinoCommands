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
struct AnalyticsView: View {
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    @StateObject
    private var viewModel = AnalyticsViewModel()
    
    //MARK: View Configuration
    var body: some View {
        Form {
            analyticsParametersSection
            if viewModel.analyticsAvailable {
                DailyReadingProgressView()
                    .padding([.bottom, .top], -25)
                    .frame(height: 445)
                analyticsChartSection
                analyticsDailyGoalSection
            }
        }
        .onDisappear(perform: { viewModel.onDisappear() })
        .navigationBarTitle("Analytics".transformInTitle(), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: ACNavigationBackButton(completion: {
            presentationMode.wrappedValue.dismiss()
        }))
    }
}


//MARK: - Main properties
@available(iOS 16.0, *)
private extension AnalyticsView {
    
    //MARK: Private
    var analyticsParametersSection: some View {
        Section(header: Text("Parameters".uppercased()),
                footer: Text("After turning off Personal Analytics, data on your reading progress will no longer be collected. \n\n*However, you cannot view the progress for the days when analytics was turned off.*")) {
            Toggle(isOn: $viewModel.analyticsAvailable.animation(.easeInOut(duration: 0.4))) {
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
            .toggleStyle(SwitchToggleStyle(tint: Color(.systemTeal)))
            .padding(.trailing, -8)
        }
    }
    var analyticsChartSection: some View {
        Section(header: Text("Daily Progress"),
                footer: Text("View your daily progress in learning Arduino commands.\n\nAn article read by you on a certain day would be counted towards the total number of articles read per day if you spent more than one minute studying it.")) {
            VStack(alignment: .leading) {
                analyticsChartLabels
                analyticsChartView
            }
        }
    }
    var analyticsChartLabels: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Command Articles Views")
                    .font(Font.system(.footnote, design: .rounded, weight: .regular))
                    .foregroundColor(.secondary)
                Spacer()
                Text("Daily Average: \(viewModel.countDailyAverage())")
                    .font(Font.system(.footnote, design: .rounded, weight: .medium))
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Total: \(viewModel.countTotalViews())")
                    .font(Font.system(.title, design: .rounded, weight: .bold))
                    .foregroundColor(Color(.label))
                Spacer()
                Image(systemName: viewModel.setupGraphProgressIndicatorImageName())
                    .foregroundColor(Color(viewModel.setupGraphProgressIndicatorForegroundColor()))
                    .fontWeight(.semibold)
                    .frame(width: 35, height: 35)
                    .padding(.trailing, -12)
                Text(String(format: "%.1f", viewModel.countViewsPercentageGrow()) + "%")
                    .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(viewModel.setupGraphProgressIndicatorForegroundColor()))
            }
            .padding(.top, -8)
        }
        .padding(.bottom, -12)
    }
    var analyticsChartView: some View {
        VStack(alignment: .leading) {
            Chart {
                RuleMark(y: .value("Goal", viewModel.dailyGoal))
                    .foregroundStyle(Color(.systemGreen).opacity(0.5))
                    .lineStyle(StrokeStyle(lineWidth: 1.25, dash: [4]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(.systemGreen).opacity(0.5))
                            .padding(.leading, 4)
                    }
                ForEach(viewModel.viewDays) { viewDay in
                    LineMark(
                        x: .value("Day", viewDay.date, unit: .day),
                        y: .value("ViewDay", viewDay.articlesCount)
                    )
                }
                .foregroundStyle(Gradient(colors: [Color(.systemTeal), Color(.systemTeal).opacity(0.3)]))
                .interpolationMethod(.cardinal)
                .symbol(Circle())
            }
            .frame(height: 200)
            .padding()
            .chartYScale(domain: 0...viewModel.countMaxDomainValue())
        }
    }
    var analyticsDailyGoalSection: some View {
        Section(header: Text("Daily Goal".uppercased()), footer: Text("Set your personal goals of reading a specific amount of articles per day and track your achievements on the graph.")) {
            Stepper(value: $viewModel.dailyGoal, in: 1...10, step: 1) {
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
