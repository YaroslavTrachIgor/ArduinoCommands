//
//  ACDeviceImagesAPIResponse.swift
//  ArduinoCommands
//
//  Created by User on 04.02.2023.
//

import Foundation

//MARK: - Main Model
struct ACDeviceImagesAPIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [ACDeviceImageResult]?
}
