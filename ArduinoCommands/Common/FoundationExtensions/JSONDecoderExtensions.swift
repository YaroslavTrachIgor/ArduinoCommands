//
//  JSONDecoderExtensions.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

//MARK: - Fast JSONDecoder methods
public extension JSONDecoder {
    
    //MARK: Public
    func configureBaseDecoder(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
                              dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData
    ) {
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dataDecodingStrategy = dataDecodingStrategy
    }
}
