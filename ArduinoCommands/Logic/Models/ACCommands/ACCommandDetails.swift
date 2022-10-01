//
//  ACCommandDetails.swift
//  ArduinoCommands
//
//  Created by User on 25.09.2022.
//

import Foundation

//MARK: - Main model
public final class ACCommandDetails: Codable {
    var syntax: String!
    var arguments: String!
    var returns: String!
    
    //MARK: Initialization
    init(syntax: String!,
         arguments: String!,
         returns: String!) {
        self.syntax = syntax
        self.arguments = arguments
        self.returns = returns
    }
}
