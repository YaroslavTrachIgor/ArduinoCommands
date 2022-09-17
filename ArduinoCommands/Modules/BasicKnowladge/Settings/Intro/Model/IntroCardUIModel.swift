//
//  IntroCardViewModel.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - ViewModel protocol
protocol IntroCardUIModelProtocol: Identifiable {
    var title: String! { get }
    var subtitle: String! { get }
    var content: String! { get }
    var backgroundGradient: Gradient! { get }
}


//MARK: - Keys
extension IntroCardUIModel {
    
    //MARK: Public
    enum Keys {
        enum UI {
            enum Gradients {
                
                //MARK: Static
                /**
                 /////////////////////////////////
                 */
                static let intoTintColorGradient = Gradient(colors: [
                    Color(uiColor: UIColor(hexString: "#fc92a8").withAlphaComponent(0.80)),
                    Color(uiColor: UIColor(hexString: "#6764FF").withAlphaComponent(0.75))
                ])
            }
        }
    }
}


//MARK: - Main ViewModel
public struct IntroCardUIModel: Identifiable {
    
    //MARK: Identifiable protocol
    public var id: ObjectIdentifier = ObjectIdentifier(IntroCardUIModel.self)
    
    
    //MARK: Public
    var model: ACIntroCard?
}


//MARK: - ViewModel protocol extension
extension IntroCardUIModel {
    
    //MARK: Internal
    internal var title: String! {
        model?.title!
    }
    internal var subtitle: String! {
        model?.subtitle?.uppercased()
    }
    internal var content: String! {
        model?.content!
    }
}
