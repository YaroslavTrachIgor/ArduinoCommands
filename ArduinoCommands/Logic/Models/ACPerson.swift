//
//  ACPerson.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.03.2022.
//

import Foundation
import UIKit

//MARK: - Main model
public final class ACPerson {
    var name: String?
    var role: String?
    var description: String?
    
    //MARK: Initialization
    init(name: String?, role: String?, description: String?) {
        self.name = name
        self.role = role
        self.description = description
    }
}


//MARK: - Cell model
public struct ACPersonCellModel {
    var person: ACPerson
    var roleIcon: String?
    var tintColor: UIColor?
    var backColor: UIColor?
    var secondaryColor: UIColor?
    var shadowAvailable: Bool?
    var backImageName: String?
}
