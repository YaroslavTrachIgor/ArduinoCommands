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
    func transformInTitle() -> String {
        /**
         Due to the special features of the application font style(`Hiragino Mincho ProN`)
         we add small spaces between characters.
         By doing this we will get a good design solution
         */
        let separator = " "
        let title = self.map { "\($0)" }.joined(separator: separator)
        return title.uppercased()
    }
    
    /// This removes last two symbols in string.
    /// - Returns: string without last two characters.
    mutating func removeScopes() -> String {
        /**
         In Code Snippet VCs, we need to bold some particular parts of content.
         In most cases, these bold parts are command names.
         But all the command names we can get from our JSON data has `()` ending,
         and in the code examples these endings are absolutely different.
         That's why we create a function that can remove a default command neme ending,
         and nothing wil distract the work of `addBoldText(...)` function.
         */
        let edittedName = String(self.dropLast().dropLast())
        return edittedName
    }
}
