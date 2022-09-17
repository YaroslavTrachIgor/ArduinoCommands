//
//  UILabelExtensions.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.05.2022.
//

import Foundation
import UIKit

//MARK: - Basic constnts for Label types properties setup
public enum ACLabelConstants {
    
    //MARK: Public
    enum DecorationLabels {
        enum Content {
            
            //MARK: Static
            static let method = "Method"
            static let library = "Library"
            static let initial = "Initial"
            static let devices = "Devices"
            static let returns = "Returns"
        }
        enum Colors {
            
            //MARK: Static
            static let method = UIColor.systemIndigo
            static let library = UIColor.systemBlue
            static let initial = UIColor.systemTeal
            static let devices = UIColor.systemPurple
            static let returns = UIColor.systemPink
        }
    }
}


public enum DecorationLabelType {
    case method
    case initial
    case library
    case returns
    case withDevices
}




//MARK: - Setup basic Label types
public extension UILabel {
    
    //MARK: Public
    func setupDecorationRoleLabel(content: String, tintColor: UIColor = .systemIndigo, with needed: Bool = true) {
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
         
         If model fits to the characteristic, we will make the labels alpha equals to 1.
         In the another case the alpha of the label will be 0,
         so the label will not be visible for user.
         */
        if needed {
            alpha = 1
        }
    }
    
    func setupRightDecoLabel(labelType: DecorationLabelType, if needed: Bool!) {
        switch labelType {
        case .returns:
            let content = ACLabelConstants.DecorationLabels.Content.returns
            let tintColor = ACLabelConstants.DecorationLabels.Colors.returns
            setupDecorationRoleLabel(content: content, tintColor: tintColor, with: needed)
        default:
            return
        }
    }
    
    
    
    
    func setupMethodDecoLabel(with needed: Bool! = true) {
        let content = ACLabelConstants.DecorationLabels.Content.method
        let tintColor = ACLabelConstants.DecorationLabels.Colors.method
        setupDecorationRoleLabel(content: content, tintColor: tintColor)
    }
    
    func setupLibraryDecoLabel(with needed: Bool! = true) {
        let content = ACLabelConstants.DecorationLabels.Content.library
        let tintColor = ACLabelConstants.DecorationLabels.Colors.library
        setupDecorationRoleLabel(content: content, tintColor: tintColor, with: needed)
    }
    
    func setupReturnsDecoLabel(with needed: Bool!) {
        let content = ACLabelConstants.DecorationLabels.Content.returns
        let tintColor = ACLabelConstants.DecorationLabels.Colors.returns
        setupDecorationRoleLabel(content: content, tintColor: tintColor, with: needed)
    }
    
    func setupDevicesDecoLabel(with needed: Bool!) {
        let content = ACLabelConstants.DecorationLabels.Content.devices
        let tintColor = ACLabelConstants.DecorationLabels.Colors.devices
        setupDecorationRoleLabel(content: content, tintColor: tintColor, with: needed)
    }
    
    func setupInitialDecoLabel(with needed: Bool!) {
        let content = ACLabelConstants.DecorationLabels.Content.initial
        let tintColor = ACLabelConstants.DecorationLabels.Colors.initial
        setupDecorationRoleLabel(content: content, tintColor: tintColor, with: needed)
    }
}
