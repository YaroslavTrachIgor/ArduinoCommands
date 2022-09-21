//
//  CALayerExtensions.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 26.04.2022.
//

import Foundation
import UIKit

//MARK: - Views layer neumorphism costomization
public extension CALayer {
    
    //MARK: Public
    /// <#Description#>
    /// - Parameters:
    ///   - color: <#color description#>
    ///   - radius: <#radius description#>
    ///   - offsetValue: <#offsetValue description#>
    ///   - opacity: <#opacity description#>
    func setupNeumorphicLightLayerStyle(color: UIColor = UIColor.ACShadow.neuLightShadowColor,
                                        radius: CGFloat = 5.5,
                                        offsetValue: CGFloat = -10,
                                        opacity: Float = 0.45) {
        needsDisplayOnBoundsChange = true
        shadowRadius = radius
        shadowOpacity = opacity
        shadowColor = color.cgColor
        shadowOffset = CGSize(width: offsetValue,
                              height: offsetValue)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - color: <#color description#>
    ///   - radius: <#radius description#>
    ///   - offsetValue: <#offsetValue description#>
    ///   - opacity: <#opacity description#>
    func setupNeumorphicDarkLayerStyle(color: UIColor = UIColor.ACShadow.neuDarkShadowColor,
                                       radius: CGFloat = 4,
                                       offsetValue: CGFloat = 10,
                                       opacity: Float = 0.15) {
        needsDisplayOnBoundsChange = true
        shadowRadius = radius
        shadowOpacity = opacity
        shadowColor = color.cgColor
        shadowOffset = CGSize(width: offsetValue,
                              height: offsetValue)
    }
    
    /// <#Description#>
    /// - Parameter backView: <#backView description#>
    func setupNeumorphicLayerFlexibility(with backView: UIView) {
        backgroundColor = backView.layer.backgroundColor
        cornerRadius = backView.layer.cornerRadius
        cornerCurve = backView.layer.cornerCurve
    }
    
    /// <#Description#>
    /// - Parameter view: <#view description#>
    func addNeumorphicLayerStyle(on view: UIView) {
        self.frame = view.bounds
        view.layer.insertSublayer(self, at: 0)
    }
}
