//
//  OnboardingUIModel.swift
//  ArduinoCommands
//
//  Created by User on 30.08.2022.
//

import Foundation
import UIKit

//MARK: - Main Onboarding model for UI
struct OnboardingUIModel {
    let header: String
    let foreword: String
    let sections: [OnboardingSectionUIModel]
}

//MARK: - Onboarding Section model for UI
struct OnboardingSectionUIModel {
    let title: String
    let subtitle: String
    let image: UIImage?
}
