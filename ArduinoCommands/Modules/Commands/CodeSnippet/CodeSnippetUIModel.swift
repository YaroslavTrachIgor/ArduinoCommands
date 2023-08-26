//
//  CodeSnippetUIModel.swift
//  ArduinoCommands
//
//  Created by User on 19.09.2022.
//

import Foundation
import UIKit

//MARK: - Cell ViewModel protocol
protocol CodeSnippetUIModelProtocol {
    var linesContent: String! { get }
    func code(codeFontSize: Float) -> NSAttributedString
}


//MARK: - Constants
private extension CodeSnippetUIModel {
    
    //MARK: Private
    enum Constants {
        
        //MARK: Static
        static let boldFontSizeAddition = 0.8
        static let maxNumberOfLines = 40
    }
}


//MARK: - Cell ViewModel
public final class CodeSnippetUIModel {
    var model: ACCommand?
    
    //MARK: Initialization
    init(model: ACCommand) {
        self.model = model
    }
}


//MARK: - Cell ViewModel protocol extension
extension CodeSnippetUIModel: CodeSnippetUIModelProtocol {
    
    //MARK: Internal
    internal var linesContent: String! {
        var content = String()
        let maxLines = Constants.maxNumberOfLines
        for lineNumber in 0...maxLines {
            content = content + "\(lineNumber)\n"
        }
        return content
    }
    
    internal func code(codeFontSize: Float) -> NSAttributedString {
        let fontSize = CGFloat(codeFontSize)
        let font = UIFont.ACCodeFont(ofSize: fontSize)
        let boldFontSize = Constants.boldFontSizeAddition + fontSize
        let boldFont = UIFont.ACCodeFont(ofSize: boldFontSize, weight: .bold)
        let exampleOfCode = model?.exampleOfCode!
        let commandName = model?.name!.removeScopes()
        let boldPartsOfString = [NSString(string: commandName!)]
        let attributedCode = NSString(string: exampleOfCode!)
        let attributedContent = attributedCode.highlight(partsOfString: boldPartsOfString,
                                                           font: font,
                                                           boldFont: boldFont)
        return attributedContent
    }
}
