//
//  APIHelper.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

//MARK: - API Errors list
public enum APIError {
    
    //MARK: Public
    public enum ACRequestError: String, Error {
        case invalidURLError = "The URL is invalid."
        case sessionError = "Session task error. Check your Wifi-Connection."
        case invalidDataError = "Model Data equals to nil. You need to check JSON model structure integrity."
        case unknownApplicationAPIGetError = "Unknown Application API Get request error. Please, try again."
    }

    public enum ACParsingError: String, Error {
        case fileNameIsNil = "JSON file name is nil."
        case invalidBundle = "Failed to locate JSON file in bundle."
        case invalidData = "Failed to load JSON file from bundle."
    }
}


//MARK: - API Base Completion Handler
typealias APIGetRequestCompletionHandler = ((Result<Data, APIError.ACRequestError>) -> Void)


//MARK: - API Helper protocol
protocol APIHelperProtocol {
    init(url: URL?)
    func get() async throws -> Data
    func persist<C: Encodable>(_ data: C?)
    func parse<T: Decodable>() throws -> T?
}


//MARK: - Main API Helper
public class APIHelper: APIHelperProtocol {

    //MARK: Public
    var url: URL?
    var fileName: String?
    
    //MARK: Private
    private let session = URLSession(configuration: .default)
    
    
    //MARK: Initialization
    required init(url: URL?) {
        self.url = url
    }
    
    convenience init(fileName: String) {
        self.init(url: nil)
        self.fileName = fileName
    }
    
    
    //MARK: Internal
    /// This creates a simple `GET` URL request.
    /// - Parameter completion: gives opportunity to work in `APIClients` with content of different `Codable` models in the future.
    func get() async throws -> Data {
        guard let url = url else { throw APIError.ACRequestError.invalidURLError }
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.isValidStatusCode else {
            throw APIError.ACRequestError.sessionError
        }
        return data
    }
    
    /// This encodes project's models into the local JSON files.
    /// - Parameter data: Codable model that will be encoded into local JSON.
    func persist<C: Encodable>(_ data: C?) {
        guard let fileName = self.fileName else { return }
        guard let data = data, let encodedData = ACJSON.encode(data) else { return }
        UserDefaults.standard.set(encodedData, forKey: fileName)
    }
    
    /// This decodes JSON content from the project's files and transforms it into a model.
    /// - Returns: parsed Codable model.
    func parse<T: Decodable>() throws -> T? {
        guard let fileName = self.fileName else { return nil }
        let data = try Data.load(from: fileName)
        return ACJSON.decode(data)
    }
}
