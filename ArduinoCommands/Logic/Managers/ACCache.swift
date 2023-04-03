//
//  ACCache.swift
//  ArduinoCommands
//
//  Created by User on 2023-02-23.
//

import Foundation
import UIKit

//MARK: - Manager for fast access to the Device's Cache
final class ACCache {
    
    //MARK: Static
    static let defaults = ACCache()
    
    //MARK: Private
    private var imageCache = NSCache<NSString, UIImage>()
    
    
    //MARK: Initialization
    private init() {}
    
    //MARK: Public
    func saveImage(image: UIImage, forKey: String) {
        imageCache.setObject(image, forKey: forKey as NSString)
    }
    
    func getImage(forKey: String) -> UIImage? {
        imageCache.object(forKey: forKey as NSString)
    }
}
