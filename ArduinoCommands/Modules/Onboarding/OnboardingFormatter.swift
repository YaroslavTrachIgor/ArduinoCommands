//
//  OnboardingFormatter.swift
//  ArduinoCommands
//
//  Created by User on 2023-06-02.
//

import Foundation
import UIKit

// MARK: - Formatter for OnboardingUIModel
struct OnboardingFormatter {
    
    //MARK: Static
    static func convert(_ onboardingHelper: ACOnboardingHelper) -> OnboardingUIModel {
        return OnboardingUIModel(header: onboardingHelper.title,
                                 foreword: onboardingHelper.foreword,
                                 sections: convert(onboardingHelper.sections))
    }
    
    static func convert(_ onboardingSections: ACOnboardingSections) -> [OnboardingSectionUIModel] {
        onboardingSections.map { section in
            return OnboardingSectionUIModel(title: section.title,
                                            subtitle: section.subtitle,
                                            image: setupSectionImage(with: section))
        }
    }
}


//MARK: - Main methods
extension OnboardingFormatter {
    
    //MARK: Private
    private static func setupSectionImage(with section: ACOnboardingSection) -> UIImage? {
        let sectionTintHex = section.tintColorString
        let imageName = section.imageSystemName
        let imageTintColor = UIColor(hexString: sectionTintHex!)
        let imageConfig = UIImage.SymbolConfiguration(hierarchicalColor: imageTintColor)
        let image = UIImage(systemName: imageName!, withConfiguration: imageConfig)
        return image
    }
}
