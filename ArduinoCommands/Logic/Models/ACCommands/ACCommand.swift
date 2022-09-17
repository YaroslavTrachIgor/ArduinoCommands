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
    let name: String!
    let subtitle: String!
    let imageURL: String!
    let description: String!
    let exampleOfCode: String!
    let baseDescription: String!
    let isLibraryMethod: Bool!
    let isUsedWithDevices: Bool!
    let returns: Bool!
    
    //MARK: Initialization
    init(name: String!,
         subtitle: String!,
         description: String!,
         basicDescription: String!,
         exampleOfCode: String!,
         imageURL: String!,
         returns: Bool!,
         isUsedWithDevices: Bool!,
         isLibraryMethod: Bool!) {
        self.name = name
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.description = description
        self.exampleOfCode = exampleOfCode
        self.baseDescription = basicDescription
        self.isLibraryMethod = isLibraryMethod
        self.isUsedWithDevices = isUsedWithDevices
        self.returns = returns
    }
}
