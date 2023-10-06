//
//  CommandPreview.swift
//  ArduinoCommands
//
//  Created by User on 17.12.2022.
//

import Foundation

//MARK: - Main model
public struct CommandPreview {
    let title: String
    let subtitle: String
    let iconName: String
    let previewContent: String
    let isUsedForDevices: Bool
    let isInitial: Bool
    let returns: Bool
}
