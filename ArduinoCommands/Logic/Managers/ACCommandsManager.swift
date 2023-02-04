//
//  ACCommandsManager.swift
//  ArduinoCommands
//
//  Created by User on 09.12.2022.
//

import Foundation

//MARK: - Main Commands Manager protocol
protocol ACCommandsManagerProtocol {
    func unfilteredCommands() -> [ACCommand]
    func commandsThatReturn() -> [ACCommand]
    func commandsForDevices() -> [ACCommand]
    func commandsFromLibraries() -> [ACCommand]
    func orderedCommandSections() -> [ACCommandsSection]
}


//MARK: - Main Commands Manager
final class ACCommandsManager {
    
    //MARK: Static
    static let shared = ACCommandsManager()
    
    //MARK: Initialization
    private init() {}
}


//MARK: - Manager protocol extension
extension ACCommandsManager: ACCommandsManagerProtocol {
    
    //MARK: Internal
    /// This prepares all the sections with commands that are contained in the `commands` JSON file.
    /// This function is most likely to be used in the `CommandsListPresenter` file.
    /// - Returns: an array of filtered commands sections available in the App.
    internal func orderedCommandSections() -> [ACCommandsSection] {
        allSections()
    }
    
    /// This prepares all the commands that are contained in the `commands` JSON file.
    /// This function is most likely to be used in presenters from the `Commands` modules.
    /// - Returns: an unfiltered array of all commands available in the App.
    internal func unfilteredCommands() -> [ACCommand] {
        allCommands()
    }
    
    /// This prepares all commands that should return some data.
    /// This function is most likely to be used in presenters from the `Commands` modules.
    /// - Returns: an array of commands that return values.
    internal func commandsThatReturn() -> [ACCommand] {
        var returns: [ACCommand] = .init()
        for command in allCommands() {
            if command.returns {
                returns.append(command)
            }
        }
        return returns
    }
    
    /// This prepares all commands which are not embedded in the default Arduino IDE,
    /// but are exclusive to individual Arduino Libraries.
    /// This function is most likely to be used in presenters from the `Commands` modules.
    /// - Returns: an array of commands from Arduino Libraries.
    internal func commandsFromLibraries() -> [ACCommand] {
        var libraryCommands: [ACCommand] = .init()
        for command in allCommands() {
            if command.isLibraryMethod {
                libraryCommands.append(command)
            }
        }
        return libraryCommands
    }
    
    /// This prepares all commands that are used to communicate with different devices(servo motors, LEDs, etc.).
    /// This function is most likely to be used in presenters from the `Commands` modules.
    /// - Returns: an array of commands that are used with devices.
    internal func commandsForDevices() -> [ACCommand] {
        var forDevices: [ACCommand] = .init()
        for command in allCommands() {
            if command.isUsedWithDevices {
                forDevices.append(command)
            }
        }
        return forDevices
    }
}


//MARK: - Main methods
private extension ACCommandsManager {
    
    //MARK: Private
    func allSections() -> [ACCommandsSection] {
        ACAPIManager.parseCommandsSectionsJsonContent()
    }
    
    func allCommands() -> [ACCommand] {
        var rows: [ACCommand] = .init()
        for section in orderedCommandSections() {
            for command in section.commands {
                rows.append(command)
            }
        }
        return rows
    }
}
