//
//  BasicKnowledgeAdsClient.swift
//  ArduinoCommands
//
//  Created by User on 2023-09-05.
//

import Foundation
import GoogleMobileAds

//MARK: - Keys
private extension BasicKnowledgeAdsClient {
    
    //MARK: Private
    enum Keys {
        enum AdUnitIds {
            
            //MARK: Static
            static let basicKnowledgeDetailInterstitial = "ca-app-pub-4698668975609084/5880346867"
        }
    }
}

//MARK: - Basic Knowledge Ads client completion Handler
typealias BasicKnowledgeAdDownloadedCompletionHandler = ((GADInterstitialAd?) -> Void)


//MARK: - Basic Knowledge Ads client protocol
protocol BasicKnowledgeAdsClientProtocol {
    func presentBasicKnowledgeDetailInterstitialAd(interstitial: GADInterstitialAd, on rootVC: UIViewController)
    func setupBasicKnowledgeDetailInterstitialAd(delegate: GADFullScreenContentDelegate, completion: @escaping CommandsListAdDownloadedCompletionHandler)
}


//MARK: - Basic Knowledge Ads client
final public class BasicKnowledgeAdsClient: ACAdsManagar, BasicKnowledgeAdsClientProtocol {
    
    //MARK: Internal
    /// Present GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - completion: the action which happens after Interstitial was shown.
    ///   - rootVC: ViewController in which Interstitial will be initialized.
    func presentBasicKnowledgeDetailInterstitialAd(interstitial: GADInterstitialAd,
                                                   on rootVC: UIViewController) {
        fastPresentOfAdInterstitialScreen(for: interstitial, on: rootVC)
    }
    
    /// Setup GoogleMobileAds Interstitial.
    /// - Parameters:
    ///   - delegate: ViewController in which Interstitial will be initialized that confirms `GADFullScreenContentDelegate` protocol.
    ///   - completion: the action which happens after ad was downloaded from the Internet.
    func setupBasicKnowledgeDetailInterstitialAd(delegate: GADFullScreenContentDelegate,
                                                 completion: @escaping BasicKnowledgeAdDownloadedCompletionHandler) {
        let request = GADRequest()
        let adUnitID = Keys.AdUnitIds.basicKnowledgeDetailInterstitial
        GADInterstitialAd.load(withAdUnitID: adUnitID,
                               request: request,
                               completionHandler: { ad, error in
            if error != nil { return }
            completion(ad)
        })
    }
}

