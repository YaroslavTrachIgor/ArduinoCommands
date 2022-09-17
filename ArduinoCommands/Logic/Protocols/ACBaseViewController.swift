//
//  BaseViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 31.05.2022.
//

import Foundation

//MARK: Public
public typealias ACBaseCompletionHandler = (() -> Void)


//MARK: - Base ViewController protocol
/**
 In the code below, we create a special protocl, that will play a role of a simple VC
 and, of course, it describes logic, that every VC in this application contains.
 
 First of all, we need `ACBaseViewController` to use it in Tests and Presenters,
 that is in files where we don't have an opportinity to use `UIKit`.
 */
public protocol ACBaseViewController: AnyObject {
    func setupMainUI()
}

public protocol ACBaseWithShareViewController: ACBaseWithShareView, ACBaseViewController {}

public protocol ACBaseDetailViewController: ACBaseWithShareView, ACBaseCancelableView, ACBaseViewController {}


/**
 In the code below, after we created the main basic VC protocol,
 we can setup the other special protocols which will play a role of other VCs.
 
 The majority of protocols below are inherited from the `ACBaseViewController` protocol
 and have their `setupContent` function, that contains model argument for comfortable content setup.
 */

//MARK: Internal
/**
 /////////////
 */
protocol ACBaseBasicKnowledgeVCProtocol: ACBaseViewController {
    func presentOnboardingVC()
    func presentSettingsHostVC()
    func presentDetailVC(with model: ACBasics)
    func presentSiteWithSafari(with model: ACLink)
    func presentUserSheetVC(with model: ACUser)
}

protocol ACBaseBasicKnowledgeDetailVCProtocol: ACBaseDetailViewController {
    func setFastBottomContentViewShadowColor()
    func presentSafariVC(stringURL: String)
    func presentTabBarWithAnimation(alpha: Int)
}


/**
 /////////////
 */
protocol ACBaseCommandsListTableViewController: ACBaseWithShareViewController {
    func presentAdlnterstitial(completion: @escaping ACBaseCompletionHandler)
    func presentAdAlertController(completion: @escaping ACBaseCompletionHandler)
    func presentAdLoadFailedAlertController()
    func presentDetailVC(for indexPath: IndexPath)
}

protocol ACBaseCommandDetailViewControllerProtocol: ACBaseDetailViewController {
    func presentTabBarWithAnimation(alpha: Int)
    func changeTextViewContentAnimately(text: String)
    func presentCodeSnippetViewController()
    func presentFastImageViewController()
    func setupRateManager()
    func setupAdBunner()
}

protocol ACBaseCodeSnippetViewController: ACBaseDetailViewController {
    func presentColorPickerViewController()
    func presentFontChangeViews(with animationType: ACBaseAnimationType)
    func setupCodeContentViewAppearance(appearanceType: ACBaseAppearanceType)
    func changeCodeTextViewFontSize()
}

protocol ACBaseFastImageViewControllerProtocol: ACBaseWithShareViewController {}


/**
 /////////////
 */
protocol ACBaseOnboardingViewController: ACBaseViewController {
    func setupContent(with data: OnboardingUIModelProtocol)
}
