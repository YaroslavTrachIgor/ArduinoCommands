//
//  IntroBackgroundView.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Keys
private extension IntroBackgroundView {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Image {
                
                //MARK: Static
                static let introBackgroundName = "intro-background"
            }
        }
    }
}


//MARK: - Main Intro background View
struct IntroBackgroundView: View {
    
    //MARK: View preparations
    var body: some View {
        Image(Keys.UI.Image.introBackgroundName)
            .resizable()
            .background(Color(uiColor: .white))
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}
