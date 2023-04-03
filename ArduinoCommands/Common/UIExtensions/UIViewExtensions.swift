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
    func setFastGlassmorphismBorder(width: CGFloat = 0.2,
                                    color: UIColor = .white) {
        let borderColor = color.withAlphaComponent(0.25).cgColor
        layer.borderColor = borderColor
        layer.borderWidth = width
    }
    
    /// This sets up special rounding buttons with blured background.
    /// The function is usually used in `UICollectionViewController` files as a
    /// costom view for `UIBarButtonItem`.
    /// - Parameters:
    ///   - action: @objc method that will be called when button is tapped;
    ///   - width: button's width;
    ///   - height: button's height;
    ///   - imageName: optional button's image system icon name;
    ///   - title: optional button title;
    ///   - vc: target;
    func setupFastImageCollectionViewBarView(action: Selector?,
                                             width: CGFloat = 35,
                                             height: CGFloat = 35,
                                             imageName: String?,
                                             font: UIFont?,
                                             title: String?,
                                             for vc: UIViewController) {
        let viewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        frame = viewFrame
        
        /**
         We cannot use `UIButton` as a costom view for `UIBarButtonItem`.
         That's why we, first of all, set up view's frame(see the code above) and then add the button as a subview.
         */
        let button = UIButton.init(type: .system)
        button.frame = self.frame
        
        let autoresizingMask: UIView.AutoresizingMask = [.flexibleWidth, .flexibleHeight]
        let backgroundColor: UIColor = .systemGray.withAlphaComponent(0.5)
        let buttonHeight = button.frame.height / 2
        button.addBlurEffect(cornerRadius: buttonHeight, style: .regular)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = buttonHeight
        button.autoresizesSubviews = true
        button.autoresizingMask = autoresizingMask
        button.tintColor = .white
        /**
         In the code below,
         */
        if font != nil {
            button.titleLabel?.font = font
        }
        if title != nil {
            button.setTitle(title, for: .normal)
        }
        if action != nil { button.addTarget(vc, action: action!, for: .touchUpInside) }
        if imageName != nil {
            let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 0, weight: .medium, scale: .medium)
            let image = UIImage(systemName: imageName!)
            let configuratedImage = image?.withConfiguration(imageConfiguration)
            button.setImage(configuratedImage, for: .normal)
        }
        addSubview(button)
    }
}
