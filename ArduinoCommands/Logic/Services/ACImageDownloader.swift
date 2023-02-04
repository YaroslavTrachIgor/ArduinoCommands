//
//  ACImageDownloader.swift
//  ArduinoCommands
//
//  Created by User on 04.02.2023.
//

import Foundation
import UIKit

//MARK: - Keys
private extension ACImageDownloader {
    
    //MARK: Private
    enum Keys {
        enum ErrorMessage {
            
            //MARK: Static
            static let title = "Image Loading Error"
            static let message = "Detailed Error message: "
        }
    }
}


//MARK: - Images Downloader API Client base completion Handler
typealias ACImageDownloaderCompletionHandler = ((UIImage?) -> ())


//MARK: - Images Downloader API Client protocol
protocol ACImageDownloaderProtocol {
    func downloadImage(completion: @escaping ACImageDownloaderCompletionHandler)
}


//MARK: - Main Images Downloader API Client
final public class ACImageDownloader: APIHelper, ACImageDownloaderProtocol {
    
    //MARK: Internal
    internal func downloadImage(completion: @escaping ACImageDownloaderCompletionHandler) {
        self.get { [weak self] result in
            switch result {
            case .success(let data):
                completion(UIImage(data: data))
            case .failure(let error):
                self?.showErrorMessage(with: error)
            }
        }
    }
}


//MARK: - Main methods
private extension ACImageDownloader {
    
    //MARK: Private
    func showErrorMessage(with error: Error) {
        let title = Keys.ErrorMessage.title
        let message = Keys.ErrorMessage.message + error.localizedDescription
        ACGrayAlertManager.present(title: title, message: message)
    }
}
