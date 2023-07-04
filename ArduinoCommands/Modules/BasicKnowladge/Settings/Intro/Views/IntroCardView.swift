//
//  IntroCardView.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct IntroCardView: View {
    
    //MARK: Public
    @State var card: ACIntroCard
    
    //MARK: Private
    private var tintGradient: Gradient {
        return ACIntroStorage.Constants.UI.Gradients.tintGradient
    }
    
    //MARK: View Configuration
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
            .overlay(introCardStrokeView)
            .background(introCardBackgroundView)
            .padding(40)
        }
    }
}


//MARK: - Main properties
private extension IntroCardView {
    
    //MARK: Private
    var introCardTitle: some View {
        Text(card.title!)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    var introCardSubtitle: some View {
        Text(card.subtitle!.uppercased())
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(.secondary)
    }
    var introCardContent: some View {
        Text(card.content!)
            .font(Font(UIFont.ACFont(style: .articleContent)))
            .lineSpacing(7.5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary.opacity(0.6))
            .padding(.trailing, 50)
    }
    var introCardGradientTitle: some View {
        LinearGradient(
            gradient: tintGradient,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(height: 140)
        .mask(introCardTitle)
    }
    var introCardCloseButton: some View {
        IntroCloseButton()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 25)
            .padding(.bottom, 0)
    }
    var introCardStrokeView: some View {
        introCardbaseMask
            .stroke(Color.white.opacity(0.8), lineWidth: 0.8)
            .blendMode(.overlay)
            .overlay(
                introCardbaseMask
                    .stroke(Color.white, lineWidth: 3)
                    .blur(radius: 25)
            )
    }
    var introCardBackgroundView: some View {
        ACBaseVisualEffectView(visualEffect: UIBlurEffect(style: .regular))
            .mask(introCardbaseMask)
    }
    var introCardbaseMask: RoundedRectangle {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
    }
}
