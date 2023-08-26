//
//  IntroStateHelper.swift
//  ArduinoCommands
//
//  Created by User on 21.10.2022.
//

import Foundation
import SwiftUI

//MARK: - ViewModel protocol
protocol IntroViewModelProtocol {
    func hideIntro()
}


//MARK: - Main ViewModel
final class IntroViewModel: ObservableObject {
    
    //MARK: Public
    @Published
    public var viewIsHidden = false
    public let tintGradient = IntroContentStorage.Constants.UI.Gradients.tintGradient
    public let cards: [IntroCard] = IntroContentStorage.cards
}


//MARK: - ViewModel protocol extension
extension IntroViewModel: IntroViewModelProtocol {
    
    //MARK: Internal
    internal func hideIntro() {
        viewIsHidden = true
    }
}
