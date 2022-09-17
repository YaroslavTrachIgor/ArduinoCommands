//
//  UIFontExtensions.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 18.03.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension UIFont {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        static let basicFontName = "Hiragino Mincho ProN"
        static let codeFontName = "Menlo"
    }
}

//MARK: - Font weight cases
public extension UIFont {
    
    //MARK: Public
    enum ACWeight {
        case regular
        case bold
    }
    
    enum ACCodeWeight {
        case regular
        case bold
    }
}


//MARK: - Font style cases
public extension UIFont {
    
    //MARK: Public
    enum ACStyle {
        case navTitle
        case header
        case footer
        case cellTitle
        case cellSubtitle
        case cellContent
        case cellDeco
        case articleTitle
        case articleSubtitle
        case articleContent
        case articlePreview
    }
}


//MARK: - Setup costom Font settings
public extension UIFont {
    
    //MARK: Static
    /// <#Description#>
    /// - Parameters:
    ///   - ofSize: <#ofSize description#>
    ///   - weight: <#weight description#>
    /// - Returns: <#description#>
    static func ACFont(ofSize: CGFloat, weight: UIFont.ACWeight = .regular) -> UIFont {
        let fontName = UIFont.Keys.basicFontName
        switch weight {
        case .regular:
            return UIFont(name: "\(fontName) W3", size: ofSize)!
        case .bold:
            return UIFont(name: "\(fontName) W6", size: ofSize)!
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - ofSize: <#ofSize description#>
    ///   - weight: <#weight description#>
    /// - Returns: <#description#>
    static func ACCodeFont(ofSize: CGFloat, weight: UIFont.ACCodeWeight = .regular) -> UIFont {
        let fontName = UIFont.Keys.codeFontName
        switch weight {
        case .regular:
            return UIFont(name: "\(fontName)", size: ofSize)!
        case .bold:
            return UIFont(name: "\(fontName) Bold", size: ofSize)!
        }
    }
    
    static func ACFont(style: ACStyle) -> UIFont {
        switch style {
        case .navTitle:
            return UIFont.ACFont(ofSize: 10)
        case .cellTitle:
            return UIFont.ACFont(ofSize: 18.5, weight: .bold)
        case .cellSubtitle:
            return UIFont.ACFont(ofSize: 10, weight: .regular)
        case .cellContent:
            return UIFont.ACFont(ofSize: 12, weight: .regular)
        case .cellDeco:
            return UIFont.ACFont(ofSize: 10, weight: .bold)
        case .articleTitle:
            return UIFont.ACFont(ofSize: 20, weight: .bold)
        case .articleSubtitle:
            return UIFont.ACFont(ofSize: 9.5, weight: .bold)
        case .articleContent:
            return UIFont.ACFont(ofSize: 12.5, weight: .regular)
        case .articlePreview:
            return UIFont.ACFont(ofSize: 11, weight: .regular)
        case .header:
            return UIFont.ACFont(ofSize: 28, weight: .bold)
        case .footer:
            return UIFont.ACFont(ofSize: 10.5)
        }
    }
}
