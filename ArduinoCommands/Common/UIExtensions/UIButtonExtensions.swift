//
//  UIButtonExtensions.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 28.03.2022.
//

import Foundation
import UIKit

//MARK: - Setup base Button types
public extension UIButton {
    
    //MARK: Public
    func setupCostomBarButton(imageSystemName: String) {
        let backgroundColor: UIColor = .systemGray5.withAlphaComponent(0.08)
        let cornerRadius = (frame.height / 2) - 4
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        tintColor = .label
    }
    
    func setupDarkBarButton(imageSystemName: String) {
        let shadowRadius: CGFloat = 10
        let shadowOffset = CGSize(width: 6, height: 6)
        let cornerRadius = frame.height / 2 - 1
        let shadowColor = UIColor.systemGray.cgColor
        setupCostomBarButton(imageSystemName: imageSystemName)
        layer.shadowOpacity = 0.15
        layer.cornerRadius = cornerRadius
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor
        backgroundColor = .black
        tintColor = .white
    }
}


//MARK: - Fast Button methods
extension UIButton {
    
    //MARK: Public
    func addBlurEffect() {
        let cornerRadius = frame.height / 2
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blur.isUserInteractionEnabled = false
        blur.layer.cornerRadius = cornerRadius
        blur.clipsToBounds = true
        blur.frame = bounds
        insertSubview(blur, at: 0)
        if let imageView = self.imageView {
            bringSubviewToFront(imageView)
        }
    }
}



//MARK: - Setup basic Button configuration types
public extension UIButton.Configuration {
    
    //MARK: Public
    mutating func setupFastButtonConfiguration(title: AttributedString,
                                               subtitle: AttributedString = AttributedString(""),
                                               image: UIImage? = nil,
                                               backgroundColor: UIColor?,
                                               foregroundColor: UIColor) {
        self.image = image
        baseForegroundColor = foregroundColor
        attributedSubtitle = title
        attributedTitle = subtitle
        imagePadding = 10
        cornerStyle = .large
        /**
         In this function, we need to make it possible to not use the `backgroundColor`,
         because some new button types(for example, `.gray` ones) introduced in iOS 15
         should not be subject to changes in some parameters.
         */
        if backgroundColor != nil {
            baseBackgroundColor = backgroundColor
        }
    }
}
