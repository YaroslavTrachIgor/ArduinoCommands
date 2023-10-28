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
typealias ACApplicationVersionCheckCompletionHandler = (Bool) -> ()


//MARK: - Manager protocol
protocol ACApplicationCheckManagerProtocol {
    func checkVersion(completion: ACApplicationVersionCheckCompletionHandler?)
}


//MARK: - Manager for fast Application global properties Check
final public class ACApplicationCheckManager: ACApplicationCheckManagerProtocol {

    //MARK: Private
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.ApplicationCheck.checkVersionKey)
    private var isNeededAlert = true
    private var service: ACApplicationAPIClientProtocol! {
        return ACApplicationAPIClient(url: URL(string: ACURLs.API.applicationAPI))
    }
    
    //MARK: Public
    /// This checks version of app downloaded on a particular device,
    /// and compares it with the current version available in AppStore from Appliction content Database.
    ///
    /// The function is used in `BasicKnowledgePresenter` file.
    /// - Parameter completion: this is the handler which we will use to do some UI stuff.
    func checkVersion(completion: ACApplicationVersionCheckCompletionHandler? = nil) {
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
