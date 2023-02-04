//
//  ACDevice.swift
//  ArduinoCommands
//
//  Created by User on 31.12.2022.
//

import Foundation

//MARK: - Main model
public final class ACDevice: Codable {
    var name: String!
    var enablePhotos: Bool!
    
    //MARK: Initialization
    init(name: String!, enablePhotos: Bool!) {
        self.name = name
        self.enablePhotos = enablePhotos
    }
}
