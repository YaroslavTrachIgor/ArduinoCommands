//
//  UIImageExtensions.swift
//  ArduinoCommands
//
//  Created by User on 2023-03-20.
//

import Foundation
import UIKit

//MARK: - Fast Image methods
public extension UIImage {
    
    //MARK: Public
    func alpha(_ value: CGFloat) -> UIImage {
        let point = CGPoint.zero
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: point, blendMode: .normal, alpha: value)
        let alphaImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return alphaImage!
    }
}
