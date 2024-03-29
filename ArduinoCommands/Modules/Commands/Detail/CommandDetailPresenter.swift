//
//  CommandsDetailPresenter.swift
//  ArduinoCommands
//
//  Created by User on 03.07.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension CommandDetailPresenter {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        static let defaultDetailsTintColor = UIColor.white
    }
}


//MARK: - Presenter protocol
internal protocol CommandDetailPresenterProtocol {
    init(view: ACBaseCommandDetailViewControllerProtocol, delegate: CommandDetailViewControllerDelegate, model: ACCommand)
    func onViewDidLoad(completion: @escaping (UIColor) -> Void)
    func onViewDidDisappear()
    func onViewDidAppear()
    func onViewScreenshotButton()
    func onViewCodeSnippet()
    func onPresentDetailsColorPicker()
    func setNewTintColor(with color: UIColor)
    func onChangeContentButton(with index: Int)
    func onCopyDetails(for tag: Int)
    func onHideDetails()
    func onGoToReadingMode()
    func onPresentDeviceImages()
    func onPresentDetails()
    func onShareButton()
    func onBackToMenu()
    func onCopyButton()
}


//MARK: - Main Presenter
final class CommandDetailPresenter: AnalyticsManagerInjector, RateManagerInjector {
    
    //MARK: Private
    @ACBaseUserDefaultsColor(key: UserDefaults.Keys.CommandDetail.detailsTintColorrKey)
    private var detailsTintColor = Keys.defaultDetailsTintColor
    private var tipService: CommandDetailTipClientProtocol?
    private weak var delegate: CommandDetailViewControllerDelegate?
    private weak var view: ACBaseCommandDetailViewControllerProtocol?
    private weak var model: ACCommand?
    
    
    //MARK: Initialization
    init(view: ACBaseCommandDetailViewControllerProtocol,
         delegate: CommandDetailViewControllerDelegate,
         model: ACCommand) {
        self.tipService = CommandDetailTipClient()
        self.view = view
        self.model = model
        self.delegate = delegate
    }
}


//MARK: - Presenter protocol extension
extension CommandDetailPresenter: CommandDetailPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completion: @escaping (UIColor) -> Void) {
        completion(detailsTintColor)
        refreshView()
        askToRate()
        showDailyGoalCongratulations()
        view?.presentTabBarWithAnimation(alpha: 0)
        analyticsManager.updateLastReadArticle(articleName: (model?.name!)!)
    }
    
    internal func onViewDidAppear() {
        remindAboutCircuits()
        remindAboutReadingMode()
    }
    
    internal func onViewDidDisappear() {
        view?.presentTabBarWithAnimation(alpha: 1)
    }
    
    internal func onBackToMenu() {
        view?.moveToThePreviousViewController()
    }
    
    internal func onViewScreenshotButton() {
        view?.presentFastImageViewController()
    }
    
    internal func onPresentDetailsColorPicker() {
        view?.presentColorPickerViewController()
    }
    
    internal func onPresentDeviceImages() {
        view?.presentDeviceImagesCollectionViewController()
    }
    
    internal func onGoToReadingMode() {
        view?.presentReadingModeHostingViewController()
    }
    
    internal func onPresentDetails() {
        animateDetails(presentationType: .present)
    }
    
    internal func onHideDetails() {
        animateDetails(presentationType: .hide)
    }
    
    internal func onViewCodeSnippet() {
        view?.presentAdlnterstitial()
        view?.presentCodeSnippetViewController()
    }
    
    internal func setNewTintColor(with color: UIColor) {
        detailsTintColor = color
        delegate?.setDetailsTintColor(color: color)
        refreshView()
    }
    
    internal func onCopyDetails(for tag: Int) {
        let contentForCopying: String!
        switch tag {
        case 0:
            contentForCopying = model?.details.syntax!
        case 1:
            contentForCopying = model?.details.arguments!
        case 2:
            contentForCopying = model?.details.returns!
        default:
            contentForCopying = nil
        }
        copy(contentForCopying, contentType: .content)
    }
    
    internal func onCopyButton() {
        copy(model?.description!, contentType: .article)
    }
    
    internal func onShareButton() {
        view?.presentActivityVC(activityItems: [model?.shared as Any])
    }
    
    internal func onChangeContentButton(with index: Int) {
        switch index {
        case 0:
            view?.changeTextViewContentAnimately(text: (model?.description)!)
        case 1:
            view?.changeTextViewContentAnimately(text: (model?.baseDescription)!)
        default:
            break
        }
    }
}


//MARK: - Main methods
private extension CommandDetailPresenter {
    
    //MARK: Private
    func refreshView() {
        view?.show(model: CommandDetailFormatter.convert(model!))
        view?.setupMainUI()
        animateDetails(presentationType: .hide)
    }
    
    func askToRate() {
        rateManager.checkSession(completion: { [self] in
            view?.presentRateAlert(noCompletion: { [self] in
                view?.presentRateThanksAlert()
            }, yesCompletion: { [self] in
                view?.presentStoreReviewController()
            })
        })
    }
    
    func animateDetails(presentationType: ACBasePresentationType) {
        switch presentationType {
        case .present:
            view?.presentDetailsViews(with: .present)
            view?.enableBarViews(with: .hide)
        case .hide:
            view?.presentDetailsViews(with: .hide)
            view?.enableBarViews(with: .present)
        }
    }
    
    func copy(_ content: String!, contentType: ACPasteboardManager.ContentType) {
        ACGrayAlertManager.presentCopiedAlert(contentType: contentType)
        ACPasteboardManager.copy(content)
    }
    
    func remindAboutCircuits() {
        if let tipAvailable = tipService?.isCircuitTipAvailable, tipAvailable {
            view?.presentCircuitsTip()
            tipService?.markCircuitTipAsComplete()
        }
    }
    
    func remindAboutReadingMode() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            if let tipAvailable = tipService?.isReadingModeTipAvailable, tipAvailable {
                view?.presentReadingModeTip()
                tipService?.markReadingModeTipAsComplete()
            }
            
            view?.pulseReadingModeButton()
        }
    }
    
    func showDailyGoalCongratulations() {
        analyticsManager.updateCurrentArticleViews { isDailyGoalAchieved in
            if isDailyGoalAchieved {
                DispatchQueue.main.asyncAfter(deadline: .now() + 60) { [self] in
                    view?.presentDailyGoalCongratulationsView(with: .present)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
                        view?.presentDailyGoalCongratulationsView(with: .hide)
                    }
                }
            }
        }
    }
}
