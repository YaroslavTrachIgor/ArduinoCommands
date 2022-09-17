//
//  IntroStorage.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Intro section content Storage
public enum ACIntroStorage {
    
    //MARK: Static
    static let cards: [IntroCardUIModel] = [
        IntroCardUIModel(
            model: ACIntroCard(
                title: "Learn \npractice \nand read.",
                subtitle: "More than 50 articles",
                content: "You can read and learn a lot of information about Arduino IDE, Wring programming framework every day. All articles are presented in a clear and accessible language."
            )
        ),
        IntroCardUIModel(
            model: ACIntroCard(
                title: "Screenshots, \ncode snippets, \ncustomization.",
                subtitle: "New features",
                content: "Each article about a particular command has screenshots with usage and code snippets with examples of how you can use it. Each article can be customized for the most comfortable reading."
            )
        ),
        IntroCardUIModel(
            model: ACIntroCard(
                title: "Use \nlinks for \nfull immersion.",
                subtitle: "Learn Anywhere",
                content: "In the Resources section, you can find a bunch of links to Internet sites with more information about the programming language for creating Arduino programs."
            )
        )
    ]
}
