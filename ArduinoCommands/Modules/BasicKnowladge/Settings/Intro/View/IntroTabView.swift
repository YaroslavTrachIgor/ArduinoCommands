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
    private var cards: [IntroCardUIModel] {
        return ACIntroStorage.cards
    }
    
    
    //MARK: View preparations
    var body: some View {
        VStack {
            TabView {
                IntroCardView(card: cards[0])
                IntroCardView(card: cards[1])
                IntroCardView(card: cards[2])
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}
