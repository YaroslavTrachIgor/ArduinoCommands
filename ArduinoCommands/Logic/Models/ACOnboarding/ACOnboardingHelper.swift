//
//  OnboardingHelper.swift
//  ArduinoCommands
//
//  Created by User on 25.06.2022.
//

import Foundation

//MARK: - Model for Onboarding content
final public class ACOnboardingHelper: Codable {
    let title: String!
    let subtitle: String!
    let foreword: String!
    let sections: ACOnboardingSections!
    
    //MARK: Initialization
    init(title: String!,
         subtitle: String!,
         foreword: String!,
         sections: ACOnboardingSections!) {
        self.title = title
        self.subtitle = subtitle
        self.foreword = foreword
        self.sections = sections
    }
}

