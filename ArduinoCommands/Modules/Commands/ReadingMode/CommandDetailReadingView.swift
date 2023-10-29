//
//  CommandDetailReadingView.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-03.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct CommandDetailReadingView: View {
    
    //MARK: Public
    var viewModel: CommandDetailReadingViewModel!
    
    //MARK: Private
    @State
    private var isContentAppearanceSheetPresented = false
    @StateObject
    private var themeManager = CommandReadingModeThemeManager()
    @Environment(\.presentationMode)
    private var presentationMode
    
    //MARK: View Configuration
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    topToolBar
                    
                    Divider()
                        .padding(.bottom, 8)
                    
                    CommandReadingModeSubtitleText(
                        text: viewModel.model.subtitle,
                        font: themeManager.subtitleFont,
                        foregroundColor: themeManager.secondaryForegroundColor
                    )
                    
                    title
                    
                    CommandReadingModeContentText(
                        text: viewModel.firstParagraph,
                        font: themeManager.contentFont(ofSize: themeManager.fontSize)!,
                        foregroundColor: themeManager.foregroundColor
                    )
                    CommandReadingModeSubtitleText(
                        text: "Details",
                        font: themeManager.subtitleFont,
                        foregroundColor: themeManager.secondaryForegroundColor
                    )
                    
                    detailsContent
                    detailsDescription
                    
                    CommandReadingModeContentText(
                        text: viewModel.secondParagraph,
                        font: themeManager.contentFont(ofSize: themeManager.fontSize)!,
                        foregroundColor: themeManager.foregroundColor
                    )
                    .padding([.top], 4)
                }
                .padding([.leading, .trailing], 20)
            }
            .background(Color(themeManager.backgroundColor!).edgesIgnoringSafeArea(.all))
        }
        .environmentObject(themeManager)
    }
}


//MARK: - Main properties
private extension CommandDetailReadingView {
    
    //MARK: Private
    var title: some View {
        Text(String(viewModel.model.name.removeScopes()).capitalizeFirstLetter())
            .font(Font(themeManager.titleFont))
            .foregroundColor(Color(themeManager.foregroundColor).opacity(0.88))
            .padding([.bottom], 1)
    }
    var topToolBar: some View {
        HStack {
            CommandReadingModeBarButton(action: {
                presentationMode.wrappedValue.dismiss()
            }, imageName: "arrow.down", foregroundColor: themeManager.foregroundColor, strokeColor: themeManager.secondaryForegroundColor)
            .padding(.leading, -8)
            
            Spacer()
            
            if #available(iOS 16.0, *) {
                CommandReadingModeBarButton(action: {
                    isContentAppearanceSheetPresented.toggle()
                }, imageName: "textformat.size", foregroundColor: themeManager.foregroundColor, strokeColor: themeManager.secondaryForegroundColor)
                .sheet(isPresented: $isContentAppearanceSheetPresented) {
                    CommandReadingModeAppearanceView(themeManager: themeManager)
                        .presentationDetents([.height(395)])
                        .presentationDragIndicator(.visible)
                }
            }
            
            CommandReadingModeBarButton(action: {
                ACPasteboardManager.copy(viewModel.model.baseDescription)
                ACGrayAlertManager.presentCopiedAlert(contentType: .article)
            }, imageName: "rectangle.portrait.on.rectangle.portrait", foregroundColor: themeManager.foregroundColor, strokeColor: themeManager.secondaryForegroundColor)
            .padding(.leading, 3)
            .padding(.trailing, -8)
        }
        .padding([.top], 25)
        .padding([.bottom], 4)
        .padding([.trailing, .leading], 2)
    }
    var detailsContent: some View {
        VStack(alignment: .leading) {
            CommandReadingModeSubheadlineText(text: "Syntax: ",
                                              font: themeManager.subheadlineFont,
                                              foregroundColor: themeManager.foregroundColor)
            CommandReadingModeDescriptionText(text: viewModel.model.details.syntax,
                                              font: themeManager.descriptionFont,
                                              foregroundColor: themeManager.secondaryForegroundColor)
            
            Divider()
                .padding([.trailing, .leading], 12)
            
            CommandReadingModeSubheadlineText(text: "Arguments: ",
                                              font: themeManager.subheadlineFont,
                                              foregroundColor: themeManager.foregroundColor)
            CommandReadingModeDescriptionText(text: viewModel.model.details.arguments,
                                              font: themeManager.descriptionFont,
                                              foregroundColor: themeManager.secondaryForegroundColor)
            
            Divider()
                .padding([.trailing, .leading], 12)
            
            CommandReadingModeSubheadlineText(text: "Returns: ",
                                              font: themeManager.subheadlineFont,
                                              foregroundColor: themeManager.foregroundColor)
            CommandReadingModeDescriptionText(text: viewModel.model.details.returns,
                                              font: themeManager.descriptionFont,
                                              foregroundColor: themeManager.secondaryForegroundColor)
                .padding([.bottom], 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color(themeManager.secondaryBackgroundColor))
        .cornerRadius(CGFloat.Corners.baseACSecondaryRounding - 6)
        .overlay(
            RoundedRectangle(cornerRadius: CGFloat.Corners.baseACSecondaryRounding - 6)
                .stroke(Color(themeManager.foregroundColor).opacity(0.2), lineWidth: 1)
        )
    }
    var detailsDescription: some View {
        Text("In this section, study the possible arguments, syntax, and return values of the command for its proper use in your code.")
            .padding([.top], 2)
            .font(.caption)
            .foregroundColor(Color(.separator))
            .padding([.leading, .trailing], 12)
    }
}
