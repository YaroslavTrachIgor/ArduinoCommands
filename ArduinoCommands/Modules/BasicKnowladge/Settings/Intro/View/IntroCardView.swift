//
//  IntroCardView.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Keys
private extension IntroCardView {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Text {
                
                //MARK: Static
                static let contentForeground = Color(uiColor: .label.withAlphaComponent(0.55))
                static let subtitleForeground = Color(uiColor: .secondaryLabel.withAlphaComponent(0.65))
            }
            enum Gradients {
                
                //MARK: Static
                static let contentBackGradient = Gradient(colors: [
                    Color.white.opacity(0.065),
                    Color.white.opacity(0.025),
                    Color.white.opacity(0.045)
                ])
            }
        }
    }
}


//MARK: - Main View
struct IntroCardView: View {
    
    //MARK: Public
    @State var card: IntroCardUIModel
    
    
    //MARK: View preparations
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                introCardSubtitle

                introCardGradientTitle
                
                introCardContent
                
                introCardCloseButton
            }
            .padding(30)
            .mask(introCardbaseMask)
            .overlay(
                introCardbaseMask
                    .stroke(Color.white.opacity(0.5), lineWidth: 0.8)
                    .blendMode(.overlay)
                    .overlay(
                        introCardbaseMask
                            .stroke(introCardLinearGradient, lineWidth: 3)
                            .blur(radius: 25)
                    )
            )
            .background(
                introCardLinearGradient
                    .mask(introCardbaseMask)
            )
            .background(introCardBackgroundView)
            .padding(40)
        }
    }
}


//MARK: - Main properties
private extension IntroCardView {
    
    //MARK: Private
    var introCardTitle: some View {
        Text(card.title)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    var introCardSubtitle: some View {
        Text(card.subtitle.uppercased())
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(Keys.UI.Text.contentForeground)
    }
    var introCardContent: some View {
        Text(card.content)
            .font(Font(UIFont.systemFont(ofSize: 15.5, weight: .regular)))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Keys.UI.Text.contentForeground)
            .padding(.trailing, 30)
    }
    var introCardGradientTitle: some View {
        LinearGradient(
            gradient: IntroCardUIModel.Keys.UI.Gradients.intoTintColorGradient,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(height: 140)
        .mask(introCardTitle)
    }
    var introCardCloseButton: some View {
        IntroCloseButton(card: card)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 25)
            .padding(.bottom, 0)
    }
    var introCardBackgroundView: some View {
        ACBaseVisualEffectView(visualEffect: UIBlurEffect(style: .regular))
            .mask(introCardbaseMask)
    }
    
    //MARK: Reusable
    var introCardLinearGradient: LinearGradient {
        LinearGradient(
            gradient: Keys.UI.Gradients.contentBackGradient,
            startPoint: .top,
            endPoint: .bottom
        )
    }
    var introCardbaseMask: RoundedRectangle {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
    }
}
