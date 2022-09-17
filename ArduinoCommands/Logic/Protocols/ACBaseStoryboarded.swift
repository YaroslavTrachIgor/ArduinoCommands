//
//  ACBaseStoryboarded.swift
//  ArduinoCommands
//
//  Created by User on 11.08.2022.
//

import Foundation
import UIKit

//MARK: - Main Storyboarded protocol
/**
 The protocol below wil be used for fast `Storyboard` `UIViewControllers` initianalization
 to proteсt application from possible crashes.
 
 This protocol will normally be used for the so called `Detail` VCs
 which will be shown after selecting the desired cell on `Menu` TableViewControllers.
 */
protocol ACBaseStoryboarded {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}


//MARK: - Preparing base values ​​for protocol Instances
extension ACBaseStoryboarded where Self: UIViewController {
    
    //MARK: Static
    static var storyboardName: String {
        AppDelegate.Keys.StoryboardNames.basicKnowledgeTab
    }
    
    static func instantiate() -> Self {
        let identifier = String(describing: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
