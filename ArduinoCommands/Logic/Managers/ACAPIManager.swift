//
//  APIHelper.swift
//  ArduinoCommands
//
//  Created by User on 16.06.2022.
//

import Foundation

//MARK: Maneger for fast transformation of JSON content
final class ACAPIManager {
    
    //MARK: Static
    static func parseCommandsSectionsJsonContent() -> [ACCommandsSection] {
        let jsonFile = ACFilenames.commandsListFile
        let commandsSections = try! JSONDecoder().decode([ACCommandsSection].self, from: Data.load(from: jsonFile))
        return commandsSections
    }
    
    static func parseOnboardingJsonContent() -> ACOnboardingHelper {
        let jsonFile = ACFilenames.onboardingFile
        let onboardingContent = try! JSONDecoder().decode(ACOnboardingHelper.self, from: Data.load(from: jsonFile))
        return onboardingContent
    }
}


