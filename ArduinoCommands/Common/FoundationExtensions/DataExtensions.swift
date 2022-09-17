//
//  DataExtensions.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 28.05.2022.
//

import Foundation
import UIKit

//MARK: - Data values converting to Color type
public extension Data {
    
    //MARK: Public
    /// This converts `Data` value into needed  type.
    /// - Returns: converted Value.
    func object<T>() -> T { withUnsafeBytes{ $0.load(as: T.self) } }
    var color: UIColor { .init(data: self) }
}


//MARK: - Fast Data getting from JSON file
public extension Data {
    
    //MARK: Static
    /// This converts `JSON` file content into model inherted from `Codable`.
    /// - Parameters:
    ///   - jsonFile: files name.
    ///   - bundle: files location.
    /// - Returns: Json file content in `Data` type.
    static func load(from jsonFile: String, bundle: Bundle = Bundle.main) -> Data {
        /**
         This function should be used to quickly convert `JSON` content to `Data` format
         by reading all the content from the project file with using its Bundle name.
         
         In the case when we failed to read the information or the file name is written incorrectly,
         we will issue a fatal error.
         */
        guard let urlString = bundle.path(forResource: jsonFile, ofType: "json") else {
            fatalError("Failed to locate \(jsonFile) in bundle.")
        }
        guard let contentData = FileManager.default.contents(atPath: urlString) else {
            fatalError("Failed to load \(jsonFile) from bundle.")
        }
        return contentData
    }
}
