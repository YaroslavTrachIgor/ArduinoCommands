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
    
    //MARK: Private
    private var cache = ACCache.defaults
    
    //MARK: Internal
    internal func downloadImage(completion: @escaping ACImageDownloaderCompletionHandler) {
        guard let stringURL = self.url?.absoluteString else { return }
        if let cachedImage = cache.getImage(forKey: stringURL)  {
            completion(cachedImage)
        } else {
            Task {
                do {
                    let data = try await self.get()
                    guard let image = UIImage(data: data) else { return }
                    cache.saveImage(image: image, forKey: stringURL)
                    await MainActor.run { completion(image) }
                } catch {
                    showErrorMessage(with: error)
                }
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
