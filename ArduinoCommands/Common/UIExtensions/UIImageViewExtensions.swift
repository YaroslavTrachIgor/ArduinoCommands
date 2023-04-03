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
    func downloadImage(with url: URL?) {
        guard let url = url else { return }
        let key = url.absoluteString
        let cache = ACCache.defaults
        /**
         /////////////////////////////
         */
        if let cachedImage = cache.getImage(forKey: key) {
            image = cachedImage
        } else {
            Task {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.isValidStatusCode else {
                        throw ACRequestError.invalidDataError
                    }
                    /**
                     ///////////////////////////////
                     */
                    guard let image = UIImage(data: data) else { return }
                    cache.saveImage(image: image, forKey: key)
                    /**
                     /////////////////////////////
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
