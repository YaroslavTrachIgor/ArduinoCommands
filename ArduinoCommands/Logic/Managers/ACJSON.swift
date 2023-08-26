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
    static func decode<C: Decodable>(_ data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) -> C? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        let obj = try? decoder.decode(C.self, from: data)
        return obj
    }
    
    static func encode<C: Encodable>(_ obj: C, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601) -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dateEncodingStrategy
        let data = try? encoder.encode(obj)
        return data
    }
}
