//
//  UIImageViewExtensions.swift
//  ArduinoCommands
//
//  Created by User on 2023-02-23.
//

import Foundation
import UIKit

//MARK: - Fast ImageView methods
public extension UIImageView {
    
    //MARK: Public
    /// This is needed to quickly download an image form the Internet
    /// or from Cache and place it into an image view.
    ///
    /// *This function will be used in UICollectionViewCell or UITableViewCell set up files.*
    /// *That is, in the files where we have only one data row (URL) available.*
    /// - Parameters:
    ///    - url: image URL.
    func downloadImage(with url: URL?) {
        guard let url = url else { return }
        let key = url.absoluteString
        let cache = ACCache.defaults
        if let cachedImage = cache.getImage(forKey: key) {
            self.image = cachedImage
        } else {
            Task {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.isValidStatusCode else {
                        throw APIError.ACRequestError.invalidDataError
                    }
                    guard let image = UIImage(data: data) else { return }
                    cache.saveImage(image: image, forKey: key)
                    /**
                     After downloading an image from the web via the background thread,
                     we use `MainActor`to move to the main thread to set up the UI Element.
                     */
                    await MainActor.run {
                        self.image = image
                    }
                } catch {
                    image = nil
                }
            }
        }
    }
}
