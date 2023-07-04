//
//  CommandDetailViewModel.swift
//  ArduinoCommands
//
//  Created by User on 09.08.2022.
//

import Foundation
import UIKit

//MARK: - Command Details model for UI
struct CommandDetailUIModel {
    let title: String!
    let subtitle: String!
    let content: String!
    let returnsLabelIsHidden: Bool!
    let isDevicesLabelEnabled: Bool!
    let codeScreenImage: UIImage!
    let syntaxDescription: String!
    let returnsDescription: String!
    let argumentsDescription: String!
    let isScreenshotButtonEnabled: Bool!
    let isCodeSnippetButtonEnabled: Bool!
    let isDevicesImagesButtonEnabled: Bool!
}
