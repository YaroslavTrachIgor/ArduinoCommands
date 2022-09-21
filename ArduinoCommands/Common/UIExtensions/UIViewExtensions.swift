//
//  UIViewExtensions.swift
//  ArduinoCommands
//
//  Created by User on 04.08.2022.
//

import Foundation
import UIKit

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
