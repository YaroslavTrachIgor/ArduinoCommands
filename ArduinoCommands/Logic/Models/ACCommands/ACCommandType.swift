//
//  ACCommandType.swift
//  ArduinoCommands
//
//  Created by User on 26.11.2022.
//

import Foundation

//MARK: - Command Type
public enum ACCommandType: String {
    case all = "All"
    case returns = "Returns"
    case libraries = "Libraries"
    case forDevices = "For Devices"
}


//MARK: - CaseIterable protocol extension
extension ACCommandType: CaseIterable {
    
    //MARK: Static
    public static var allCases: [ACCommandType] {
        return [.all, .forDevices, .returns, .libraries]
    }
    
    public static var allNames: [String] {
        var names = [String]()
        let commandTypes = ACCommandType.allCases
        for commandType in commandTypes {
            let name = commandType.rawValue
            names.append(name)
        }
        return names
    }
}
