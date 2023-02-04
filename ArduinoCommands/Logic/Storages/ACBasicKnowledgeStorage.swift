//
//  BasicKnowledgeStorage'.swift
//  ArduinoCommands
//
//  Created by User on 27.06.2022.
//

import Foundation
import UIKit

//MARK: - Section Type cases
enum BasicKnowledgeSectionRow {
    case links([ACLinkCellModel])
    case team([ACPersonCellModel])
    case users([ACUserCellModel])
    case basics([ACBasicsCellModel])
}


//MARK: - Constants
public extension ACBasicKnowledgeStorage {
    
    //MARK: Public
    enum Constants {
        enum BasicsSection {
            
            //MARK: Static
            static let tintColor = UIColor.white
        }
        enum UsersSection {
            
            //MARK: Static
            static let contentTintColor = UIColor(hexString: "#2ea636")
            static let secondaryColor = UIColor.systemPurple
        }
        enum TeamSection {
            
            //MARK: Static
            static let contentTintColor = UIColor(hexString: "#3b74d1")
            static let contentSecondaryTintColor = UIColor(hexString: "#4287f5")
            static let secondaryBackColor = UIColor.secondarySystemBackground
            static let secondaryTintColor = UIColor.white
        }
        enum LinksSection {
            
            //MARK: Static
            static let contentTintColor = UIColor(hexString: "#ed8f03")
            static let contentSecondaryTintColor = UIColor(hexString: "#ffb75e")
            static let secondaryBackColor = UIColor.secondarySystemBackground
            static let secondaryTintColor = UIColor.white
        }
    }
}


//MARK: - BasicKnowledge section content Storage
public enum ACBasicKnowledgeStorage {
    
