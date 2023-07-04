//
//  UITableViewExtensions.swift
//  ArduinoCommands
//
//  Created by User on 2023-06-15.
//

import Foundation
import UIKit

//MARK: - Fast CollectionView methods
public extension UICollectionView {
    
    //MARK: Public
    func dequeueCell<T: UICollectionViewCell>(_ key: String, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: key, for: indexPath) as! T
    }
}

