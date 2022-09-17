//
//  NeumorphicCellView.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 25.04.2022.
//

import Foundation
import UIKit

//MARK: - Collection view cell with Neumorphic Shadow
public class ACNeumorphicCollectionViewCell: ACCustomCollectionViewCell {
    
    //MARK: Private
    private(set) var darkShadowLayer = CALayer()
    private(set) var lightShadowLayer = CALayer()
    private var shadowManeger: ACNeumorphicShadowManeger {
        return ACNeumorphicShadowManeger(lightShadowLayer: lightShadowLayer,
                                         darkShadowLayer: darkShadowLayer,
                                         on: self)
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shadowManeger.setupShadowStyles(setupCostomStyle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        shadowManeger.setupShadowStyles(setupCostomStyle: nil)
    }
    
    //MARK: Lifecycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowManeger.setupShadowUnderViewPreparation()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        shadowManeger.updateShadowColors()
    }
}
