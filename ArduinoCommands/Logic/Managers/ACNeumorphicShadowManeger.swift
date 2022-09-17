//
//  NeumorphicShadowManeger.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 25.04.2022.
//

import Foundation
import UIKit

//MARK: - Maneger for fast view Neumorphic Shadow setup
final public class ACNeumorphicShadowManeger {
    
    //MARK: Public
    weak var darkShadowLayer: CALayer!
    weak var lightShadowLayer: CALayer!
    weak var view: UIView!
    
    
    //MARK: Initialization
    init(lightShadowLayer: CALayer!, darkShadowLayer: CALayer!, on view: UIView!) {
        self.view = view
        self.darkShadowLayer = darkShadowLayer
        self.lightShadowLayer = lightShadowLayer
    }
    
    //MARK: Public
    func setupShadowStyles(setupCostomStyle: (() -> Void)?) {
        view.clipsToBounds = false
        view.layer.cornerCurve = .continuous
        /**
         In the code below, we will set special properies
         for dark and light layers of our view, that are going to have neumorphic shadow,
         tn a special `CATransaction` container(CATransaction is the Core Animation mechanism
         for batching multiple layer-tree operations into atomic updates to the render tree.
         
         Explicit transactions occur when the the application sends the `CATransaction` class a `begin()` message
         before modifying the layer tree, and a `commit()` message afterwards).
         
         In the middle of container, after we set a usual basic style for views' neumorphic shadow,
         we have a special closure, that will give a user an opportunity to costomize shadow a bit,
         this closure, of course, gives us advantage not to create a special class for every UI Element.
         */
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        darkShadowLayer.setupNeumorphicDarkLayerStyle()
        lightShadowLayer.setupNeumorphicLightLayerStyle()
        setupCostomStyle?()
        
        CATransaction.commit()
    }
    
    func updateShadowColors(lightShadowColor: UIColor = UIColor.ACShadow.neuLightShadowColor,
                            darkShadowColor: UIColor = UIColor.ACShadow.neuDarkShadowColor) {
        lightShadowLayer.shadowColor = lightShadowColor.cgColor
        darkShadowLayer.shadowColor = darkShadowColor.cgColor
    }
    
    func setupShadowUnderViewPreparation() {
        /**
         In the code below, we set usual properies for dark and light layers of our view,
         but this function we usually use only in `layoutSubviews` life cycle method.
         */
        darkShadowLayer.addNeumorphicLayerStyle(on: view)
        lightShadowLayer.addNeumorphicLayerStyle(on: view)
        darkShadowLayer.setupNeumorphicLayerFlexibility(with: view)
        lightShadowLayer.setupNeumorphicLayerFlexibility(with: view)
    }
}
