//
//  IntroTabView.swift
//  ArduinoCommands
//
//  Created by User on 05.09.2022.
//

import Foundation
import SwiftUI

//MARK: - Main View
struct IntroTabView: View {
    
    //MARK: Private
    @EnvironmentObject
    private var viewModel: IntroViewModel
    
    //MARK: View Configuration
    var body: some View {
        VStack {
            TabView {
                ForEach(viewModel.cards) { card in
                    IntroCardView(card: card, tintGradient: viewModel.tintGradient)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}
