//
//  StringExtensions.swift
//  ArduinoCommands
//
//  Created by User on 21.08.2022.
//

import Foundation

//MARK: - Fast Methods for String text preparations
public extension String {
    
    //MARK: Public
    /// This puts spaces between string characters.
    /// - Returns: prapared `NavigationItem` String title in capital letters.
    mutating func transformInTitle() -> String {
        /**
         Due to the special features of the application font style(`Hiragino Mincho ProN`)
         we add small spaces between characters.
         By doing this we will get a good design solution
         */
        let separator = " "
        let title = self.map { "\($0)" }.joined(separator: separator)
        return title.uppercased()
    }
}
