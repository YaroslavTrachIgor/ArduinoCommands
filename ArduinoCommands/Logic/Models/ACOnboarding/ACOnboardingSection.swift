//
//  OnboardingSection.swift
//  ArduinoCommands
//
//  Created by User on 25.06.2022.
//

import Foundation

//MARK: - Model for Onboarding section content
final public class ACOnboardingSection: Codable {
    let title: String!
    let subtitle: String!
    let tintColorString: String!
    let imageSystemName: String!
    
    //MARK: Initialization
    init(title: String!,
         subtitle: String!,
         tintColorString: String!,
         imageSystemName: String!) {
        self.title = title
        self.subtitle = subtitle
        self.tintColorString = tintColorString
        self.imageSystemName = imageSystemName
    }
}

typealias ACOnboardingSections = [ACOnboardingSection]
