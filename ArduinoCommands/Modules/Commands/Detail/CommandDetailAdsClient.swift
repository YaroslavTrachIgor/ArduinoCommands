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
            static let commandDetailAdBunnerKey = "ca-app-pub-4698668975609084/8359365695"
            static let commandCodeSippetInterstitialAdKey = "ca-app-pub-4698668975609084/5639804174"
        }
    }
}


//MARK: - Ads manager protocol
protocol CommandDetailAdsClientProtocol {
    func setupCommandDetailAdBunner(for bunner: GADBannerView, on vc: UIViewController)
    func presentCommandCodeSnippetInterstitialAd(interstitial: GADInterstitialAd, on rootVC: UIViewController)
    func setupCommandCommandCodeSnippetInterstitialAd(delegate: GADFullScreenContentDelegate, completion: @escaping CommandsListAdDownloadedCompletionHandler)
}


//MARK: - Main Ads manager
final public class CommandDetailAdsClient: ACAdsManagar, CommandDetailAdsClientProtocol {
    
    //MARK: Internal
    /// Setup GoogleMobileAds Bunner.
    /// - Parameters:
    ///   - bunner: bunner which will be modified in the ViewController.
    ///   - rootVC: ViewController in which bunner will be initialized.
    func setupCommandDetailAdBunner(for bunner: GADBannerView, on vc: UIViewController) {
        let adUnitID = Keys.AdUnitIds.commandDetailAdBunnerKey
        self.fastAdBunnerSetup(for: bunner, adUnitID: adUnitID, on: vc)
    }
    
    /// Present GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - completion: the action which happens after Interstitial was shown.
    ///   - rootVC: ViewController in which Interstitial will be initialized.
    func presentCommandCodeSnippetInterstitialAd(interstitial: GADInterstitialAd, on rootVC: UIViewController) {
        fastPresentOfAdInterstitialScreen(for: interstitial, on: rootVC)
    }
    
    /// Setup GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - delegate: ViewController in which Interstitial will be initialized that confirms `GADFullScreenContentDelegate` protocol.
    ///   - completion: the action which happens after ad was downloaded from the Internet.
    func setupCommandCommandCodeSnippetInterstitialAd(delegate: GADFullScreenContentDelegate,
                                                      completion: @escaping CommandsListAdDownloadedCompletionHandler) {
        let request = GADRequest()
        let adUnitID = Keys.AdUnitIds.commandCodeSippetInterstitialAdKey
        GADInterstitialAd.load(withAdUnitID: adUnitID,
                               request: request,
                               completionHandler: { ad, error in
            if error != nil { return }
            completion(ad)
        })
    }
}
