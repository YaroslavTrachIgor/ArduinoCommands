//
//  HTTPURLResponseExtensions.swift
//  ArduinoCommands
//
//  Created by User on 2023-02-24.
//

import Foundation

//MARK: - Fast URL Response checks
public extension HTTPURLResponse {
    
    //MARK: Public
    var isValidStatusCode: Bool {
        return (200...299).contains(self.statusCode)
    }
}
