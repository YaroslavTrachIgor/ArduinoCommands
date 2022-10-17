//
//  IntroCloseButton.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct IntroCloseButton: View {
    
    //MARK: Private
    @EnvironmentObject
    private var stateHelper: SettingsStateHelper
    private var tintGradient: Gradient {
        return ACIntroStorage.Constants.UI.Gradients.tintGradient
    }
    
    //MARK: View Configuration
    var body: some View {
        VStack {
            Button {
                moveToRoot()
            } label: {
                introLinearGradient
                    .mask(introCloseButtonTitle)
                    .frame(height: 140)
            }
            .frame(width: 80, height: 30, alignment: .center)
            .overlay(introCloseButtonShape)
        }
    }
}


//MARK: - Main properties
private extension IntroCloseButton {
    
    //MARK: Private
    var introCloseButtonShape: some View {
        Capsule()
            .stroke(introLinearGradient, lineWidth: 1.3)
    }
    var introCloseButtonTitle: some View {
        Text("Close".uppercased())
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 13, weight: .medium))
    }
    var introLinearGradient: LinearGradient {
        LinearGradient(
            gradient: tintGradient,
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}


//MARK: - Main methods
private extension IntroCloseButton {
    
    //MARK: Private
    func moveToRoot() {
        stateHelper.movedToRoot = true
    }
}
