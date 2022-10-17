//
//  IntroBackgroundView.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct IntroBackgroundView: View {
    var body: some View {
        Image("intro-background")
            .resizable()
            .background(Color(uiColor: .white))
            .ignoresSafeArea()
            .padding(.trailing, -70)
    }
}
