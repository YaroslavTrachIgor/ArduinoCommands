//
//  ACCommandsListAdsClient.swift
//  ArduinoCommands
//
//  Created by User on 2023-03-12.
//

import Foundation
import GoogleMobileAds

//MARK: - Keys
private extension ACCommandsListAdsClient {
    
    //MARK: Private
    enum Keys {
        enum AdUnitIds {
            
            //MARK: Static
            static let commandsDetailInterstitial = "ca-app-pub-8702634561077907/5371318316"
        }
    }
}

//MARK: - Commands List Ads client completion Handler
typealias ACCommandsListAdDownloadedCompletionHandler = ((GADInterstitialAd?) -> Void)


//MARK: - Commands List Ads client protocol
protocol ACCommandsListAdsClientProtocol {
    func presentCommandDetailnterstitialAd(interstitial: GADInterstitialAd, on rootVC: UIViewController)
    func setupCommandDetailnterstitialAd(delegate: GADFullScreenContentDelegate, completion: @escaping ACCommandsListAdDownloadedCompletionHandler)
}


//MARK: - Commands List Ads client
final public class ACCommandsListAdsClient: ACAdsManagar, ACCommandsListAdsClientProtocol {
    
    //MARK: Internal
    /// Present GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - completion: the action which happens after Interstitial was shown.
    ///   - rootVC: ViewController in which Interstitial will be initialized.
    func presentCommandDetailnterstitialAd(interstitial: GADInterstitialAd, on rootVC: UIViewController) {
        fastPresentOfAdInterstitialScreen(for: interstitial, on: rootVC)
    }
    
    /// Setup GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - delegate: ViewController in which Interstitial will be initialized that confirms `GADFullScreenContentDelegate` protocol.
    ///   - completion: the action which happens after ad was downloaded from the Internet.
    func setupCommandDetailnterstitialAd(delegate: GADFullScreenContentDelegate,
                                         completion: @escaping ACCommandsListAdDownloadedCompletionHandler) {
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
