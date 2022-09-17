//
//  Command.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 14.05.2022.
//

import Foundation

//MARK: - Main Section model
public final class ACCommandsSection: Codable {
    let name: String!
    let footer: String!
    let headerHeight: Int!
    let commands: [ACCommand]!
    
    //MARK: Initialization
    init(name: String!,
         footer: String!,
         headerHeight: Int!,
         commands: [ACCommand]!) {
        self.name = name
        self.footer = footer
        self.commands = commands
        self.headerHeight = headerHeight
    }
}

