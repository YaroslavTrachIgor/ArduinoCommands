//
//  ACApplicationAPIClient.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

//MARK: - Application API Client base completion Handler
typealias ACApplicationAPICompletionHandler = ((Result<ACApplication, APIError.ACRequestError>) -> Void)


//MARK: - Application API Client protocol
protocol ACApplicationAPIClientProtocol {
    func getApplicationResponse() async throws -> ACApplication?
}


//MARK: - Main Application API Client
final public class ACApplicationAPIClient: APIHelper, ACApplicationAPIClientProtocol {
    
    //MARK: Internal
    func getApplicationResponse() async throws -> ACApplication? {
        do {
            let data = try await self.get()
            if let response: ACApplication = ACJSON.decode(data) {
                return response
            } else {
                return nil
            }
        } catch {
            throw APIError.ACRequestError.unknownApplicationAPIGetError
        }
    }
}

