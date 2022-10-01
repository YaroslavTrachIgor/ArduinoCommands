//
//  NSStringExtensions.swift
//  ArduinoCommands
//
//  Created by User on 16.09.2022.
//

import Foundation
import UIKit

//MARK: - Highlight particular String components extension
public extension NSString {
    
    //MARK: Public
    /// This one highlights the right parts of the string with the right font.
    /// - Parameters:
    ///   - boldPartsOfString: array of  parts of string that will be highlighted;
    ///   - font: normal font of self;
    ///   - boldFont: new font for needed parts of string;
    /// - Returns: content with highlited parts of it of type `NSString`.
    func highlight(partsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font: font!]
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes: nonBoldFontAttribute)
        let boldCharactersCount = partsOfString.count
        for i in 0 ..< boldCharactersCount {
            let boldCharacter = partsOfString[i] as String
            let range = self.range(of: boldCharacter)
            boldString.addAttributes(boldFontAttribute, range: range)
        }
        return boldString
    }
}
