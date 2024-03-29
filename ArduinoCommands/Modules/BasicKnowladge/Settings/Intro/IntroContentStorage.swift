//
//  IntroStorage.swift
//  ArduinoCommands
//
//  Created by User on 15.08.2022.
//

import Foundation
import SwiftUI

//MARK: - Intro section content Storage
public enum IntroContentStorage {
    
    //MARK: Static
    static let cards: [IntroCard] = [
        IntroCard(
            title: "Learn \npractice \nand read.",
            subtitle: "More than 50 articles",
            content: "You can read and learn a lot of new things about Arduino IDE and Wring programming framework. All the articles use a clear and accessible language. All Articles are available for reading Offline."
        ),
        IntroCard(
            title: "Screenshots, \ncode snippets, \ncustomization.",
            subtitle: "New features",
            content: "Each article about a particular command has screenshots with usage and code snippets with examples of how you can use it. Each article can be customized for the most comfortable reading."
        ),
        IntroCard(
            title: "Use \nlinks for \nfull immersion.",
            subtitle: "Learn Anywhere",
            content: "In the Resources section, you can find a bunch of links to the Webpages with more information about the programming language for creating Arduino programs."
        )
    ]
}


//MARK: - Constants
public extension IntroContentStorage {
    
    //MARK: Public
    enum Constants {
        enum UI {
            enum Gradients {
                
                //MARK: Static
                /**
                 Arduino Commands `Intro` section has a huge amount
                 of separate Views which have one single tint color.
                 
                 That's why, in order to not repeat initalization of one gradient varible
                 and to quicly change it if needed, we are initalizating it here
                 in `ACIntroStorage` file under Constants section to have quick accesst.
                 */
                static let tintGradient = Gradient(colors: [
                    Color(uiColor: UIColor(hexString: "#fc92a8").withAlphaComponent(0.80)),
                    Color(uiColor: UIColor(hexString: "#6764FF").withAlphaComponent(0.75))
                ])
            }
        }
    }
}
