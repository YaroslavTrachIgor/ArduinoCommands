//
//  ACDeviceImageResult.swift
//  ArduinoCommands
//
//  Created by User on 04.02.2023.
//

import Foundation

//MARK: - Main Model
struct ACDeviceImageResult: Codable {
    let id: String
    let urls: ACDeviceImageURl?
}
