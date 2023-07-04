//
//  UICollectionViewFlowLayoutExtensions.swift
//  ArduinoCommands
//
//  Created by User on 2023-04-08.
//

import Foundation
import UIKit

//MARK: - Fast CollectionView Layout methods
public extension UICollectionViewFlowLayout {
    
    //MARK: Public
    static func setupBasicGalleryFlowLayout(width: CGFloat,
                                            basicSpacing: CGFloat = 1) -> UICollectionViewFlowLayout {
        let itemSize = CGSize(width: width, height: width)
        let layout: UICollectionViewFlowLayout = .init()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = basicSpacing
        layout.minimumLineSpacing = basicSpacing
        layout.itemSize = itemSize
        return layout
    }
}
