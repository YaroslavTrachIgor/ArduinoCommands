//
//  ViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav on 08.02.2022.
//

import Foundation
import UIKit
import SafariServices

//MARK: - Main TabBarController
final class MainTabBarController: UITabBarController {
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTabBarItems()
    }
}


//MARK: - Main methods
private extension MainTabBarController {
    
    //MARK: Private
    func setupTabBar() {
        tabBar.setFastGlassmorphismBorder()
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = CGFloat.Corners.baseACRounding
        tabBar.tintColor = .label
        selectedIndex = 0
        delegate = self
    }
    
    func setupTabBarItems() {
        let normalFont = UIFont.ACFont(ofSize: 8)
        let selectedFont = UIFont.ACFont(ofSize: 8, weight: .bold)
        let normalFontAttributes: [NSAttributedString.Key: Any] = [.font: normalFont]
        let selectedFontAttributes: [NSAttributedString.Key: Any] = [.font: selectedFont]
        for tabBarItem in tabBar.items ?? [] {
            tabBarItem.setTitleTextAttributes(normalFontAttributes, for: .normal)
            tabBarItem.setTitleTextAttributes(selectedFontAttributes, for: .selected)
        }
    }
}


//MARK: - Tabs switch Animation extension
extension MainTabBarController: UITabBarControllerDelegate {
    
    //MARK: Internal
    internal func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let animationType = UIView.AnimationOptions.transitionCrossDissolve
        let fromView = tabBarController.selectedViewController!.view!
        let toView = viewController.view!
        let duration: CGFloat = 0.15
        if fromView == toView { return false }
        UIView.transition(from: fromView,
                          to: toView,
                          duration: duration,
                          options: animationType) { (finished: Bool) in }
        return true
   }
}
