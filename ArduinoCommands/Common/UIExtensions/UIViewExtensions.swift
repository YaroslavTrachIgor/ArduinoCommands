//
//  UIViewExtensions.swift
//  ArduinoCommands
//
//  Created by User on 04.08.2022.
//

import Foundation
import UIKit

//MARK: - Menu Background cases
public enum MenuBackgroundType {
    case table
    case secondary
    
}

//MARK: - Setup basic View types
public extension UIView {
    
    //MARK: Public
    /// This sets the basic needed properties for Menu Views(root VCs with lists)
    /// in order to observe `DRY` principle.
    /// - Parameter backgroundType: case of background color.
    func setupBasicMenuBackgroundView(_ backgroundType: MenuBackgroundType = .table) {
        switch backgroundType {
        case .table:
            backgroundColor = UIColor.ACTable.backgroundColor
        case .secondary:
            backgroundColor = .secondarySystemBackground
        }
        tintColor = .label
        alpha = 1
    }
}

//MARK: - Fast View methods
public extension UIView {
    
    //MARK: Public
    /// This sets a simple light border with opacity on different blured `View`s
    /// in oreder to creare an atmosphere of `Glassmorphism`.
    /// - Parameters:
    ///   - width: border width(with a default value of 0.2);
    ///   - color: border color(with a default white value).
    func setFastGlassmorphismBorder(width: CGFloat = 0.2, color: UIColor = .white) {
        let borderColor = color.withAlphaComponent(0.25).cgColor
        layer.borderColor = borderColor
        layer.borderWidth = width
    }
}
