//
//  UITextViewExtensions.swift
//  ArduinoCommands
//
//  Created by User on 15.06.2022.
//

import Foundation
import UIKit

//MARK: - Fast TextView methods
public extension UITextView {
    
    //MARK: Public
    func changeTextWithAnimation(text: String) {
        UIView.transition(with: self,
                      duration: 0.25,
                       options: .transitionCrossDissolve,
                    animations: {
            self.text = text
                 }, completion: nil)
    }
}


//MARK: - Setup basic TextView types
public extension UITextView {
    
    //MARK: Public
    /// This configures special TextView type
    /// that will be used to display little descriptions
    /// of how some particular features of app work and how to use them.
    /// - Parameters:
    ///   - text: TextView content;
    ///   - ofSize: font size;
    ///   - appearance: appearance case that will be used to detect what kind of text color use.
    func setupBaseFooterTextView(text: String,
                                 ofSize: CGFloat = 13,
                                 appearance: ACBaseAppearanceType = .dark) {
        let font = UIFont.systemFont(ofSize: ofSize, weight: .regular)
        switch appearance {
        case .dark:
            textColor = #colorLiteral(red: 0.9122867584, green: 0.9092650414, blue: 0.9549868703, alpha: 0.6)
        case .light:
            textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
        case .system:
            textColor = .tertiaryLabel
        }
        backgroundColor = .clear
        isSelectable = false
        isEditable = false
        self.text = text
        self.font = font
    }
}
