//
//  IntroStateHelper.swift
//  ArduinoCommands
//
//  Created by User on 21.10.2022.
//

import Foundation
import SwiftUI

//MARK: - Intro navigation State Helper
final class IntroStateHelper: ObservableObject {
    
    //MARK: @Published
    /**
     The varible below is needed for costom transitions
     between `Views` in SwiftUI files.
     
     We will use Intro State Helper properties in order to
     hide `IntroView` using `onReceive` method.
     */
    @Published var viewIsHidden: Bool = false
}
