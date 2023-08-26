//
//  DailyGoalProgressView.swift
//  ArduinoCommands
//
//  Created by User on 2023-07-27.
//

import Foundation
import SwiftUI

//MARK: - Constants
private extension DailyReadingProgressView {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Text {
                
                //MARK: Static
                static let title = "Today's Reading"
                static let footer = "Read daily and set new records."
                static let headline = "Reading Goals"
                static let subheadline = "Read every day, see your stats soar, and finish more articles."
            }
            enum Button {
                
                //MARK: Static
                static let analyticsLinkTitle = "Go to Analytics"
                static let keepReadingTitle = "Keep Reading"
            }
            enum Image {
                
                //MARK: Static
                static let linkIconName = "chevron.right"
            }
        }
    }
}


//MARK: - Main View
struct DailyReadingProgressView: View {
    
    //MARK: Public
    @State
    var isOpenedFromSettings = true
    
    //MARK: Private
    @State
    private var isPresentingAnalytics = false
    @StateObject
    private var viewModel = DailyReadingProgressViewModel()
    
    //MARK: View Configuration
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                if isOpenedFromSettings {
                    Divider()
                }
                headline
                subheadline
                dailyReadingProgressView
                keepReadingButton
                weekReadingProgressView
                if !isOpenedFromSettings, #available(iOS 16.0, *) {
                    analyticsLinkButton
                }
                footer
                if isOpenedFromSettings {
                    Divider()
                }
            }
        }
        .padding(.top, 0)
        .frame(alignment: .top)
        .listRowBackground(Color.clear)
    }
}


//MARK: - Main properties
private extension DailyReadingProgressView {
    
    //MARK: Private
    var headline: some View {
        Text(Constants.UI.Text.headline)
            .font(Font(UIFont.ACFont(ofSize: 22, weight: .bold)))
            .foregroundColor(Color(.label))
            .padding(.bottom, 0.5)
            .padding(.top, 14)
    }
    var subheadline: some View {
        Text(Constants.UI.Text.subheadline)
            .foregroundColor(.secondary)
            .font(Font.system(size: 13.5, weight: .regular))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding([.leading, .trailing], 8)
            .padding(.bottom, 18)
    }
    var footer: some View {
        Text(Constants.UI.Text.footer)
            .foregroundColor(.secondary)
            .font(Font.system(size: 13.5, weight: .regular))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 8)
    }
    var dailyReadingProgressTitle: some View {
        Text(Constants.UI.Text.title)
            .font(Font(UIFont.ACFont(ofSize: 16.5, weight: .bold)))
            .padding(.bottom, 0.2)
            .padding(.top, -2)
    }
    var articlesCountTitle: some View {
        Text(String(viewModel.articlesCount))
            .font(Font(UIFont.ACFont(ofSize: 56, weight: .bold)))
            .padding(.bottom, 0.2)
    }
    var articlesCountFooter: some View {
        Text(viewModel.articlesCountFooter())
            .foregroundColor(Color(.label))
            .font(Font.system(size: 14, weight: .regular, design: .rounded))
    }
    var dailyReadingProgressView: some View {
        ZStack {
            DailyReadingProgressBar(progress: viewModel.dailyReadingProgressRatio, lineWidth: 8.0)
                .frame(width: 250.0, height: 250.0)
            VStack {
                dailyReadingProgressTitle
                articlesCountTitle
                articlesCountFooter
            }
        }
        .padding(.bottom, -50)
    }
    var weekReadingProgressView: some View {
        HStack {
            ForEach(viewModel.weekViewDays()) { viewDay in
                ZStack {
                    DailyReadingProgressBar(progress: viewModel.progressRatio(for: viewDay), lineWidth: 3.5)
                        .frame(width: 30, height: 30)
                    Text(viewModel.weekDayLetter(for: viewDay))
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .padding([.trailing, .leading], 12)
            }
        }
        .padding(.top, 8)
    }
    var keepReadingButton: some View {
        Button(action: {}, label: {
            VStack(spacing: 4) {
                Text(Constants.UI.Button.keepReadingTitle)
                    .font(Font.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(.systemBackground))
                Text(viewModel.lastReadArticleName)
                    .font(Font.system(size: 12, weight: .medium))
                    .foregroundColor(Color(.secondarySystemBackground))
            }
            .frame(width: 260, height: 53)
        })
        .background(Color(.label))
        .cornerRadius(26)
        .padding(.top, 0)
    }
    @available(iOS 16.0, *)
    var analyticsLinkButton: some View {
        Button(action: {
            isPresentingAnalytics = true
        }, label: {
            HStack {
                Text(Constants.UI.Button.analyticsLinkTitle)
                    .foregroundColor(Color(.label))
                    .font(Font.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Image(systemName: Constants.UI.Image.linkIconName)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(Font.system(size: 10, weight: .regular))
            }
        })
        .sheet(isPresented: $isPresentingAnalytics, content: { AnalyticsView() })
    }
}
