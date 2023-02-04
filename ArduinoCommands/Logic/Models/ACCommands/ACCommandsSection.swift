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


//MARK: - Keys
public extension ACCommandsSection {
    
    //MARK: Public
    enum Keys {
        
        //MARK: Static
        /**
         --------------------------------------------------------------------
         The easiest way to keep track of a section's type is through its header(or subtitle of command).
         Therefore, we can create keys for the sections, which will be the same as in the JSON data file.
         --------------------------------------------------------------------
         */
        /**
         This one below is used to identify cell's
         which contain information about commands with `Initial`  command type.

         Moreover, the sense of advertising system in the app
         is to display ad sessions and ad blocks depending on the type of article.
         Advertising will not be shown if articles are in the first section(`The main Operators`),
         in all other cases ads won't be shown.
         */
        static let firstSectionSubtitle = "The main Operators"
    }
}
