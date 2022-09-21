//
//  UISegmentedControlExtensions.swift
//  ArduinoCommands
//
//  Created by User on 20.09.2022.
//

import Foundation
import UIKit

//MARK: - Fast SegmentedControl methods
public extension UISegmentedControl {
    
    //MARK: Public
    func setupBaseDetailDarkSegmentedControl() {
        let attributedFontKey = NSAttributedString.Key.font
        let attributedForegroundColorKey = NSAttributedString.Key.foregroundColor
        let segmentedControlBackColor: UIColor = .black.withAlphaComponent(0.25)
        let font = UIFont.ACFont(ofSize: 12, weight: .bold)
        self.backgroundColor = segmentedControlBackColor
        selectedSegmentTintColor = backgroundColor
        setTitleTextAttributes([attributedForegroundColorKey: segmentedControlBackColor], for: .selected)
        setTitleTextAttributes([attributedForegroundColorKey: UIColor.white], for: .normal)
        setTitleTextAttributes([attributedFontKey: font], for: .selected)
    }
}
