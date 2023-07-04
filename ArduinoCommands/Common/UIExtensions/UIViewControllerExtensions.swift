//
//  UIViewControllerExtension.swift
//  ArduinoCommands
//
//  Created by User on 25.06.2022.
//

import Foundation
import SafariServices
import UIKit

//MARK: - Keys
private extension UIViewController {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        static let baseAnimationDuration = 0.4
    }
}


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
                      cornerRadius: CGFloat = CGFloat.Corners.baseACRounding) {
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
        let duration = Keys.baseAnimationDuration
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
    
    /// This creates fast Animation handler.
    /// - Parameters:
    ///   - animation: animation handler;
    ///   - completion: last actions after function execution.
    func fastAnimation(animation: @escaping ACBaseCompletionHandler,
                       completion: ACBaseCompletionHandler? = nil) {
        let duration = Keys.baseAnimationDuration
        UIView.animate(withDuration: duration) {
            animation()
        } completion: { _ in
            guard let completion = completion else { return }
            completion()
        }
    }
    
    /// This sets up animated VC dismission handler.
    /// - Parameter completion: last actions after function execution.
    func dismissVC(completion: ACBaseCompletionHandler? = nil) {
        dismiss(animated: true) {
            guard let completion = completion else { return }
            completion()
        }
    }
    
    func setBlurViewForStatusBar() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        setupStatusBarBlurView(with: blurEffectView)
    }
}


//MARK: - Fast ViewController animation methods
public extension UIViewController {
    
    //MARK: Public
    /// This configures fast animation methods
    /// for hiding or presenting any kind of `UIView`.
    /// - Parameters:
    ///   - view: UI element that will be animated;
    ///   - animationType: kind of animation(present or hide view).
    func animateViewIn(for view: UIView, animationType: ACBasePresentationType) {
        switch animationType {
        case .present:
            /**
             In the code below, we configure the view animation processes for the case of presenting it.
             Before we animate the view, we use the `animatedViewBaseConfiguration` method,
             which prepares a UI element for easy future interaction
             */
            animatedViewBaseConfiguration(for: view)
            fastAnimation { [self] in
                fastAnimatedViewSetup(for: view, alpha: 1, transform: 1)
            }
        case .hide:
            /**
             In the code below, we configure the view animation processes for the case of hiding it.
             In order to prevent the user from being disturbed by the animated view,
             we use a `completion` block in which we remove this view from the main superview.
             */
            fastAnimation { [self] in
                fastAnimatedViewSetup(for: view, alpha: 0, transform: 1.2)
            } completion: {
                view.removeFromSuperview()
            }
        }
    }
    
    /// This changes the ability to interact with the views of `UIControl` type with animation.
    /// - Parameters:
    ///   - view: the view that is on the VC and will be changed;
    ///   - animationType: case of animation depending on which the `view` properties will changed.
    func enableViewIn(or view: UIControl, animationType: ACBasePresentationType) {
        switch animationType {
        case .present: fastAnimation { view.isEnabled = true }
        case .hide: fastAnimation { view.isEnabled = false }
        }
    }
    
    /// This changes the ability to interact with the views of `UIBarItem` type with animation.
    /// - Parameters:
    ///   - view: the view that is on the VC and will be changed;
    ///   - animationType: case of animation depending on which the `view` properties will changed.
    func enableViewIn(or view: UIBarItem, animationType: ACBasePresentationType) {
        switch animationType {
        case .present: fastAnimation { view.isEnabled = true }
        case .hide: fastAnimation { view.isEnabled = false }
        }
    }
    
    func animatedViewBaseConfiguration(for view: UIView) {
        let backgroundView = self.view!
        let center = backgroundView.center
        backgroundView.addSubview(view)
        view.center = center
        fastAnimatedViewSetup(for: view, alpha: 0, transform: 1.2)
    }
    
    func fastAnimatedViewSetup(for view: UIView, alpha: CGFloat, transform: Double) {
        let transform = CGAffineTransform(scaleX: transform, y: transform)
        view.transform = transform
        view.alpha = alpha
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
