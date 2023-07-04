//
//  ACOnboardingAPIClient.swift
//  ArduinoCommands
//
//  Created by User on 2023-04-19.
//

import Foundation

//MARK: - Onboarding API Client protocol
protocol ACOnboardingAPIClientProtocol {
    func parseOnboardingContent() -> ACOnboardingHelper?
}


//MARK: - Main Onboarding API Client
final class ACOnboardingAPIClient: APIHelper, ACOnboardingAPIClientProtocol {
    
    //MARK: Internal
    /// This fetches the content for the Onboarding screen.
    /// In the case if there are any problems occurred with parsing,
    /// we will return nil and hide the Onboarding screen (see in presenter).
    /// - Returns: Codable model API with title, sub-title and sections content for the Onboarding screen.
    internal func parseOnboardingContent() -> ACOnboardingHelper? {
        do {
            if let content: ACOnboardingHelper = try parse() {
                return content
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
