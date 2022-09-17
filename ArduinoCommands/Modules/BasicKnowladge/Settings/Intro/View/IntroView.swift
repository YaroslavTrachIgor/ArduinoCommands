//
//  IntroView.swift
//  ArduinoCommands
//
//  Created by User on 13.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct IntroView: View {
    
    //MARK: View preparations
    var body: some View {
        ZStack {
            IntroTabView()
        }
        .background(IntroBackgroundView())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
