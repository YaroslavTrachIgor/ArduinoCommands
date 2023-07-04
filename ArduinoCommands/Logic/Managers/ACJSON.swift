//
//  JSONManager.swift
//  ArduinoCommands
//
//  Created by User on 2023-04-30.
//

import Foundation

//MARK: - Manager for fast JSON manipulations
final class ACJSON {
    
    //MARK: Static
    static func decode<C: Decodable>(_ data: Data) -> C? {
        let obj = try? JSONDecoder().decode(C.self, from: data)
        return obj
    }
    
    static func encode<C: Encodable>(_ obj: C) -> Data? {
        let data = try? JSONEncoder().encode(obj)
        return data
    }
}
