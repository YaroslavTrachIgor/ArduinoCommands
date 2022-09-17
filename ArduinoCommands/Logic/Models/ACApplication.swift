//
//  ACApplication.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

//MARK: - Main model
final class ACApplication: Codable {
    var version: String?
    var applicationName: String?
    var applicationAbbreviation: String?
    
    //MARK: Initialization
    init(version: String?,
         applicationName: String?,
         applicationAbbreviation: String?) {
        self.version = version
        self.applicationName = applicationName
        self.applicationAbbreviation = applicationAbbreviation
    }
}
