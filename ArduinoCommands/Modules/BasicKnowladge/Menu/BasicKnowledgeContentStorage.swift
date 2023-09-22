//
//  BasicKnowledgeStorage'.swift
//  ArduinoCommands
//
//  Created by User on 27.06.2022.
//

import Foundation
import UIKit

//MARK: - Section Type
enum BasicKnowledgeSectionRow {
    case links([ACLinkCellModel])
    case team([ACPersonCellModel])
    case users([ACUserCellModel])
    case basics([ACBasicsCellModel])
}


//MARK: - Constants
public extension BasicKnowledgeContentStorage {
    
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


//MARK: - BasicKnowledge sections content Storage
public enum BasicKnowledgeContentStorage {
    
    //MARK: Statiс
    /// This fills an array of sections  of `BasicKnowledge` Menu VC.
    ///
    /// Such method of configuring sections and tableView
    /// makes our code much more flexible and convenient for reusing (Data-Driven UI principle).
    /// - Returns: the sequence of sections.
    static func prepareSections() -> [BasicKnowledgeSectionRow] {
        var sections = [BasicKnowledgeSectionRow]()
        sections.append(.basics(BasicKnowledgeContentStorage.basicsModels))
        sections.append(.team(BasicKnowledgeContentStorage.teamModels))
        sections.append(.links(BasicKnowledgeContentStorage.sitesModels))
        sections.append(.users(BasicKnowledgeContentStorage.usersModels))
        return sections
    }
    
    
    //MARK: Static
    static let basicsModels = [
        ACBasicsCellModel(
            content: ACBasics(
                title: "Arduino \nIDE",
                decoTitle: "Arduino IDE",
                subtitle: nil,
                preview: "Integrated middleware for creating and uploading a program...",
                stringSiteUrl: ACURLs.Materials.wikiArduino,
                description: "Arduino IDE is an integrated development environment for Windows, MacOS and Linux, developed in C and C ++, designed to create and upload programs to Arduino-compatible boards, as well as boards from other manufacturers. The source code for the environment is released under the GNU General Public License version 2. Supports C and C++ languages ​​using special code structuring rules.\n\nThe Arduino IDE provides a software library from the Wiring project that provides many common input and output routines. User-written code requires only two basic functions to run the sketch and the main program loop, which are compiled and linked with the main() program stub into an executable loop program with the GNU toolchain also included in the IDE distribution.\n\n",
                date: Date.from(year: 2021, month: 12, day: 05)
            ),
            backColor: UIColor(hexString: "#013b85"),
            tintColor: Constants.BasicsSection.tintColor,
            secondaryColor: UIColor(hexString: "#034394"),
            shadowAvailable: true,
            decorationImageName: "computer-work-0"
        ),
        ACBasicsCellModel(
            content: ACBasics(
                title: "Programming \nLanguages",
                decoTitle: "Programming languages",
                subtitle: nil,
                preview: "The Arduino IDE is written in such programming languages...",
                stringSiteUrl: ACURLs.Materials.wikiArduino,
                description: "The source code for the environment is released under the GNU General Public License version 2. Supports C and C++ languages ​​using special code structuring rules.\n\nThe Arduino IDE provides a software library from the Wiring project that provides many common input and output routines. User-written code requires only two basic functions to run the sketch and the main program loop, which are compiled and linked with the main() program stub into an executable loop program with the GNU toolchain also included in the IDE distribution.\n\n",
                date: Date.from(year: 2022, month: 6, day: 11)
            ),
            backColor: UIColor(hexString: "#2f55ad"),
            tintColor: Constants.BasicsSection.tintColor,
            secondaryColor: UIColor(hexString: "#365fbf"),
            shadowAvailable: true,
            decorationImageName: "computer-work-1"
        ),
        ACBasicsCellModel(
            content: ACBasics(
                title: "Operating \nSystems",
                decoTitle: "Operating Systems",
                subtitle: nil,
                preview: "The Arduino IDE is requred to use on Windows, Linux...",
                stringSiteUrl: ACURLs.Materials.wikiArduino,
                description: "The IDE supports Windows, MacOS and Linux. With the popularity of Arduino, other vendors have started introducing custom compilers and open source tools (kernels) as a software platform that can create and upload sketches to other microcontrollers not supported by the official Arduino line of microcontrollers.\n\n",
                date: Date.from(year: 2022, month: 4, day: 06)
            ),
            backColor: UIColor(hexString: "#1c92d2"),
            tintColor: Constants.BasicsSection.tintColor,
            secondaryColor: UIColor(hexString: "#2f99d6"),
            shadowAvailable: true,
            decorationImageName: "computer-work-3"
        )
    ]
    static let teamModels = [
        ACPersonCellModel(
            person: ACPerson(
                name: "Yaroslav Trach",
                role: "iOS Developer",
                description: "He was responsible for creating a design framework, creating task examples, and publishing the App in the App Store."
            ),
            roleIcon: "chevron.left.forwardslash.chevron.right",
            tintColor: Constants.TeamSection.secondaryTintColor,
            backColor: Constants.TeamSection.contentTintColor,
            secondaryColor: Constants.TeamSection.contentSecondaryTintColor,
            shadowAvailable: true,
            backImageName: "chevron.left.forwardslash.chevron.right"
        ),
        ACPersonCellModel(
            person: ACPerson(
                name: "Yuliia Lytvynchuk",
                role: "UI/UX Designer",
                description: "She was responsible for creating basic design idea of Arduino Commands - Electronics, conducting UI/UX researches, and maintaining iOS Human Interface Guidlines in the App."
            ),
            roleIcon: "pencil",
            tintColor: Constants.TeamSection.secondaryTintColor,
            backColor: Constants.TeamSection.contentTintColor,
            secondaryColor: Constants.TeamSection.contentSecondaryTintColor,
            shadowAvailable: true,
            backImageName: "shape-team-deco-1"
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
                roleDescription: "Yaroslav Trach was the founder of Arduino Commands - Electronics. He was responsible for creating the basic idea of design, developing and writing code for the App. He organized the use of all content and checked its quality. Yaroslav was responsible for the release of Arduino Commands - Electronics on the App Store.",
                extraInfo: "Founder",
                roleLabelWidth: 104,
                extraInfoLabelWidth: 92
            ),
            tintColor: Constants.UsersSection.contentTintColor
        ),
        ACUserCellModel(
            content: ACUser(
                name: "Yuliia",
                surname: "Lytvynchuk",
                role: "Design",
                age: 21,
                iconName: "user-1-icon",
                dateWhenAdded: Date.from(year: 2019, month: 11, day: 15),
                secondaryColor: UIColor.systemTeal,
                roleDescription: "Yuliia was responsible for creating basic design idea of Arduino Commands - Electronics, conducting UI/UX researches, and maintaining iOS Human Interface Guidlines in the App.",
                extraInfo: "Founder",
                roleLabelWidth: 95,
                extraInfoLabelWidth: 92
            ),
            tintColor: Constants.UsersSection.contentTintColor
        )
    ]
    static let sitesModels = [
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
                name: "Kiber Koder",
                link: ACURLs.Materials.kiberKoder
            ),
            tintColor: Constants.LinksSection.secondaryTintColor,
            backColor: Constants.LinksSection.contentTintColor,
            secondaryColor: Constants.LinksSection.contentSecondaryTintColor,
            shadowAvailable: true,
            decorationBackImageName: "shape-site-deco-2"
        )
    ]
}
