//
//  APIHelper.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

typealias APIGetRequestCompletionHandler = ((Result<Data, ACRequestError>) -> Void)


//MARK: - API Helper protocol
protocol APIHelperProtocol {
    init(url: URL?)
    func get(completion: @escaping APIGetRequestCompletionHandler)
}


//MARK: - Main API Helper
public class APIHelper: APIHelperProtocol {

    //MARK: Private
    private let session = URLSession(configuration: .default)
    private var url: URL?
    
    
    //MARK: Initialization
    required init(url: URL?) {
        self.url = url
    }
    
    //MARK: Internal
    /// This creates a simple `GET` URL request.
    /// - Parameter completion: gives opportunity to work in `APIClients` with content of different `Codable` models in the future.
    func get(completion: @escaping APIGetRequestCompletionHandler) {
        let session = URLSession.shared
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [self] data, response, error in
            guard url != nil else { completion(.failure(.invalidURLError)); return }
            guard error == nil else { completion(.failure(.sessionError)); return }
            guard let data = data else { completion(.failure(.invalidDataError)); return }
            completion(.success(data))
        })
        task.resume()
    }
}
