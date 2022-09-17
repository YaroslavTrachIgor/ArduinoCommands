//
//  ACPasteboardManager.swift
//  ArduinoCommands
//
//  Created by User on 27.06.2022.
//

import Foundation
import UIKit

//MARK: - Content type
public extension ACPasteboardManager {
    
    //MARK: Public
    enum ContentType: String {
        case story = "The Story"
        case image = "The Image"
        case code = "The Code"
        case article = "The Article"
        case content = "The Content"
        case screenshot = "The Screenshot"
    }
}


//MARK: - Maneger for fast content copying
final public class ACPasteboardManager {
    
    //MARK: Static
    /**
     In the code below, we create functions
     that will allow us to save certain content(text or images) to the clipboard.
     
     Usually this Manager is used in `UIViewControllers` with Articles or Screenshots of commands.
     */
    static func copy(_ string: String) {
        UIPasteboard.general.string = string
    }
    
    static func copy(_ image: UIImage) {
        UIPasteboard.general.image = image
    }
}
