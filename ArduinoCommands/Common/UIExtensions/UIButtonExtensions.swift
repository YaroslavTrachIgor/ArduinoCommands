//
//  UIButtonExtensions.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 28.03.2022.
//

import Foundation
import UIKit

//MARK: - Details Button Type cases
public enum DetailsButtonType {
    case dark
    case light
}


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
    
    func setupCodeContentEditingButton(tintColor: UIColor = .white,
                                       imageName: String,
                                       pointSize: CGFloat = 12.8) {
        let borderColor = tintColor.cgColor
        let backgroundColor = tintColor.withAlphaComponent(0.1)
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .medium)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        layer.borderWidth = 0.8
        layer.borderColor = borderColor
        layer.cornerRadius = cornerRadius
        setImage(image, for: .normal)
    }
    
    func setupPopupButton(tintColor: UIColor = .white, title: String) {
        self.tintColor = tintColor
        self.backgroundColor = .clear
        setTitle(title, for: .normal)
        setTitleColor(tintColor, for: .normal)
    }
    
    func setupDetailsButton(with imageName: String) {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .default)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfiguration)
        let contentBackColor = UIColor.ACDetails.secondaryBackgroundColor
        let backgroundColor = contentBackColor.withAlphaComponent(0.15)
        let tintColor = UIColor.ACDetails.tintColor
        let strokeColor = tintColor.withAlphaComponent(0.2)
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = backgroundColor
        configuration.background.strokeColor = strokeColor
        configuration.background.strokeWidth = 0.45
        configuration.cornerStyle = .large
        configuration.image = image
        self.configuration = configuration
    }
    
    /// This is needed for the fast configuration of buttons from the `Detail` module.
    /// - Parameters:
    ///   - buttonType: button appearance.
    ///   - title: button content.
    ///   - imageName: icon system name.
    ///   - imageConfig: symbol configuration.
    ///   - isEnabled: button availability bool value.
    func setupDetailsButton(buttonType: DetailsButtonType,
                            title: String? = nil,
                            imageName: String? = nil,
                            imageConfig: UIImage.SymbolConfiguration? = nil,
                            isEnabled: Bool = true) {
        let baseTintColor: UIColor
        let baseStrokeColor: UIColor
        let contentBackColor: UIColor
        let baseBackgroundColor: UIColor
        switch buttonType {
        case .dark:
            baseTintColor = UIColor.ACDetails.tintColor
            baseBackgroundColor = UIColor.ACDetails.backgroundColor
            contentBackColor = UIColor.ACDetails.secondaryBackgroundColor
            baseStrokeColor = UIColor.ACDetails.tintColor
        case .light:
            baseTintColor = UIColor.ACDetails.backgroundColor
            baseBackgroundColor = UIColor.ACDetails.tintColor
            contentBackColor = UIColor.ACDetails.tintColor
            baseStrokeColor = .clear
        }
        /**
         In the code below, before we setup the needed button properties,
         we check if this buton for the particular command is enabled
         through `isEnabled` constant.
         
         When we call this function in the VC, the `isEnabled` constnat will be,
         in the most cases, filled with the UIModel property.
         */
        let tintColor: UIColor
        let strokeColor: UIColor
        let backgroundColor: UIColor
        var configuration = UIButton.Configuration.filled()
        if isEnabled {
            tintColor = baseTintColor
            strokeColor = baseStrokeColor.withAlphaComponent(0.2)
            backgroundColor = contentBackColor.withAlphaComponent(0.95)
        } else {
            tintColor = baseBackgroundColor.withAlphaComponent(0.55)
            strokeColor = baseStrokeColor.withAlphaComponent(0.06)
            backgroundColor = contentBackColor.withAlphaComponent(0.2)
        }
        
        /// Configure the button title if string content title was initialized.
        if let title = title {
            let attributes = tintColor.setupDetailButtonTitleContainer()
            let attributedTitle = AttributedString(title, attributes: attributes)
            configuration.attributedTitle = attributedTitle
        }
        
        /// Configure the button image if image name and configuration were initialized.
        if let imageName = imageName, let imageConfig = imageConfig {
            let image = UIImage(systemName: imageName)
            let imageWithTint = image?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
            let configuredImage = imageWithTint!.applyingSymbolConfiguration(imageConfig)
            configuration.image = configuredImage
            configuration.imagePadding = 6
        }
        
        /// Configure the same properties for all possible button types.
        configuration.background.backgroundColor = backgroundColor
        configuration.background.strokeColor = strokeColor
        configuration.background.strokeWidth = 0.45
        configuration.baseForegroundColor = tintColor
        configuration.cornerStyle = .large
        self.configuration = configuration
        self.isEnabled = isEnabled
    }
}


//MARK: - Fast Button methods
extension UIButton {
    
    //MARK: Public
    func addBlurEffect(cornerRadius: CGFloat? = nil,
                       style: UIBlurEffect.Style = .regular) {
        var corners: CGFloat
        /**
         Glassmorphism buttons, for which we use this background blur effect,
         have capsuled background rounding in most cases.
         
         But we cannot set such flexible kind of rounding
         as a default `cornerRadius` argument value.
         That's why we set the default value of the argument as `nil`,
         and if it equals to empty value(nil), than rounding would be capsuled.
         In the other cases, we can set any needed corner radius.
         */
        if cornerRadius == nil {
            corners = frame.height / 2
        } else {
            guard let cornerRadius = cornerRadius else { return }
            corners = cornerRadius
        }
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blur.isUserInteractionEnabled = false
        blur.layer.cornerRadius = corners
        blur.clipsToBounds = true
        blur.frame = bounds
        insertSubview(blur, at: 0)
        if let imageView = self.imageView {
            bringSubviewToFront(imageView)
        }
    }
    
    func startPulsingAnimation() {
        let layerKey = "pulse"
        let animationKeyPath = "transform.scale"
        let timingFunctionName = CAMediaTimingFunctionName.easeInEaseOut
        let timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        let pulse = CABasicAnimation(keyPath: animationKeyPath)
        pulse.timingFunction = timingFunction
        pulse.autoreverses = true
        pulse.repeatCount = 4
        pulse.duration = 0.5
        pulse.toValue = 1.2
        pulse.fromValue = 1.0
        layer.add(pulse, forKey: layerKey)
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
         In this function, we need to make it possible to use
         the `backgroundColor` depending on the case of usage,
         because some new button types(for example, `.gray` ones) introduced in iOS 15
         should not be subject to changes in some parameters.
         */
        if backgroundColor != nil {
            baseBackgroundColor = backgroundColor
        }
    }
}
