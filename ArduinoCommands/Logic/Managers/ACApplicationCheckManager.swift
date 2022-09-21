//
//  ACApplicationCheckManager.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension ACApplicationCheckManager {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        enum Constants {
            
            //MARK: Static
            static let currentVersion = "1.0.0"
        }
    }
}


//MARK: - Manager protocol
protocol ACApplicationCheckManagerProtocol {
    func checkVersion(completion: ACBaseCompletionHandler?)
}


//MARK: - Manager for fast Application global properties Check
final class ACApplicationCheckManager: ACApplicationCheckManagerProtocol {

    //MARK: Private
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.checkVersionKey)
    private var isNeededAlert = true
    private var service: ACApplicationAPIClientProtocol! {
        return ACApplicationAPIClient(url: URL(string: ACURLs.API.applicationAPI))
    }
    
    //MARK: Static
    static var shared = ACApplicationCheckManager()
    
    
    //MARK: Initialization
    private init() {}
    
    //MARK: Internal
    /// This checks version of app downloaded on a particular device,
    /// and compares it with the current version available in AppStore from Appliction content Database.
    ///
    /// The function is used in `BasicKnowledgePresenter` file.
    /// - Parameter completion: this is the handler which we will use to do some UI stuff.
    func checkVersion(completion: ACBaseCompletionHandler? = nil) {
        service.getApplicationResponse { [self] result in
            switch result {
            case .success(let applicationAPI):
                guard let version = applicationAPI.version else { return }
                if version != Keys.Constants.currentVersion && isNeededAlert {
                    guard let completionHandler = completion else { return }
                    DispatchQueue.main.async {
                        completionHandler()
                    }
                    /**
                     After New Version alert was shown,
                     we need to set a new value for the special bool marker,
                     that would say that Version Alert is not important anymore.
                     */
                    isNeededAlert.toggle()
                }
            case .failure(_):
                break
            }
        }
    }
}
