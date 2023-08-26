//
//  CommandDetailFormatter.swift
//  ArduinoCommands
//
//  Created by User on 2023-06-30.
//

import Foundation
import UIKit

//MARK: - Main Formatter
struct CommandDetailFormatter {
    
    //MARK: Static
    static func convert(_ command: ACCommand) -> CommandDetailUIModel {
        return CommandDetailUIModel(title: command.name.uppercased(),
                                    subtitle: command.subtitle.uppercased(),
                                    content: command.description,
                                    readingTitle: command.name.capitalizeFirstLetter(),
                                    returnsLabelIsHidden: command.returns,
                                    isDevicesLabelEnabled: command.isUsedWithDevices,
                                    codeScreenImage: UIImage(named: command.imageURL)!,
                                    syntaxDescription: command.details.syntax,
                                    returnsDescription: command.details.returns,
                                    argumentsDescription: command.details.arguments,
                                    isScreenshotButtonEnabled: command.isScreenshotEnabled,
                                    isCodeSnippetButtonEnabled: command.isCodeSnippetEnabled,
                                    isDevicesImagesButtonEnabled: command.device.enablePhotos)
    }
}
