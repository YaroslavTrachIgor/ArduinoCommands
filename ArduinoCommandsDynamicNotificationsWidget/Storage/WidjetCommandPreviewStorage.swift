//
//  CommandPreviewStorage.swift
//  ArduinoCommands
//
//  Created by User on 17.12.2022.
//

import Foundation

//MARK: - Command previews Storage
public enum CommandPreviewStorage {
    
    //MARK: Static
    /// This one below is needed to create a random Command Preview.
    ///
    /// The function is used in the main Widget timeline `Provider`,
    /// where Preview `Entry` updates every 24 hours.
    /// - Returns: Random Command Preview.
    static func randomPreview() -> CommandPreview {
        return CommandPreviewStorage.previews.randomElement()!
    }
    
    
    //MARK: Static
    static let previews = [
        CommandPreview(
            title: "Setup()",
            subtitle: "The Main Operators", 
            iconName: "command",
            previewContent: "The setup function is called when the sketch starts. Used to initialize variables, determine pin operation modes, run used libraries, etc.",
            isUsedForDevices: false,
            isInitial: true,
            returns: false
        ),
        CommandPreview(
            title: "Loop()",
            subtitle: "The Main Operators", 
            iconName: "command",
            previewContent: "After calling the setup function, which initializes and sets the initial values, the loop function does exactly what its name means, and loops around, allowing your program to perform calculations and react to them.",
            isUsedForDevices: false,
            isInitial: true,
            returns: false
        ),
        CommandPreview(
            title: "PinMode()",
            subtitle: "Commands for Digital I/O", 
            iconName: "macstudio",
            previewContent: "Sets whether the specified input/output will operate as an input or as an output. Learn more about digital input/outputs.",
            isUsedForDevices: true,
            isInitial: false,
            returns: false
        ),
        CommandPreview(
            title: "DigitalWrite()",
            subtitle: "Commands for Digital I/O", 
            iconName: "macstudio",
            previewContent: "Gives a HIGH or LOW value to a digital input/output. If an input/output has been set to output mode by the pinMode function",
            isUsedForDevices: true,
            isInitial: false,
            returns: false
        ),
        CommandPreview(
            title: "DigitalRead()",
            subtitle: "Commands for Digital I/O", 
            iconName: "macstudio",
            previewContent: "The function reads the value from the specified input HIGH or LOW. If the input is not connected then digitalRead may return HIGH or LOW randomly",
            isUsedForDevices: true,
            isInitial: false,
            returns: true
        ),
        CommandPreview(
            title: "AnalogWrite()",
            subtitle: "Commands for Analog I/O", 
            iconName: "macstudio",
            previewContent: "Outputs an analog value to the I/O port. The function can be useful for controlling the brightness of a connected LED or the speed of a motor.",
            isUsedForDevices: true,
            isInitial: false,
            returns: false
        ),
        CommandPreview(
            title: "AnalogRead()",
            subtitle: "Commands for Analog I/O", 
            iconName: "macstudio",
            previewContent: "The function reads the value from the specified analog input. Most Arduino boards have 6 channels with a 10-bit analog-to-digital converter.",
            isUsedForDevices: true,
            isInitial: false,
            returns: true
        )
    ]
}
