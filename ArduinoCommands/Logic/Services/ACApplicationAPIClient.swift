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
    func getApplicationResponse(completion: @escaping ACApplicationAPICompletionHandler)
}


//MARK: - Main Application API Client
final public class ACApplicationAPIClient: APIHelper, ACApplicationAPIClientProtocol {
    
    //MARK: Internal
    func getApplicationResponse(completion: @escaping ACApplicationAPICompletionHandler) {
        self.get { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder(); decoder.configureBaseDecoder()
                    let response = try decoder.decode(ACApplication.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.unknownApplicationAPIGetError))
                }
            case .failure(_):
                break
            }
        }
    }
}
