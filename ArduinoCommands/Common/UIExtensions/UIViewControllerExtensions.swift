//
//  UIViewControllerExtension.swift
//  ArduinoCommands
//
//  Created by User on 25.06.2022.
//

import Foundation
import SafariServices
import UIKit

//MARK: - Fast ViewController methods
public extension UIViewController {
    
    //MARK: Public
    /// This presents and configures base `UISheetPresentationController` with:
    /// - Parameters:
    ///   - vc: ViewController on which sheet will be presented;
    ///   - detents:sheet presentation style;
    ///   - cornerRadius: sheet corners value.
    func presentSheet(with vc: UIViewController,
                      detents: [UISheetPresentationController.Detent] = [.large()],
                      cornerRadius: CGFloat = 20) {
        if let sheet = vc.sheetPresentationController {
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = cornerRadius
            sheet.prefersGrabberVisible = true
            sheet.detents = detents
        }
        present(vc, animated: true)
    }
    
    /// This hides bottom bar with:
    /// - Parameter alpha: the level of tab bar opacity.
    ///
    /// This is usually used in so called `Detail` VCs
    /// to make User absolutaly immersed in the content on screen.
    func hideTabBarWithAnimation(alpha: Int) {
        let duration: TimeInterval = 0.4
        let tabBarAlpha = CGFloat(alpha)
        let animation = UIViewPropertyAnimator(duration: duration, curve: .easeIn) { [self] in
            tabBarController?.tabBar.alpha = tabBarAlpha
        }
        animation.startAnimation()
    }

    /// This presents and configures base `SFSafariViewController` with:
    /// - Parameter stringURL: website string URL adress.
    func presentSafariVC(for stringURL: String) {
        let url = URL(string: stringURL)
        guard url != nil else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url!, configuration: config)
        present(vc, animated: true)
    }
    
    func setBlurViewForStatusBar() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        setupStatusBarBlurView(with: blurEffectView)
    }
}


//MARK: - Main methods
private extension UIViewController {
    
    //MARK: Private
    func setupStatusBarBlurView(with blurEffectView: UIVisualEffectView) {
        let cornerRadius = CGFloat.Corners.baseACRounding
        let maskedCorners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.maskedCorners = maskedCorners
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurEffectView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blurEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurEffectView.setFastGlassmorphismBorder()
    }
}

