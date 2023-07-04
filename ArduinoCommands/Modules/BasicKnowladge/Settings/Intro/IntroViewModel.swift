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
    
    //MARK: Published
    @Published var viewIsHidden = false
}


//MARK: - ViewModel protocol extension
extension IntroViewModel: IntroViewModelProtocol {
    
    //MARK: Internal
    internal func hideIntro() {
        viewIsHidden = true
    }
}
