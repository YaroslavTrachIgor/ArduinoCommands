//
//  ACApplicationAPIClient.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

//MARK: - Application API Client base completion Handler
typealias ACApplicationAPICompletionHandler = ((Result<ACApplication, ACRequestError>) -> Void)


//MARK: - Application API Client protocol
protocol ACApplicationAPIClientProtocol {
    func getApplicationResponse() async throws -> ACApplication
}


//MARK: - Main Application API Client
final public class ACApplicationAPIClient: APIHelper, ACApplicationAPIClientProtocol {
    
    //MARK: Internal
    func getApplicationResponse() async throws -> ACApplication {
        let data = try await self.get()
        let decoder = JSONDecoder(); decoder.configureBaseDecoder()
        do {
            let response = try decoder.decode(ACApplication.self, from: data)
            return response
        } catch {
            throw ACRequestError.unknownApplicationAPIGetError
        }
    }
}

