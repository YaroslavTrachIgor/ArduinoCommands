//
//  ACCustomCollectionViewCell.swift
//  ArduinoCommands
//
//  Created by User on 18.07.2022.
//

import Foundation
import UIKit

//MARK: - CollectionView Cell protocol
protocol ACCustomCollectionViewCellProtocol {
    func setGradient()
    func setupBasicsCell(shadowAvailable: Bool!,
                         backColor: UIColor!,
                         secondatyColor: UIColor!,
                         gradientType: ACGradientType!)
}


//MARK: - Main CollectionView Cell
public class ACCustomCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public
    public var gradientType: ACGradientType!
    public var firstGradientColor: UIColor!
    public var secondGradientColor: UIColor!
    
    //MARK: Private
    private lazy var gradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer(layer: self.layer)
        var startPoint = gradientType.getStartPoint()
        var endPoint = gradientType.getEndPoint()
        let colors = [firstGradientColor.cgColor, secondGradientColor.cgColor]
        gradientLayer.locations = [0.2, 0.85]
        gradientLayer.cornerRadius = 16
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.frame = self.bounds
        return gradientLayer
    }()
}


//MARK: - CollectionView Cell protocol extension
extension ACCustomCollectionViewCell: ACCustomCollectionViewCellProtocol {
    
    //MARK: Public
    public func setGradient() {
        /**
         In this project all CollectionView Cells will be inherted from the `ACCustomCollectionViewCell`,
         but there are some cases when cell doesn't need gradient background(for instance, if it has neumorphic shadow).
         
         For this we create a special function to insert a new sublayer with gradient,
         because when we use `init` everything will be added every time when we create Cell.
         */
        layer.insertSublayer(gradient, at: 0)
    }
    
    public func setupBasicsCell(shadowAvailable: Bool!,
                                backColor: UIColor!,
                                secondatyColor: UIColor!,
                                gradientType: ACGradientType!) {
        layer.masksToBounds = false
        layer.cornerRadius = 18
        backgroundColor = backColor
        /**
         Not every CollectionView cell needs special shadow and gradient for background,
         in order to check if cell needs to have these characteristics,
         we use special `shadowAvailable` model property.
         */
        if shadowAvailable! {
            let borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
            let shadowColor = backColor?.withAlphaComponent(0.26).cgColor
            let shadowOffset = CGSize(width: 0, height: 4.5)
            layer.borderWidth = 0.6
            layer.borderColor = borderColor
            layer.shadowColor = shadowColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = 1
            layer.shadowRadius = 5
            backgroundColor = .clear
            self.gradientType = gradientType
            self.firstGradientColor = backColor
            self.secondGradientColor = secondatyColor
            setGradient()
        }
    }
}
