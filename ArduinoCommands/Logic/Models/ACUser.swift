//
//  USer.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 17.03.2022.
//

import Foundation
import UIKit

//MARK: - Main model
public final class ACUser {
    let age: Int?
    let name: String?
    let role: String?
    let surname: String?
    let iconName: String?
    let extraInfo: String?
    let dateWhenAdded: Date?
    let secondaryColor: UIColor?
    let roleLabelWidth: CGFloat?
    let roleDescription: String?
    let extraInfoLabelWidth: CGFloat?
    
    
    //MARK: Initialization
    init(name: String?,
         surname: String?,
         role: String?,
         age: Int?,
         iconName: String?,
         dateWhenAdded: Date?,
         secondaryColor: UIColor?,
         roleDescription: String?,
         extraInfo: String?,
         roleLabelWidth: CGFloat?,
         extraInfoLabelWidth: CGFloat?) {
        self.age = age
        self.name = name
        self.role = role
        self.surname = surname
        self.iconName = iconName
        self.extraInfo = extraInfo
        self.dateWhenAdded = dateWhenAdded
        self.secondaryColor = secondaryColor
        self.roleLabelWidth = roleLabelWidth
        self.roleDescription = roleDescription
        self.extraInfoLabelWidth = extraInfoLabelWidth
    }
}


//MARK: - Cell model
public struct ACUserCellModel {
    let content: ACUser
    let tintColor: UIColor?
}
