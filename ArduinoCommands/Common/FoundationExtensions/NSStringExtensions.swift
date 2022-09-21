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
    ///
    /// - Parameters:
    ///   - boldPartsOfString:
    ///   - font:
    ///   - boldFont:
    /// - Returns:
    func addBoldText(boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font: font!]
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes: nonBoldFontAttribute)
        let boldCharactersCount = boldPartsOfString.count
        for i in 0 ..< boldCharactersCount {
            let boldCharacter = boldPartsOfString[i] as String
            let range = self.range(of: boldCharacter)
            boldString.addAttributes(boldFontAttribute, range: range)
        }
        return boldString
    }
}
