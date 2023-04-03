//
//  UIBarButtonItemExtensions.swift
//  ArduinoCommands
//
//  Created by User on 20.09.2022.
//

import Foundation
import UIKit

//MARK: - Constants
private extension UIBarButtonItem {

    //MARK: Private
    enum Constants {
        enum ImageNames {
            
            //MARK: Static
            static let costomBackItemName = "arrow.backward"
            static let shareItemName = "square.and.arrow.up"
            static let copyItemName = "square.on.square"
        }
    }
}


//MARK: - Setup base BarButtonItem types
public extension UIBarButtonItem {
    
    //MARK: Static
    ///This sets up fast settings for BarButtonItems.
    /// - Returns: /////////////////////////////////////////////////////
    static func spacer() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    }
}


//MARK: - Fast BarButtonItem methods
public extension UIBarButtonItem {
    
    //MARK: Public
    ///This sets up fast settings for BarButtonItems.
    /// - Parameters:
    ///   - imageName: string image system name or a name from Assets;
    ///   - imageWeight: cases of how bold our bar item image can be;
    ///   - tintColor: bar item fill color.
    func setupFastLightBarButtonItem(imageName: String,
                                     imageWeight: UIImage.SymbolWeight = .regular,
                                     tintColor: UIColor = .white) {
        let config = UIImage.SymbolConfiguration(weight: imageWeight)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        self.tintColor = tintColor
        self.image = image
    }
}


//MARK: - Setup base BarButtonItem types
public extension UIBarButtonItem {
    
    //MARK: Public
    func setupBaseCopyBarButton() {
        setupFastLightBarButtonItem(imageName: Constants.ImageNames.copyItemName)
    }
    
    func setupBaseShareBarButton() {
        setupFastLightBarButtonItem(imageName: Constants.ImageNames.shareItemName)
    }
    
    func setupBaseBackBarButton() {
        setupFastLightBarButtonItem(imageName: Constants.ImageNames.costomBackItemName)
    }
}
