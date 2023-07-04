//
//  UILabelExtensions.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.05.2022.
//

import Foundation
import UIKit

//MARK: - Deco Labels Types
private enum DecoLabelType {
    case method
    case initial
    case devices
    case returns
    case library
}


//MARK: - Fast Label methods
public extension UILabel {
    
    //MARK: Public
    func setupDecorationRoleLabel(content: String, tintColor: UIColor = .systemIndigo, if needed: Bool = true) {
        let backColor = tintColor.withAlphaComponent(0.16)
        let font = UIFont.systemFont(ofSize: 13, weight: .light)
        self.font = font
        text = "#" + content.uppercased()
        textColor = tintColor
        layer.cornerRadius = 6
        layer.masksToBounds = true
        backgroundColor = backColor
        alpha = 0
        /**
         In the code below, we use a special needed property.
         To not make every characteristic visible, we will use `needed` property.
         
         If model fits to the characteristic, we  make the labels alpha equals to 1.
         In the another case the alpha of the label will be 0,
         so the label will not be visible for user.
         */
        if needed {
            alpha = 1
        }
    }
}


//MARK: - Setup basic Label types
public extension UILabel {
    
    //MARK: Public
    func setupMethodDecoLabel(with needed: Bool! = true) {
        let labelType: DecoLabelType = .method
        let content = setupDecoLabelTitle(with: labelType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor)
    }
    
    func setupLibraryDecoLabel(with needed: Bool! = true) {
        let labelType: DecoLabelType = .library
        let content = setupDecoLabelTitle(with: labelType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed)
    }
    
    func setupReturnsDecoLabel(with needed: Bool!) {
        let labelType: DecoLabelType = .returns
        let content = setupDecoLabelTitle(with: labelType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed)
    }
    
    func setupDevicesDecoLabel(with needed: Bool!) {
        let labelType: DecoLabelType = .devices
        let content = setupDecoLabelTitle(with: labelType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed)
    }
    
    func setupInitialDecoLabel(with needed: Bool!) {
        let labelType: DecoLabelType = .initial
        let content = setupDecoLabelTitle(with: labelType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed)
    }
    
    
    //MARK: Fast methods
    /// This prepares a basic title for the Command Keyword label.
    /// - Parameters:
    ///   - type: command key type.
    /// - Returns: basic unedited command keyword.
    fileprivate func setupDecoLabelTitle(with type: DecoLabelType) -> String {
        switch type {
        case .method:
            return "Method"
        case .initial:
            return "Initial"
        case .devices:
            return "Devices"
        case .returns:
            return "Returns"
        case .library:
            return "Library"
        }
    }
    
    /// This prepares a tint color for the Command Keyword label.
    /// - Parameters:
    ///   - type: command key type.
    /// - Returns:deco label tint color.
    fileprivate func setupDecoLabelTintColor(with type: DecoLabelType) -> UIColor {
        switch type {
        case .method:
            return .systemIndigo
        case .initial:
            return .systemTeal
        case .devices:
            return .systemPurple
        case .returns:
            return .systemPink
        case .library:
            return .systemBlue
        }
    }
}
