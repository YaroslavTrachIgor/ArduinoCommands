//
//  ACBaseVisualEffectView.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI
import UIKit

//MARK: - Fast VisualEffect View for `SwiftUI` setup
public struct ACBaseVisualEffectView: UIViewRepresentable {
    
    //MARK: Public
    var visualEffect: UIVisualEffect?
    
    
    //MARK: Lifecycle
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = visualEffect }
}
