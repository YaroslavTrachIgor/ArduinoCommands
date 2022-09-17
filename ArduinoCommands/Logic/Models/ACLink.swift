//
//  Site.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 15.03.2022.
//

import Foundation
import UIKit

//MARK: - Main model
public final class ACLink {
    var name: String?
    var link: String?
    
    //MARK: Initialization
    init(name: String?, link: String?) {
        self.name = name
        self.link = link
    }
}


//MARK: - Cell model
public struct ACLinkCellModel {
    var content: ACLink
    var tintColor: UIColor?
    var backColor: UIColor?
    var secondaryColor: UIColor?
    var shadowAvailable: Bool?
    var decorationBackImageName: String?
}
