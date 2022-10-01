//
//  Command.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.05.2022.
//

import Foundation
import UIKit

//MARK: - Main model
public final class ACCommand: Codable {
    var name: String!
    var subtitle: String!
    var imageURL: String!
    var description: String!
    var exampleOfCode: String!
    var baseDescription: String!
    var isLibraryMethod: Bool!
    var isUsedWithDevices: Bool!
    var returns: Bool!
    var details: ACCommandDetails
    
    //MARK: Initialization
    init(name: String!,
         subtitle: String!,
         description: String!,
         basicDescription: String!,
         exampleOfCode: String!,
         imageURL: String!,
         returns: Bool!,
         isUsedWithDevices: Bool!,
         isLibraryMethod: Bool!,
         details: ACCommandDetails) {
        self.name = name
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.description = description
        self.exampleOfCode = exampleOfCode
        self.baseDescription = basicDescription
        self.isLibraryMethod = isLibraryMethod
        self.isUsedWithDevices = isUsedWithDevices
        self.returns = returns
        self.details = details
    }
}
