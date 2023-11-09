//
//  ACApplicationCheckManager.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation
import UIKit

//MARK: - Keys
public extension ACApplicationCheckManager {
    
    //MARK: Public
    enum Keys {
        
        //MARK: Static
        static let currentVersion = "1.9.2"
    }
}


//MARK: - Application version check Completion Handler
typealias ACApplicationCheckCompletionHandler = (Bool) -> ()


//MARK: - Manager protocol
protocol ACApplicationCheckManagerProtocol {
    func checkVersion(completion: ACApplicationCheckCompletionHandler?)
    func checkIfOnboardingNeeded(completion: @escaping ACApplicationCheckCompletionHandler)
}


//MARK: - Manager for fast Application global properties Check
final public class ACApplicationCheckManager: ACApplicationCheckManagerProtocol {

    //MARK: Private
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.Onboarding.isOnboardingNeeded)
    private var isNeededOnboarding = true
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.ApplicationCheck.checkVersionKey)
    private var isNeededAlert = true
    private var service: ACApplicationAPIClientProtocol! {
        return ACApplicationAPIClient(url: URL(string: ACURLs.API.applicationAPI))
    }
    
    //MARK: Public
    /// Checks if onboarding is needed and calls a completion handler with the result value.
    /// - Parameters:
    ///   - completion: the closure takes a boolean parameter indicating whether onboarding is needed or not.
    ///
    /// - Note:
    ///   If onboarding is needed (the completion handler parameter is `true`),
    ///   this function will also toggle the `isNeededOnboarding` flag,
    ///   assuming that onboarding has been displayed and should not be shown again until explicitly required.
    ///
    /// - Parameter completion: A closure that receives a boolean value indicating whether onboarding is needed.
    func checkIfOnboardingNeeded(completion: @escaping ACApplicationCheckCompletionHandler) {
        completion(isNeededOnboarding)
        if isNeededOnboarding { isNeededOnboarding.toggle() }
    }
    
    /// This checks version of app downloaded on a particular device,
    /// and compares it with the current version available in AppStore from Appliction content Database.
    ///
    /// The function is used in `BasicKnowledgePresenter` file.
    /// - Parameter completion: this is the handler which we will use to do some UI stuff.
    func checkVersion(completion: ACApplicationCheckCompletionHandler? = nil) {
        Task {
            do {
                let applicationAPI = try await service.getApplicationResponse()
                guard let version = applicationAPI?.version else { return }
                guard let completion = completion else { return }
                if version != Keys.currentVersion && isNeededAlert {
                    await MainActor.run { completion(true) }
                    /**
                     After New Version alert was shown,
                     we need to set a new value for the special bool marker,
                     that would say that Version Alert is not important anymore.
                     */
                    isNeededAlert.toggle()
                } else {
                    completion(false)
                }
            } catch {
                return
            }
        }
    }
}
