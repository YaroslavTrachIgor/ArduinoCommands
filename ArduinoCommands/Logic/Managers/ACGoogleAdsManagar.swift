//
//  ACGoogleAdsManagar.swift
//  ArduinoCommands
//
//  Created by User on 12.07.2022.
//

import Foundation
import GoogleMobileAds
import UIKit

//MARK: - Keys & Constants
private extension ACGoogleAdsManagar {
    
    //MARK: Private
    enum Keys {
        enum AdUnitIds {
            
            //MARK: Static
            static let commandsDetailScreenshotInterstitial = "ca-app-pub-8702634561077907/4929099649"
            static let commandsDetailInterstitial = "ca-app-pub-8702634561077907/5371318316"
            static let commandsDetailAdBunner = "ca-app-pub-8702634561077907/2128494727"
        }
    }
    enum Constants {
        enum UI {
            enum Alert {
                enum AdLoadFailedAlert {
                    
                    //MARK: Static
                    static let title = "Failed to load Advertisement Screen"
                    static let message = "Failed to load Advertisement Screen on time. You can try one more time or Check the quality of your Internet Connection."
                }
            }
        }
    }
}


//MARK: - Manager for fast AdScreens presenting
final public class ACGoogleAdsManagar {
    
    //MARK: Weak
    weak var rootViewController: UIViewController!
    
    //MARK: Static
    static var shared = ACGoogleAdsManagar()
    
    //MARK: Private
    private var commandsDetailInterstitial: GADInterstitialAd?
    
    
    //MARK: Initialization
    private init() {}
}


//MARK: - Google Ads fast Setup extension
public extension ACGoogleAdsManagar {
    
    //MARK: Public
    func startGoogleAds(completionHandler: GADInitializationCompletionHandler? = nil) {
        /**
         Starts the `GoogleMobileAds` SDK. Call this method as early as possible to reduce latency on the
         session's first ad request. Calls `completionHandler` when the SDK and all mediation networks
         are fully set up or if set-up times out.
         
         The `GoogleMobileAds` SDK starts on the first ad request if this method is not called.
         */
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    func setupCommandDetailAdBunner(for bunner: GADBannerView) {
        let adUnitID = Keys.AdUnitIds.commandsDetailAdBunner
        fastAdBunnerSetup(for: bunner, adUnitID: adUnitID)
    }
    
    func setupCommandDetailnterstitialAd(delegate: GADFullScreenContentDelegate) {
        let adUnitID = Keys.AdUnitIds.commandsDetailInterstitial
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: adUnitID, request: request, completionHandler: { [self] adInterstitial, loadingError in
            if loadingError != nil { return }
            commandsDetailInterstitial?.fullScreenContentDelegate = delegate
            commandsDetailInterstitial = adInterstitial
        })
    }
}


//MARK: - Google Ads fast Present extension
public extension ACGoogleAdsManagar {
    
    //MARK: Public
    func presentCommandDetailnterstitialAd(completion: @escaping (() -> Void)) {
        fastPresentOfAdInterstitialScreen(for: commandsDetailInterstitial); completion()
    }
}


//MARK: - Fast methods
public extension ACGoogleAdsManagar {
    
    //MARK: Public
    func presentAdLoadFailedAlertController() {
        let title = Constants.UI.Alert.AdLoadFailedAlert.title
        let message = Constants.UI.Alert.AdLoadFailedAlert.message
        ACAlertManager.shared.presentSimple(title: title,
                                            message: message,
                                            tintColor: .label,
                                            on: rootViewController)
    }
}


//MARK: - Main methods
private extension ACGoogleAdsManagar {
    
    //MARK: Private
    /// This checks for preparation and presents GoogleMobileAds interstitial Screen.
    /// - Parameters:
    ///   - interstitial: GoogleAds screen example.
    func fastPresentOfAdInterstitialScreen(for interstitial: GADInterstitialAd?) {
        if interstitial != nil {
            interstitial!.present(fromRootViewController: rootViewController)
        }
    }
    
    /// Quick GoogleMobileAds bunner setup method.
    /// - Parameters:
    ///   - bunner: GoogleAds bunner example.
    ///   - adUnitID: special bunner Unit ID.
    func fastAdBunnerSetup(for bunner: GADBannerView, adUnitID: String) {
        let request = GADRequest()
        bunner.adUnitID = adUnitID
        bunner.rootViewController = rootViewController
        bunner.load(request)
    }
}
