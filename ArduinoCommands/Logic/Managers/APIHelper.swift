//
//  APIHelper.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

//MARK: - API Base Completion Handler
typealias APIGetRequestCompletionHandler = ((Result<Data, ACRequestError>) -> Void)


//MARK: - API Helper protocol
protocol APIHelperProtocol {
    init(url: URL?)
    func get() async throws -> Data
}


//MARK: - Main API Helper
public class APIHelper: APIHelperProtocol {

    //MARK: Public
    var url: URL?
    
    //MARK: Private
    private let session = URLSession(configuration: .default)
    
    
    //MARK: Initialization
    required init(url: URL?) {
        self.url = url
    }
    
    //MARK: Internal
    /// This creates a simple `GET` URL request.
    /// - Parameter completion: gives opportunity to work in `APIClients` with content of different `Codable` models in the future.
    func get() async throws -> Data {
        guard let url = url else { throw ACRequestError.invalidURLError }
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.isValidStatusCode else {
            throw ACRequestError.sessionError
        }
        return data
    }
}
