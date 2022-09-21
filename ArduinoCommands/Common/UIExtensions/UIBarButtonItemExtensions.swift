//
//  UIBarButtonItemExtensions.swift
//  ArduinoCommands
//
//  Created by User on 20.09.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension UIBarButtonItem {

    //MARK: Private
    enum Keys {
        enum ImageNames {
            
            //MARK: Static
            static let costomBackItemName = "arrow.backward"
            static let shareItemName = "square.and.arrow.up"
            static let copyItemName = "square.on.square"
        }
    }
}


//MARK: - Fast BarButtonItem methods
public extension UIBarButtonItem {
    
    //MARK: Public
    ///
    /// - Parameters:
    ///   - imageName:
    ///   - imageWeight:
    ///   - tintColor:
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
        setupFastLightBarButtonItem(imageName: Keys.ImageNames.copyItemName)
    }
    
    func setupBaseShareBarButton() {
        setupFastLightBarButtonItem(imageName: Keys.ImageNames.shareItemName)
    }
    
    func setupBaseBackBarButton() {
        setupFastLightBarButtonItem(imageName: Keys.ImageNames.costomBackItemName)
    }
}
