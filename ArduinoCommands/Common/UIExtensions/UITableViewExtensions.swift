//
//  UITableViewExtensions.swift
//  ArduinoCommands
//
//  Created by User on 2023-06-15.
//

import Foundation
import UIKit

//MARK: - Fast CollectionView methods
public extension UITableView {
    
    //MARK: Public
    func dequeueCell<T: UITableViewCell>(_ key: String, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: key, for: indexPath) as! T
    }
}
