//
//  NeumorphicButton.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 25.04.2022.
//

import Foundation
import UIKit

//MARK: - Button with Neumorphic Shadow
public class ACNeumorphicButton: UIButton {
    
    //MARK: Private
    private(set) var darkShadowLayer = CALayer()
    private(set) var lightShadowLayer = CALayer()
    private var shadowManeger: ACNeumorphicShadowManeger {
        return ACNeumorphicShadowManeger(lightShadowLayer: lightShadowLayer, darkShadowLayer: darkShadowLayer, on: self)
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    //MARK: Lifecycle
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        shadowManeger.setupShadowUnderViewPreparation()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        shadowManeger.updateShadowColors(darkShadowColor: .systemGray)
    }
}


//MARK: - Main methods
private extension ACNeumorphicButton {
    
    //MARK: Private
    func setupButton() {
        addBlurEffect()
        setupViewsOwnShdowStyle()
    }
    
    func setupViewsOwnShdowStyle() {
        shadowManeger.setupShadowStyles(setupCostomStyle: { [self] in
            darkShadowLayer.setupNeumorphicDarkLayerStyle(color: .systemGray,
                                                          radius: 10)
            lightShadowLayer.setupNeumorphicLightLayerStyle(radius: 5,
                                                            offsetValue: -5,
                                                            opacity: 0.5)
        })
    }
}
