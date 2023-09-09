//
//  CommandUIModel.swift
//  ArduinoCommands
//
//  Created by User on 2023-06-30.
//

import Foundation
import UIKit

//MARK: - Command model for UI
struct CommandUIModel {
    let icon: UIImage!
    let title: String!
    let subtitle: String!
    let content: String!
    let previewContent: String!
    let middleLabelWidth: CGFloat!
    let returnsLabelIsHidden: Bool!
    let isDevicesLabelEnabled: Bool!
    let codeScreenImage: UIImage!
    let syntaxDescription: String!
    let returnsDescription: String!
    let argumentsDescription: String!
    let isInitialMethod: Bool!
    let isLibraryMethodLabelFirst: Bool!
    let isScreenshotButtonEnabled: Bool!
    let isCodeSnippetButtonEnabled: Bool!
    let isDevicesImagesButtonEnabled: Bool!
}