    //MARK: Statiс
    /// This fills an array of sections  for `Basic Knowledge` Menu VC.
    ///
    /// Such method of configuring sections and tableView
    /// makes our code much more flexible and convenient for reusing(Data-Driven UI principle).
    /// - Returns: the sequence of sections.
    static func prepareSections() -> [BasicKnowledgeSectionRow] {
        var sections = [BasicKnowledgeSectionRow]()
        sections.append(.basics(ACBasicKnowledgeStorage.basicsModels))
        sections.append(.team(ACBasicKnowledgeStorage.teamModels))
        sections.append(.links(ACBasicKnowledgeStorage.sitesModels))
        sections.append(.users(ACBasicKnowledgeStorage.usersModels))
        return sections
    }
    
    
    //MARK: Static
    static let basicsModels = [
        ACBasicsCellModel(
            content: ACBasics(
                title: "Arduino \nIDE",
                decoTitle: "Arduino IDE",
                subtitle: nil,
                preview: "Integrated middleware for creating and uploading a program to an Arduino summation board.",
                stringSiteUrl: ACURLs.Materials.wikiArduino,
                description: "Arduino IDE is an integrated development environment for Windows, MacOS and Linux, developed in C and C ++, designed to create and upload programs to Arduino-compatible boards, as well as boards from other manufacturers. The source code for the environment is released under the GNU General Public License version 2. Supports C and C++ languages ​​using special code structuring rules. The Arduino IDE provides a software library from the Wiring project that provides many common input and output routines. User-written code requires only two basic functions to run the sketch and the main program loop, which are compiled and linked with the main() program stub into an executable loop program with the GNU toolchain also included in the IDE distribution.",
                date: Date.from(year: 2021, month: 12, day: 05)
            ),
            backColor: UIColor(hexString: "#6e48aa"),
            tintColor: Constants.BasicsSection.tintColor,
            secondaryColor: UIColor(hexString: "#9d50bb"),
            shadowAvailable: true,
            decorationImageName: "computer-work-0"
        ),
        ACBasicsCellModel(
            content: ACBasics(
                title: "Operating \nSystems",
                decoTitle: "Operating Systems",
                subtitle: nil,
                preview: "The Arduino IDE is requred to use on Windows, Linux, macOS and other operation systems.",
                stringSiteUrl: ACURLs.Materials.wikiArduino,
                description: "The IDE supports Windows, MacOS and Linux. With the popularity of Arduino, other vendors have started introducing custom compilers and open source tools (kernels) as a software platform that can create and upload sketches to other microcontrollers not supported by the official Arduino line of microcontrollers.",
                date: Date.from(year: 2022, month: 4, day: 06)
            ),
            backColor: UIColor(hexString: "#e53935"),
            tintColor: Constants.BasicsSection.tintColor,
            secondaryColor: UIColor(hexString: "#e35d5b"),
            shadowAvailable: true,
            decorationImageName: "computer-work-3"
        ),
        ACBasicsCellModel(
            content: ACBasics(
                title: "Programming \nlanguages",
                decoTitle: "Programming languages",
                subtitle: nil,
                preview: "The Arduino IDE is written in such programming languages like C, C++ and Java on Wring framework.",
                stringSiteUrl: ACURLs.Materials.wikiArduino,
                description: "The source code for the environment is released under the GNU General Public License version 2. Supports C and C++ languages ​​using special code structuring rules. The Arduino IDE provides a software library from the Wiring project that provides many common input and output routines. User-written code requires only two basic functions to run the sketch and the main program loop, which are compiled and linked with the main() program stub into an executable loop program with the GNU toolchain also included in the IDE distribution.",
                date: Date.from(year: 2022, month: 6, day: 11)
            ),
            backColor: UIColor(hexString: "#0083b0"),
            tintColor: Constants.BasicsSection.tintColor,
            secondaryColor: UIColor(hexString: "#00b4db"),
            shadowAvailable: true,
            decorationImageName: "computer-work-1"
        )
    ]
    static let teamModels = [
        ACPersonCellModel(
            person: ACPerson(
                name: "Trach \nYaroslav",
                role: "Developer",
                description: "He was responsible for creating a design framework, creating task examples, and publishing the App in the App Store."
            ),
            roleIcon: "bookmark.circle.fill",
            tintColor: Constants.TeamSection.secondaryTintColor,
            backColor: Constants.TeamSection.contentTintColor,
            secondaryColor: Constants.TeamSection.contentSecondaryTintColor,
            shadowAvailable: true,
            backImageName: "shape-team-deco"
        ),
        ACPersonCellModel(
            person: ACPerson(
                name: "Gleb \nLutskiy",
                role: "Designer",
                description: "He was responsible for supporting the constant design of the directory, writing text to the commands of special libraries."
            ),
            roleIcon: "paperclip.circle.fill",
            tintColor: Constants.TeamSection.secondaryTintColor,
            backColor: Constants.TeamSection.contentTintColor,
            secondaryColor: Constants.TeamSection.contentSecondaryTintColor,
            shadowAvailable: true,
            backImageName: "shape-team-deco-1"
        ),
        ACPersonCellModel(
            person: ACPerson(
                name: "Maria \nMoshkov",
                role: "Designer",
                description: "She was responsible for editing and creating screenshots of example tasks, helped with the presentation."
            ),
            roleIcon: "paperclip.circle.fill",
            tintColor: Constants.TeamSection.contentSecondaryTintColor,
            backColor: Constants.TeamSection.secondaryBackColor,
            secondaryColor: Constants.TeamSection.contentSecondaryTintColor,
            shadowAvailable: false,
            backImageName: "shape-team-deco-2"
        ),
        ACPersonCellModel(
            person: ACPerson(
                name: "Uriy \nVoloshen",
                role: "Writer",
                description: "He was responsible for the analysis information about IDE commands and devices used with them."
            ),
            roleIcon: "pencil.circle.fill",
            tintColor: Constants.TeamSection.contentSecondaryTintColor,
            backColor: Constants.TeamSection.secondaryBackColor,
            secondaryColor: Constants.TeamSection.contentSecondaryTintColor,
            shadowAvailable: false,
            backImageName: "shape-team-deco-3"
        )
    ]
    static let usersModels = [
        ACUserCellModel(
            content: ACUser(
                name: "Yaroslav",
                surname: "Trach",
                role: "Developer",
                age: 21,
                iconName: "user-1-icon",
                dateWhenAdded: Date.from(year: 2019, month: 11, day: 15),
                secondaryColor: UIColor.systemTeal,
                roleDescription: "Yaroslav Trach was the founder of Arduino Commands - Electronics. He was responsible for creating the basic idea of design, developing and writing code for App. He organized the use of all content and checked its quality. Furthermore, he was responsible for the release of ArduinoCommands in the App Store.",
                extraInfo: "Founder",
                roleLabelWidth: 104,
                extraInfoLabelWidth: 92
            ),
            tintColor: Constants.UsersSection.contentTintColor
        ),
        ACUserCellModel(
            content: ACUser(
                name: "Gleb",
                surname: "Lutskiy",
                role: "Designer",
                age: 18,
                iconName: "user-3-icon",
                dateWhenAdded: Date.from(year: 2021, month: 09, day: 30),
                secondaryColor: Constants.UsersSection.secondaryColor,
                roleDescription: "Gleb Lutsky was responsible for checking the stable design of the App and preparing information about library commands.",
                extraInfo: "",
                roleLabelWidth: 95,
                extraInfoLabelWidth: 0
            ),
            tintColor: Constants.UsersSection.contentTintColor
        ),
        ACUserCellModel(
            content: ACUser(
                name: "Maria",
                surname: "Moshkovska",
                role: "Designer",
                age: 19,
                iconName: "user-2-icon",
                dateWhenAdded: Date.from(year: 2022, month: 12, day: 10),
                secondaryColor: Constants.UsersSection.secondaryColor,
                roleDescription: "She was responsible for editing and creating screenshots of example tasks which developers were preparing using Tinkercad service(you can view her work on any Command Detailed screen that also gives you an opportunity to see the screenshot of usage).",
                extraInfo: "New",
                roleLabelWidth: 95,
                extraInfoLabelWidth: 58
            ),
            tintColor: Constants.UsersSection.contentTintColor
        ),
        ACUserCellModel(
            content: ACUser(
                name: "Uriy",
                surname: "Voloshenko",
                role: "Writer",
                age: 38,
                iconName: nil,
                dateWhenAdded: Date.from(year: 2022, month: 05, day: 05),
                secondaryColor: Constants.UsersSection.secondaryColor,
                roleDescription: "Uriy Voloshenko was responsible for analising information on the Internet which concerns the Arduino IDE programming language, commands and devices used with them. Additionally, he prepared a bunch of sites and resources with content about the Arduino platform which was incredibly important for the App.",
                extraInfo: "New",
                roleLabelWidth: 80,
                extraInfoLabelWidth: 58
            ),
            tintColor: Constants.UsersSection.contentTintColor
        )
    ]
    static let sitesModels = [
        ACLinkCellModel(
            content: ACLink(
                name: "Arduino.ru",
                link: ACURLs.Materials.arduinoRu
            ),
            tintColor: Constants.LinksSection.secondaryTintColor,
            backColor: Constants.LinksSection.contentTintColor,
            secondaryColor: Constants.LinksSection.contentSecondaryTintColor,
            shadowAvailable: true,
            decorationBackImageName: "shape-site-deco"
        ),
        ACLinkCellModel(
            content: ACLink(
                name: "Arduino.cc",
                link: ACURLs.Materials.arduinoCc
            ),
            tintColor: Constants.LinksSection.secondaryTintColor,
            backColor: Constants.LinksSection.contentTintColor,
            secondaryColor: Constants.LinksSection.contentSecondaryTintColor,
            shadowAvailable: true,
            decorationBackImageName: "shape-site-deco-3"
        ),
        ACLinkCellModel(
            content: ACLink(
                name: "Wikipedia",
                link: ACURLs.Materials.wikiArduino
            ),
            tintColor: Constants.LinksSection.contentSecondaryTintColor,
            backColor: Constants.LinksSection.secondaryBackColor,
            secondaryColor: Constants.LinksSection.contentSecondaryTintColor,
            shadowAvailable: false,
            decorationBackImageName: "shape-site-deco-1"
        ),
        ACLinkCellModel(
            content: ACLink(
                name: "KIBER KODER",
                link: ACURLs.Materials.kiberKoder
            ),
            tintColor: Constants.LinksSection.secondaryTintColor,
            backColor: Constants.LinksSection.contentTintColor,
            secondaryColor: Constants.LinksSection.contentSecondaryTintColor,
            shadowAvailable: true,
            decorationBackImageName: "shape-site-deco-2"
        ),
        ACLinkCellModel(
            content: ACLink(
                name: "All-arduino.ru",
                link: ACURLs.Materials.allArduino
            ),
            tintColor: Constants.LinksSection.secondaryTintColor,
            backColor: Constants.LinksSection.contentTintColor,
            secondaryColor: Constants.LinksSection.contentSecondaryTintColor,
            shadowAvailable: true,
            decorationBackImageName: "shape-site-deco-3"
        )
    ]
}
