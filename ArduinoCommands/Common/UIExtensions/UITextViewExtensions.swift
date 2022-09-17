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
