//
//  CommandsListFormatter.swift
//  ArduinoCommands
//
//  Created by User on 2023-06-30.
//

import Foundation
import UIKit

//MARK: - Constants
private extension CommandsListFormatter {
    
    //MARK: Private
    enum Constants {
        
        //MARK: Static
        static let maxNumOfPreviewContentCharacters: Int = 90
        static let anySectionMiddleLabelWidth: CGFloat = 82
        static let initialMiddleLabelWidth: CGFloat = 74
    }
}


//MARK: - Main Formatter
struct CommandsListFormatter {
    
    //MARK: Static
    static func convert(_ sections: [ACCommandsSection]) -> [CommandsSectionUIModel] {
        return sections.map { section in
            return CommandsSectionUIModel(header: section.name,
                                          footer: section.footer,
                                          headerHeight: CGFloat(section.headerHeight),
                                          commands: CommandsListFormatter.convert(section.commands))
        }
    }

    static func convert(_ commands: [ACCommand]) -> [CommandUIModel] {
        return commands.map { command in
            return CommandUIModel(title: command.name.uppercased(),
                                  subtitle: command.subtitle.uppercased(),
                                  content: command.description,
                                  previewContent: setupPreviewContent(with: command),
                                  middleLabelWidth: setupMiddleLabelWidth(with: command),
                                  returnsLabelIsHidden: command.returns,
                                  isDevicesLabelEnabled: command.isUsedWithDevices,
                                  codeScreenImage: UIImage(named: command.imageURL!)!,
                                  syntaxDescription: command.details.syntax,
                                  returnsDescription: command.details.returns,
                                  argumentsDescription: command.details.arguments,
                                  isInitialMethod: isInitialMethod(with: command),
                                  isLibraryMethodLabelFirst: command.isLibraryMethod,
                                  isScreenshotButtonEnabled: command.isScreenshotEnabled,
                                  isCodeSnippetButtonEnabled: command.isCodeSnippetEnabled,
                                  isDevicesImagesButtonEnabled: command.device.enablePhotos)
        }
    }
}


//MARK: - Main methods
private extension CommandsListFormatter {
    
    //MARK: Private
    static func setupMiddleLabelWidth(with command: ACCommand) -> CGFloat {
        /**
         In the code below, we check the section number using the already initialized variable `isFirstSection`.
         This will help us identify if cell is a part of section, where `Initial` type of cells are contained,
         and then set the width value which will be appropriate for special keywords.
         */
        if isInitialMethod(with: command) {
            return Constants.initialMiddleLabelWidth
        } else {
            return Constants.anySectionMiddleLabelWidth
        }
    }
    
    static func isInitialMethod(with command: ACCommand) -> Bool  {
        /**
         This one below is used to determine, if the cell of a particular section
         shows preview of the`Initial` method.
         
         That is, if the section title is `The Main Operators` than this is the first section
         and we need to use Initial keyword. In the other cases,
         we don't need to add any special identification keywords to the command preview cell.
         Apart from that, all this logic is described in `setupDevicesDecorationLabel(...)`method  in the Commands List Cell file.
         */
        let currentSubtitle = command.subtitle.uppercased()
        let sectionSubtitle = ACCommandsSection.Keys.firstSectionSubtitle.uppercased()
        return currentSubtitle == sectionSubtitle
    }
    
    static func setupPreviewContent(with command: ACCommand) -> String {
        let maxCharacters = Constants.maxNumOfPreviewContentCharacters
        let description = command.description!
        let descriptionPreview = description.prefix(maxCharacters)
        let previewContent = "\(descriptionPreview)..."
        return previewContent
    }
}
      
