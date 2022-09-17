//
//  IntroCloseButton.swift
//  ArduinoCommands
//
//  Created by User on 16.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Keys
private extension IntroCloseButton {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Button {
                
                //MARK: Static
                static let closeButtonTitle = "Close"
            }
        }
    }
}


//MARK: - Main View
struct IntroCloseButton: View {
    
    //MARK: Public
    @State var card: IntroCardUIModel
    
    //MARK: @EnvironmentObject
    @EnvironmentObject var stateHelper: SettingsStateHelper
    
    
    //MARK: View preparations
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
        Text(Keys.UI.Button.closeButtonTitle.uppercased())
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 13, weight: .medium))
    }
    
    //MARK: Reusable
    var introLinearGradient: LinearGradient {
        LinearGradient(
            gradient: IntroCardUIModel.Keys.UI.Gradients.intoTintColorGradient,
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
