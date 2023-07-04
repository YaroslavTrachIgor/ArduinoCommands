//
//  ACCommandDetailAdsClient.swift
//  ArduinoCommands
//
//  Created by User on 2023-03-12.
//

import Foundation
import GoogleMobileAds

//MARK: - Keys
private extension CommandDetailAdsClient {
    
    //MARK: Private
    enum Keys {
        enum AdUnitIds {
            
            //MARK: Static
            static let commandsDetailAdBunner = "ca-app-pub-8702634561077907/2128494727"
        }
    }
}


//MARK: - Ads manager protocol
protocol CommandDetailAdsClientProtocol {
    func setupCommandDetailAdBunner(for bunner: GADBannerView, on vc: UIViewController)
}


//MARK: - Main Ads manager
final public class CommandDetailAdsClient: ACAdsManagar, CommandDetailAdsClientProtocol {
    
    //MARK: Internal
    /// Setup GoogleMobileAds Bunner.
    /// - Parameters:
    ///   - bunner: bunner which will be modified in the ViewController.
    ///   - rootVC: ViewController in which bunner will be initialized.
    func setupCommandDetailAdBunner(for bunner: GADBannerView, on vc: UIViewController) {
        let adUnitID = Keys.AdUnitIds.commandsDetailAdBunner
        self.fastAdBunnerSetup(for: bunner, adUnitID: adUnitID, on: vc)
    }
}
