//
//  ACCommandsManager.swift
//  ArduinoCommands
//
//  Created by User on 09.12.2022.
//

import Foundation

//MARK: - Commands API Client protocol
protocol ACCommandsAPIClientProtocol {
    func unfilteredCommands() -> [ACCommand]
    func commandsThatReturn() -> [ACCommand]
    func commandsForDevices() -> [ACCommand]
    func commandsFromLibraries() -> [ACCommand]
    func orderedCommandSections() -> [ACCommandsSection]
}


//MARK: - Main Commands API Client
final class ACCommandsAPIClient: APIHelper, ACCommandsAPIClientProtocol {
    
    //MARK: Internal
    /// This prepares all the sections with commands that are contained in the `commands` JSON file.
    /// This function is most likely to be used in the `onViewDidLoad` function in the Commands List presenter.
    /// - Returns: an array of filtered commands sections available in the App.
    internal func orderedCommandSections() -> [ACCommandsSection] {
        allSections()
    }
    
    /// This prepares all Arduino commands that are contained in the `commands` JSON file.
    /// This function is most likely to be used while the SearchBar on the CommandsListTVController is active.
    /// - Returns: an unfiltered array of all commands available in the App.
    internal func unfilteredCommands() -> [ACCommand] {
        allCommands()
    }
    
    /// This prepares all Arduino commands that should return some data.
    /// This function is most likely to be used when a user taps on the *Returns* segmented button on the Commands Menu VC.
    /// - Returns: an array of commands that return values.
    internal func commandsThatReturn() -> [ACCommand] {
        allCommands().filter { $0.returns }
    }
    
    /// This prepares all Arduino commands which are not embedded in the default Arduino IDE,
    /// but are exclusive to individual Arduino Libraries.
    /// This function is most likely to be used when a user taps on the *Libraries* segmented button on the Commands Menu VC.
    /// - Returns: an array of commands from Arduino Libraries.
    internal func commandsFromLibraries() -> [ACCommand] {
        allCommands().filter { $0.isLibraryMethod }
    }
    
    /// This prepares all Arduino commands that are used to communicate with different devices(Servomotors, LEDs, etc.).
    /// This function is most likely to be used when a user taps on the *Devices* segmented button on the Commands Menu VC.
    /// - Returns: an array of commands that are used with devices.
    internal func commandsForDevices() -> [ACCommand] {
        allCommands().filter { $0.isUsedWithDevices }
    }
}


//MARK: - Main methods
private extension ACCommandsAPIClient {
    
    //MARK: Private
    /// This fetches the Commands List API.
    /// In case any problems arise during the parsing,
    /// we will return an empty array and issue a warning about an unexpected error (see in presenter).
    /// - Returns: an array of commands' sections sorted by commands' type.
    func allSections() -> [ACCommandsSection] {
        do {
            if let sections: [ACCommandsSection] = try parse() {
                return sections
            } else {
                return []
            }
        } catch {
            return []
        }
    }
    
    /// This combines all the command sections into one big commands array to provide easy filtering when needed.
    /// The method will be used to sort commands by their type (*Initial, Method, Returns, Library*)
    /// - Returns: an array of all the commands available in the app.
    func allCommands() -> [ACCommand] {
        return allSections().flatMap { $0.commands }
    }
}
