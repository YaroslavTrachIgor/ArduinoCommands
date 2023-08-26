//
//  ACCommandsListAdsClient.swift
//  ArduinoCommands
//
//  Created by User on 2023-03-12.
//

import Foundation
import GoogleMobileAds

//MARK: - Keys
private extension CommandsListAdsClient {
    
    //MARK: Private
    enum Keys {
        enum AdUnitIds {
            
            //MARK: Static
            static let commandsDetailInterstitial = "ca-app-pub-4698668975609084/3402372278"
        }
    }
}

//MARK: - Commands List Ads client completion Handler
typealias CommandsListAdDownloadedCompletionHandler = ((GADInterstitialAd?) -> Void)


//MARK: - Commands List Ads client protocol
protocol CommandsListAdsClientProtocol {
    func presentCommandDetailInterstitialAd(interstitial: GADInterstitialAd, on rootVC: UIViewController)
    func setupCommandDetailInterstitialAd(delegate: GADFullScreenContentDelegate, completion: @escaping CommandsListAdDownloadedCompletionHandler)
}


//MARK: - Commands List Ads client
final public class CommandsListAdsClient: ACAdsManagar, CommandsListAdsClientProtocol {
    
    //MARK: Internal
    /// Present GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - completion: the action which happens after Interstitial was shown.
    ///   - rootVC: ViewController in which Interstitial will be initialized.
    func presentCommandDetailInterstitialAd(interstitial: GADInterstitialAd,
                                            on rootVC: UIViewController) {
        fastPresentOfAdInterstitialScreen(for: interstitial, on: rootVC)
    }
    
    /// Setup GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - delegate: ViewController in which Interstitial will be initialized that confirms `GADFullScreenContentDelegate` protocol.
    ///   - completion: the action which happens after ad was downloaded from the Internet.
    func setupCommandDetailInterstitialAd(delegate: GADFullScreenContentDelegate,
                                          completion: @escaping CommandsListAdDownloadedCompletionHandler) {
        let request = GADRequest()
        let adUnitID = Keys.AdUnitIds.commandsDetailInterstitial
        GADInterstitialAd.load(withAdUnitID: adUnitID,
                               request: request,
                               completionHandler: { ad, error in
            if error != nil { return }
            completion(ad)
        })
    }
}
