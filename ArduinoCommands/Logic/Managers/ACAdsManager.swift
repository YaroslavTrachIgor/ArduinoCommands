//
//  ACAdsManager.swift
//  ArduinoCommands
//
//  Created by User on 2023-03-12.
//

import Foundation
import GoogleMobileAds

//MARK: - Ads manager protocol
protocol ACAdsManagarProtocol {
    func fastPresentOfAdInterstitialScreen(for interstitial: GADInterstitialAd?, on rootVC: UIViewController)
    func fastAdBunnerSetup(for bunner: GADBannerView, adUnitID: String, on rootVC: UIViewController)
}


//MARK: - Main Ads manager
public class ACAdsManagar: ACAdsManagarProtocol {
    
    //MARK: Internal
    /// This checks for preparation and presents GoogleMobileAds interstitial Screen.
    /// - Parameters:
    ///   - interstitial: GoogleAds screen example.
    func fastPresentOfAdInterstitialScreen(for interstitial: GADInterstitialAd?, on rootVC: UIViewController) {
        if interstitial != nil {
            interstitial!.present(fromRootViewController: rootVC)
        }
    }
    
    /// Quick GoogleMobileAds bunner setup method.
    /// - Parameters:
    ///   - bunner: GoogleAds bunner example.
    ///   - adUnitID: special bunner Unit ID.
    func fastAdBunnerSetup(for bunner: GADBannerView, adUnitID: String, on rootVC: UIViewController) {
        let request = GADRequest()
        bunner.adUnitID = adUnitID
        bunner.rootViewController = rootVC
        bunner.load(request)
    }
}
