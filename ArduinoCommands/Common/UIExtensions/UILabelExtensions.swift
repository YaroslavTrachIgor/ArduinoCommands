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


//MARK: - Deco Labels Scale Types
public enum DecoLabelScaleType {
    case regular
    case small
}


//MARK: - Fast Label methods
public extension UILabel {
    
    //MARK: Public
    func setupDecorationRoleLabel(content: String, tintColor: UIColor = .systemIndigo, if needed: Bool = true, fontSize: CGFloat = 13, cornerRadius: CGFloat = 6) {
        let backColor = tintColor.withAlphaComponent(0.16)
        let font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        self.font = font
        text = "#" + content.uppercased()
        textColor = tintColor
        layer.cornerRadius = cornerRadius
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
    func setupMethodDecoLabel(with needed: Bool! = true, scaleType: DecoLabelScaleType = .regular) {
        let labelType: DecoLabelType = .method
        let content = setupDecoLabelTitle(with: labelType)
        let fontSize = setupDecoLabelFontSize(with: scaleType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        let cornerRadius = setupDecoLabelCornerRadius(with: scaleType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, fontSize: fontSize, cornerRadius: cornerRadius)
    }
    
    func setupLibraryDecoLabel(with needed: Bool! = true, scaleType: DecoLabelScaleType = .regular) {
        let labelType: DecoLabelType = .library
        let content = setupDecoLabelTitle(with: labelType)
        let fontSize = setupDecoLabelFontSize(with: scaleType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        let cornerRadius = setupDecoLabelCornerRadius(with: scaleType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed, fontSize: fontSize, cornerRadius: cornerRadius)
    }
    
    func setupReturnsDecoLabel(with needed: Bool!, scaleType: DecoLabelScaleType = .regular) {
        let labelType: DecoLabelType = .returns
        let content = setupDecoLabelTitle(with: labelType)
        let fontSize = setupDecoLabelFontSize(with: scaleType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        let cornerRadius = setupDecoLabelCornerRadius(with: scaleType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed, fontSize: fontSize, cornerRadius: cornerRadius)
    }
    
    func setupDevicesDecoLabel(with needed: Bool!, scaleType: DecoLabelScaleType = .regular) {
        let labelType: DecoLabelType = .devices
        let content = setupDecoLabelTitle(with: labelType)
        let fontSize = setupDecoLabelFontSize(with: scaleType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        let cornerRadius = setupDecoLabelCornerRadius(with: scaleType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed, fontSize: fontSize, cornerRadius: cornerRadius)
    }
    
    func setupInitialDecoLabel(with needed: Bool!, scaleType: DecoLabelScaleType = .regular) {
        let labelType: DecoLabelType = .initial
        let content = setupDecoLabelTitle(with: labelType)
        let fontSize = setupDecoLabelFontSize(with: scaleType)
        let tintColor = setupDecoLabelTintColor(with: labelType)
        let cornerRadius = setupDecoLabelCornerRadius(with: scaleType)
        setupDecorationRoleLabel(content: content, tintColor: tintColor, if: needed, fontSize: fontSize, cornerRadius: cornerRadius)
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
    
    /// This prepares a font size for the Command Keyword label.
    /// - Parameter type: command keyword label scale type.
    /// - Returns: deco label font size.
    fileprivate func setupDecoLabelFontSize(with type: DecoLabelScaleType) -> CGFloat {
        switch type {
        case .regular:
            return 13
        case .small:
            return 10
        }
    }
    
    /// This prepares a corner radius for the Command Keyword label.
    /// - Parameter type: command keyword label scale type.
    /// - Returns: deco label corner radius.
    fileprivate func setupDecoLabelCornerRadius(with type: DecoLabelScaleType) -> CGFloat {
        switch type {
        case .regular:
            return 7
        case .small:
            return 5.6
        }
    }
}
