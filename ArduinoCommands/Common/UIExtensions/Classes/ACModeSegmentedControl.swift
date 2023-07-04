//
//  ACDevicesImagesGallerySegmentedControl.swift
//  ArduinoCommands
//
//  Created by User on 2023-04-08.
//

import Foundation
import UIKit

//MARK: - Constants
private extension ACModeSegmentedControl {
    
    //MARK: Private
    enum Constants {
        enum Color {
            
            //MARK: Static
            static let backgroundColorName = "DevicesImagesSelectedSegmentBack"
            static let borderColorAlpha = 0.6
        }
    }
}


//MARK: - Mode Segmented Control
final class ACModeSegmentedControl: UISegmentedControl {
    
    //MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSegmentedControl()
        setupSegmentedControlTextAttributes()
        setupSelectedSegmentButton()
    }
}


//MARK: - Main methods
private extension ACModeSegmentedControl {
    
    //MARK: Private
    func setupSegmentedControl() {
        let cornerRadius = self.frame.height / 2
        let borderAlpha = Constants.Color.borderColorAlpha
        let borderColor = UIColor.white.withAlphaComponent(borderAlpha).cgColor
        selectedSegmentTintColor = .clear
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor
        layer.borderWidth = 0.2
    }
    
    func setupSegmentedControlTextAttributes() {
        let foregroundColor = UIColor.label
        let foregroundColorKey = NSAttributedString.Key.foregroundColor
        let segmentButtonTextAttributes = [foregroundColorKey: foregroundColor]
        setTitleTextAttributes(segmentButtonTextAttributes, for: .selected)
        setTitleTextAttributes(segmentButtonTextAttributes, for: .normal)
    }
    
    func setupSelectedSegmentButton() {
        let selectedSegmentButton = self.subviews[numberOfSegments]
        if let selectedImageView = selectedSegmentButton as? UIImageView {
            let cornerRadius = selectedImageView.frame.height / 2
            let backgroundColor = UIColor(named: Constants.Color.backgroundColorName)
            selectedImageView.layer.cornerRadius = cornerRadius
            selectedImageView.backgroundColor = backgroundColor
            selectedImageView.image = nil
        }
    }
}
