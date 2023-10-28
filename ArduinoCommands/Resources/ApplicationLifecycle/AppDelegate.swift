//
//  AppDelegate.swift
//  ArduinoCommands
//
//  Created by Yaroslav on 08.02.2022.
//

import Foundation
import UserNotifications
import GoogleMobileAds
//import RevenueCat
import TipKit
import UIKit

//MARK: - Application delegate Keys
extension AppDelegate {
    
    //MARK: Public
    enum Keys {
        enum AppDelegateConstants {
            
            //MARK: Static
            static let sceneConfigurationName = "Default Configuration"
        }
        enum StoryboardNames {
            
            //MARK: Static
            static let main = "Main"
            static let commandsListTab = "CommandsList"
            static let basicKnowledgeTab = "BasicKnowledge"
        }
    }
}


@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate, AnalyticsManagerInjector, RateManagerInjector {
    
    //MARK: Internal
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            GADMobileAds.sharedInstance().start(completionHandler: nil)
//            Purchases.logLevel = .debug
//            Purchases.configure(withAPIKey: "appl_bGmEuPnIaNiLbnnTawOwXOJLLLI")
            ACNotificationManager.shared.requestAuthorization()
            ACNetworkManager.shared.startMonitoring()
            rateManager.startCounting()
        }
        DispatchQueue.main.async { [self] in
            setupTabBerBasicAppearance()
            setupNavBarBasicAppearance()
            setupNotificationCenter()
            setupSearchBarBasicAppearance()
            setupPageControlBasicAppearance()
        }
        if #available(iOS 17.0, *) {
            try? Tips.configure()
        }
        return true
    }
    
    internal func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        /**
         Called when a new scene session is being created.
         Use this method to select a configuration to create the new scene with.
         */
        UISceneConfiguration(name: Keys.AppDelegateConstants.sceneConfigurationName, sessionRole: connectingSceneSession.role)
    }
    
    internal func applicationWillTerminate(_ application: UIApplication) {
        analyticsManager.checkAndAddNewViewDay()
    }

    //MARK: Scene session Lifecycle
    internal func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        /**
         Called when the user discards a scene session.
         If any sessions were discarded while the application was not running,
         this will be called shortly after application:didFinishLaunchingWithOptions.
         Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        */
    }
}


//MARK: - Main methods
private extension AppDelegate {
    
    //MARK: Private
    func setupNotificationCenter() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    func setupNavBarBasicAppearance() {
        let largeAttributedFont = UIFont.ACFont(ofSize: 26, weight: .bold)
        let attributedFont = UIFont.ACFont(ofSize: 16, weight: .bold)
        let attributes = [NSAttributedString.Key.font: attributedFont]
        let largeAttributes = [NSAttributedString.Key.font: largeAttributedFont]
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = largeAttributes
        appearance.titleTextAttributes = attributes
        appearance.backgroundColor = .clear
        /**
         We setted cleared  base Navigation bar background,
         because the main description of how will top bars look like
         is in the `UIViewController` extension file in `setBlurViewForStatusBar`function.
         
         Apart from that, `UINavigationBar` appearance can be different in some cases,
         that's why we will set the same appearance characteristics for every Navigation bar state.
         */
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    func setupPageControlBasicAppearance() {
        let tintColor: UIColor = .label
        let pageIndicatorTintColor = tintColor.withAlphaComponent(0.15)
        let currentIndicatorTintColor = tintColor.withAlphaComponent(0.75)
        UIPageControl.appearance().currentPageIndicatorTintColor = currentIndicatorTintColor
        UIPageControl.appearance().pageIndicatorTintColor = pageIndicatorTintColor
    }
    
    func setupTabBerBasicAppearance() {
        let cornerRadius = CGFloat.Corners.baseACRounding
        let corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        UITabBar.appearance().layer.masksToBounds = true
        UITabBar.appearance().layer.maskedCorners = corners
        UITabBar.appearance().layer.cornerRadius = cornerRadius
    }

    func setupSearchBarBasicAppearance() {
        let font = UIFont.ACFont(ofSize: 14, weight: .regular)
        let searchBarTextAttributes = [NSAttributedString.Key.font: font]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
    }
}


//MARK: - UserNotification Delegate protocol extension
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //MARK: Internal
    internal func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
}
