//
//  NumericExtensions.swift
//  ArduinoCommands
//
//  Created by User on 09.09.2022.
//

import Foundation

//MARK: - Color code into `Data` converter extenion
public extension Numeric {
    
    //MARK: Public
    var data: Data {
        var bytes = self
        let count = MemoryLayout<Self>.size
        return Data(bytes: &bytes, count: count)
    }
}
