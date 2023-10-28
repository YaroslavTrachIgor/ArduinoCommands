//
//  CommandDetailViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 26.05.2022.
//

import Foundation
import UIKit
import SwiftUI
import StoreKit
import GoogleMobileAds
import TipKit

//MARK: - Main ViewController protocol
protocol ACBaseCommandDetailViewControllerProtocol: ACBaseDetailViewController {
    func show(model: CommandDetailUIModel!)
    func presentTabBarWithAnimation(alpha: Int)
    func changeTextViewContentAnimately(text: String)
    func presentDailyGoalCongratulationsView(with animationType: ACBasePresentationType)
    func presentDetailsViews(with animationType: ACBasePresentationType)
    func enableBarViews(with animationType: ACBasePresentationType)
    func presentDeviceImagesCollectionViewController()
    func presentReadingModeHostingViewController()
    func presentColorPickerViewController()
    func presentCodeSnippetViewController()
    func presentFastImageViewController()
    func presentRateAlert(noCompletion: @escaping ACBaseCompletionHandler, yesCompletion: @escaping ACBaseCompletionHandler)
    func presentStoreReviewController()
    func pulseReadingModeButton()
    func presentRateThanksAlert()
    func presentAdlnterstitial()
    func presentReadingModeTip()
    func presentCircuitsTip()
}


//MARK: - ViewController Delegate protocol
protocol CommandDetailViewControllerDelegate: AnyObject {
    func setDetailsTintColor(color: UIColor)
}


//MARK: - Constants
private extension CommandDetailViewController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Label {
                
                //MARK: Static
                static let detailColorPickerTitle = "Details Tint Color"
            }
            enum Button {
                
                //MARK: Static
                static let closeTitle = "Close"
                static let goToScreenshotTitle = "Circuit"
                static let goToCodeSnippetTitle = "Code"
            }
            enum Image {
                
                //MARK: Static
                static let detailsIcon = "list.dash"
                static let readingModeIcon = "book"
                static let colorPickerGoIcon = "circle.hexagongrid"
                static let deviceIcon = "externaldrive.badge.plus"
                static let modelIcon = "server.rack"
                static let codeIcon = "chevron.left.slash.chevron.right"
                static let copyIcon = "rectangle.portrait.on.rectangle.portrait"
            }
            enum Alert {
                enum RateAlert {
                    
                    //MARK: Static
                    static var title = "Do you enjoy using ArduinoCommands?"
                    static var message = "Your opinion is very important for us."
                    static let noActionTitle = "No, I don't"
                    static let yesActionTitle = "Yes, I like it!"
                    static let dismissActionTitle = "Dismiss"
                }
                enum ThanksAlert {
                    
                    //MARK: Static
                    static var title = "Thank you!"
                    static var message = "We will keep improving our Application."
                }
            }
        }
    }
}


//MARK: - Main ViewController
final class CommandDetailViewController: UIViewController, ACBaseStoryboarded, RateManagerInjector {
    
    //MARK: Internal
    var model: ACCommand!
    
    //MARK: Static
    static var storyboardName: String {
        AppDelegate.Keys.StoryboardNames.commandsListTab
    }
    
    //MARK: Private
    private var uiModel: CommandDetailUIModel?
    private var interstitial: GADInterstitialAd?
    private var presenter: CommandDetailPresenterProtocol? {
        return CommandDetailPresenter(view: self, delegate: self, model: model)
    }
    private var adsClient: CommandDetailAdsClientProtocol? {
        return CommandDetailAdsClient()
    }
    private var detailsTintColor: UIColor!
    
    //MARK: @IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var rightDecotationLabel: UILabel!
    @IBOutlet private weak var middleDecorationLabel: UILabel!
    @IBOutlet private weak var leftDecorationLabel: UILabel!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var contentBackgroundView: UIView!
    @IBOutlet private weak var contentBackgroundBlurView: UIVisualEffectView!
    @IBOutlet private weak var contentSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var codeScreenshotImageView: UIImageView!
    @IBOutlet private weak var costomBackBarButton: UIBarButtonItem!
    @IBOutlet private weak var shareBarButton: UIBarButtonItem!
    @IBOutlet private weak var copyBarButton: UIBarButtonItem!
    @IBOutlet private weak var screenshotBlurView: UIVisualEffectView!
    @IBOutlet private weak var readingModeButton: UIButton!
    @IBOutlet private weak var screenshotButton: UIButton!
    @IBOutlet private weak var codeSnippetButton: UIButton!
    @IBOutlet private weak var presentDetailsButton: UIButton!
    @IBOutlet private weak var presentDeviceImagesButton: UIButton!
    @IBOutlet private weak var detailBackgroundBlurView: UIVisualEffectView!
    @IBOutlet private weak var detailBackgroundView: CommandDetailBackgroundView!
    @IBOutlet private weak var dailyGoalCongratulationsView: CommandDetailDailyGoalCongratulationsView!
    
    
    //MARK: Lifecycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad { tintColor in
            self.detailsTintColor = tintColor
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.onViewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.onViewDidDisappear()
    }
    
    //MARK: @IBActions
    @IBAction func changeContent(_ sender: UISegmentedControl) {
        presenter?.onChangeContentButton(with: sender.selectedSegmentIndex)
    }
    
    @IBAction func viewScreenshot(_ sender: UIButton) {
        presenter?.onViewScreenshotButton()
    }
    
    @IBAction func viewCodeSnippet(_ sender: UIButton) {
        presenter?.onViewCodeSnippet()
    }
    
    @IBAction func copyContent(_ sender: Any) {
        presenter?.onCopyButton()
    }
    
    @IBAction func shareContent(_ sender: Any) {
        presenter?.onShareButton()
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        presenter?.onBackToMenu()
    }
    
    @IBAction func hideDetails(_ sender: Any) {
        presenter?.onHideDetails()
    }
    
    @IBAction func presentDetails(_ sender: Any) {
        presenter?.onPresentDetails()
    }
    
    @IBAction func copyDetails(_ sender: UIButton) {
        presenter?.onCopyDetails(for: sender.tag)
    }
    
    @IBAction func presentDeviceImages(_ sender: Any) {
        presenter?.onPresentDeviceImages()
    }
    
    @IBAction func presentDetailsColorPicker(_ sender: Any) {
        presenter?.onPresentDetailsColorPicker()
    }
    
    @IBAction func goToReadingMode(_ sender: Any) {
        presenter?.onGoToReadingMode()
    }
}


//MARK: - ViewController protocol extension
extension CommandDetailViewController: ACBaseCommandDetailViewControllerProtocol {
    
    //MARK: Internal
    internal func show(model: CommandDetailUIModel!) {
        self.uiModel = model
        setupTitleLabel()
        setupSubtitleLabel()
        setupContentTextView()
        setupContentBackgroundView()
        setupDetailDescriptionLabels()
        leftDecorationLabel.setupReturnsDecoLabel(with: uiModel?.returnsLabelIsHidden)
        middleDecorationLabel.setupDevicesDecoLabel(with: uiModel?.isDevicesLabelEnabled)
        setupPresentDeviceImagesButton()
        setupCodeScreenshotImageView()
        setupCodeSnippetButton()
        setupScreenshotButton()
    }
    
    internal func setupMainUI() {
        setupContentBackgroundBlurView()
        setupDetailHeaderLabels()
        setupDetailDescriptionBackViews()
        setupDetailBackgroundBlurView()
        setupDetailBackgroundView()
        setupDetailContentView()
        setupDetailCopyButtons()
        setupDailyGoalCongratulationsView()
        setupReadingModeButton()
        setupInterstitial()
        presentDetailsButton.setupDetailsButton(with: Constants.UI.Image.detailsIcon)
        detailBackgroundView.changeTintColorButton.setupCodeContentEditingButton(tintColor: detailsTintColor, imageName: Constants.UI.Image.colorPickerGoIcon)
        detailBackgroundView.doneButton.setupPopupButton(tintColor: detailsTintColor, title: Constants.UI.Button.closeTitle)
        contentSegmentedControl.setupBaseDetailDarkSegmentedControl()
        rightDecotationLabel.setupMethodDecoLabel()
        costomBackBarButton.setupBaseBackBarButton()
        shareBarButton.setupBaseShareBarButton()
        copyBarButton.setupBaseCopyBarButton()
    }
    
    internal func changeTextViewContentAnimately(text: String) {
        contentTextView.changeTextWithAnimation(text: text)
    }
    
    internal func pulseReadingModeButton() {
        readingModeButton.startPulsingAnimation()
    }
    
    internal func presentTabBarWithAnimation(alpha: Int) {
        hideTabBarWithAnimation(alpha: alpha)
    }
    
    internal func presentDetailsViews(with animationType: ACBasePresentationType) {
        animateViewIn(for: detailBackgroundBlurView, animationType: animationType, on: view.center)
        animateViewIn(for: detailBackgroundView, animationType: animationType, on: view.center)
    }
    
    internal func enableBarViews(with animationType: ACBasePresentationType) {
        enableViewIn(for: costomBackBarButton, animationType: animationType)
        enableViewIn(for: shareBarButton, animationType: animationType)
        enableViewIn(for: copyBarButton, animationType: animationType)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems, on: self)
    }
    
    internal func presentAdlnterstitial() {
        guard let interstitial = interstitial else { return }
        adsClient?.presentCommandCodeSnippetInterstitialAd(interstitial: interstitial, on: self)
    }
    
    internal func presentDailyGoalCongratulationsView(with animationType: ACBasePresentationType) {
        let centerX = view.bounds.midX
        let centerY = view.safeAreaInsets.top + 28
        let centerPoint = CGPoint(x: centerX, y: centerY)
        animateViewIn(for: dailyGoalCongratulationsView, animationType: animationType, on: centerPoint)
    }
    
    internal func presentReadingModeHostingViewController() {
        let viewModel = CommandDetailReadingViewModel(model: model)
        let rootView = CommandDetailReadingView(viewModel: viewModel)
        let commandDetailReadingVC = UIHostingController(rootView: rootView)
        presentSheet(with: commandDetailReadingVC, detents: [.large()])
    }
    
    internal func presentFastImageViewController() {
        let imageVC = FastImageViewController()
        imageVC.image = codeScreenshotImageView.image
        presentSheet(with: imageVC, detents: [.large()])
    }
    
    internal func presentRateThanksAlert() {
        let title = Constants.UI.Alert.ThanksAlert.title
        let message = Constants.UI.Alert.ThanksAlert.message
        ACGrayAlertManager.present(title: title,
                                   message: message,
                                   duration: 2,
                                   style: .iOS16AppleMusic)
    }
    
    func presentRateAlert(noCompletion: @escaping ACBaseCompletionHandler, yesCompletion: @escaping ACBaseCompletionHandler) {
        let title = Constants.UI.Alert.RateAlert.title
        let message = Constants.UI.Alert.RateAlert.message
        let noActionTitle = Constants.UI.Alert.RateAlert.noActionTitle
        let yesActionTitle = Constants.UI.Alert.RateAlert.yesActionTitle
        let dismissActionTitle = Constants.UI.Alert.RateAlert.dismissActionTitle
        let rateAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let noAlert = UIAlertAction(title: noActionTitle, style: .default) { _ in
            noCompletion()
        }
        let yesAction = UIAlertAction(title: yesActionTitle, style: .default, handler: { _ in
            yesCompletion()
        })
        let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel)
        rateAlert.view.tintColor = .label
        rateAlert.addAction(yesAction)
        rateAlert.addAction(noAlert)
        rateAlert.addAction(dismissAction)
        present(rateAlert, animated: true, completion: nil)
    }
    
    internal func presentReadingModeTip() {
        if #available(iOS 17.0, *) {
            Task { @MainActor in
                let tip = CommandDetailReadingModesTip()
                let tipViewStyle = CommandDetailReadingModesTipViewStyle()
                let controller = TipUIPopoverViewController(tip, sourceItem: readingModeButton)
                controller.viewStyle = tipViewStyle
                present(controller, animated: true)
            }
        }
    }
    
    internal func presentCircuitsTip() {
        if #available(iOS 17.0, *) {
            Task { @MainActor in
                let tip = CommandDetailCircuitsTip()
                let tipViewStyle = CommandDetailCircuitsTipViewStyle()
                let controller = TipUIPopoverViewController(tip, sourceItem: screenshotButton)
                controller.viewStyle = tipViewStyle
                present(controller, animated: true)
            }
        }
    }
    
    internal func presentColorPickerViewController() {
        let title = Constants.UI.Label.detailColorPickerTitle
        let picker = UIColorPickerViewController()
        picker.selectedColor = detailsTintColor
        picker.delegate = self
        picker.title = title
        present(picker, animated: true, completion: nil)
    }
    
    internal func presentDeviceImagesCollectionViewController() {
        let width = view.frame.size.width / 4 - 1
        let layout: UICollectionViewFlowLayout = .setupBasicGalleryFlowLayout(width: width)
        let deviceImagesVC = DeviceImagesCollectionViewController(collectionViewLayout: layout)
        deviceImagesVC.device = model.device
        navigationController?.pushViewController(deviceImagesVC, animated: true)
    }
    
    internal func presentCodeSnippetViewController() {
        let codeSnippetVC = CodeSnippetViewController.instantiate()
        codeSnippetVC.model = model
        navigationController?.pushViewController(codeSnippetVC, animated: true)
    }
    
    func presentStoreReviewController() {
        guard let scene = view.window?.windowScene else { return }
        SKStoreReviewController.requestReview(in: scene)
    }
    
    internal func moveToThePreviousViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}


//MARK: - Delegate extension
extension CommandDetailViewController: CommandDetailViewControllerDelegate {
    
    //MARK: Internal
    internal func setDetailsTintColor(color: UIColor) {
        detailsTintColor = color
    }
}


//MARK: - Main methods
private extension CommandDetailViewController {
    
    //MARK: Private
    func setupTitleLabel() {
        let content = uiModel?.title
        let tintColor = UIColor.ACDetails.tintColor
        let font = UIFont.ACFont(style: .articleTitle)
        titleLabel.textColor = tintColor
        titleLabel.numberOfLines = 1
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupSubtitleLabel() {
        let content = uiModel?.subtitle
        let tintColor = UIColor.ACDetails.tintColor
        let textColor = tintColor.withAlphaComponent(0.9)
        let font = UIFont.ACFont(style: .articleSubtitle)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = textColor
        subtitleLabel.text = content
        subtitleLabel.font = font
    }
    
    func setupContentTextView() {
        let content = uiModel?.content
        let tintColor = UIColor.ACDetails.tintColor
        let textColor: UIColor = tintColor.withAlphaComponent(0.78)
        let font = UIFont.ACFont(style: .articleContent)
        contentTextView.isScrollEnabled = true
        contentTextView.isSelectable = true
        contentTextView.isEditable = false
        contentTextView.textColor = textColor
        contentTextView.text = content
        contentTextView.font = font
    }
    
    func setupCodeScreenshotImageView() {
        let image = uiModel?.codeScreenImage
        codeScreenshotImageView.backgroundColor = .clear
        codeScreenshotImageView.contentMode = .scaleAspectFill
        codeScreenshotImageView.image = image
    }
    
    func setupContentBackgroundBlurView() {
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let cornerRadius = CGFloat.Corners.baseACBigRounding
        contentBackgroundBlurView.layer.maskedCorners = maskedCorners
        contentBackgroundBlurView.layer.cornerRadius = cornerRadius
        contentBackgroundBlurView.layer.masksToBounds = true
        contentBackgroundBlurView.layer.cornerRadius = cornerRadius
        contentBackgroundBlurView.clipsToBounds = true
    }
    
    func setupContentBackgroundView() {
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let backgroundColor = UIColor.ACDetails.secondaryBackgroundColor.withAlphaComponent(0.62)
        let cornerRadius = CGFloat.Corners.baseACBigRounding
        let tintColor = UIColor.ACDetails.tintColor
        contentBackgroundView.setFastGlassmorphismBorder()
        contentBackgroundView.layer.maskedCorners = maskedCorners
        contentBackgroundView.layer.cornerRadius = cornerRadius
        contentBackgroundView.layer.masksToBounds = true
        contentBackgroundView.backgroundColor = backgroundColor
        contentBackgroundView.tintColor = tintColor
        contentBackgroundView.alpha = 1
    }
    
    func setupDailyGoalCongratulationsView() {
        let cornerRadius = CGFloat.Corners.baseACRounding
        let shadowOffset = CGSize(width: 0, height: 0.8)
        let shadowColor = UIColor.black.cgColor
        let bounds = CGRect(x: 0, y: 0, width: 280, height: 59)
        dailyGoalCongratulationsView.setFastGlassmorphismBorder()
        dailyGoalCongratulationsView.layer.shadowColor = shadowColor
        dailyGoalCongratulationsView.layer.cornerRadius = cornerRadius
        dailyGoalCongratulationsView.layer.shadowOffset = shadowOffset
        dailyGoalCongratulationsView.layer.shadowOpacity = 0.5
        dailyGoalCongratulationsView.layer.shadowRadius = 8
        dailyGoalCongratulationsView.backgroundColor = .black
        dailyGoalCongratulationsView.bounds = bounds
    }
    
    func setupPresentDeviceImagesButton() {
        let isEnabled = uiModel?.isDevicesImagesButtonEnabled
        let icon = Constants.UI.Image.deviceIcon
        presentDeviceImagesButton.setupDetailsButton(with: icon)
        presentDeviceImagesButton.isEnabled = isEnabled!
    }
    
    func setupDetailBackgroundView() {
        let bounds = CGRect(x: 0, y: 0, width: 340, height: 450)
        detailBackgroundView.layer.cornerRadius = 0
        detailBackgroundView.backgroundColor = .clear
        detailBackgroundView.bounds = bounds
    }
    
    func setupDetailBackgroundBlurView() {
        let bounds = view.bounds
        let effect = UIBlurEffect(style: .dark)
        detailBackgroundBlurView.layer.cornerRadius = 0
        detailBackgroundBlurView.bounds = bounds
        detailBackgroundBlurView.effect = effect
    }
    
    func setupDetailContentView() {
        let bounds = CGRect(x: 0, y: 0, width: 340, height: 400)
        let cornerRadius = CGFloat.Corners.baseACRounding
        let contentBackColor = UIColor.ACDetails.secondaryBackgroundColor.withAlphaComponent(0.8)
        let contentView = detailBackgroundView.contentView!
        contentView.backgroundColor = contentBackColor
        contentView.layer.cornerRadius = cornerRadius
        contentView.bounds = bounds
        contentView.setFastGlassmorphismBorder()
    }
    
    func setupDetailHeaderLabels() {
        let textColor = UIColor.ACDetails.tintColor
        let headerLabels = [
            detailBackgroundView.syntaxHeaderLabel,
            detailBackgroundView.argumentsHeaderLabel,
            detailBackgroundView.returnsHeaderLabel
        ]
        for headerLabel in headerLabels {
            headerLabel?.textColor = textColor
            headerLabel?.backgroundColor = .clear
        }
    }
    
    func setupDetailDescriptionLabels() {
        let textColor = UIColor.ACDetails.tintColor
        let descriptionLabels = [
            detailBackgroundView.syntaxDescriptionLabel,
            detailBackgroundView.argumentsDescriptionLabel,
            detailBackgroundView.returnsDescriptionLabel
        ]
        for descriptionLabel in descriptionLabels {
            descriptionLabel?.backgroundColor = .clear
            descriptionLabel?.textColor = textColor
        }
        detailBackgroundView.syntaxDescriptionLabel.text = uiModel?.syntaxDescription
        detailBackgroundView.argumentsDescriptionLabel.text = uiModel?.argumentsDescription
        detailBackgroundView.returnsDescriptionLabel.text = uiModel?.returnsDescription
    }
    
    func setupDetailDescriptionBackViews() {
        let backColor = detailsTintColor.withAlphaComponent(0.05)
        let borderColor = detailsTintColor.cgColor
        let descriptionBackgroundViews = [
            detailBackgroundView.syntaxDescriptionBackView,
            detailBackgroundView.argumentsDescriptionBackView,
            detailBackgroundView.returnsDescriptionBackView
        ]
        for descriptionBackgroundView in descriptionBackgroundViews {
            descriptionBackgroundView?.backgroundColor = backColor
            descriptionBackgroundView?.layer.cornerRadius = 8
            descriptionBackgroundView?.layer.borderWidth = 0.8
            descriptionBackgroundView?.layer.borderColor = borderColor
        }
    }
    
    func setupDetailCopyButtons() {
        let tintColor = UIColor.ACDetails.tintColor
        let copyIconConfig = UIImage.SymbolConfiguration(scale: .large)
        let copyIconName = Constants.UI.Image.copyIcon
        let copyIcon = UIImage(systemName: copyIconName, withConfiguration: copyIconConfig)
        let copyButtons = detailBackgroundView.copyButtons!
        for copyButton in copyButtons {
            copyButton.backgroundColor = .clear
            copyButton.tintColor = tintColor
            copyButton.setImage(copyIcon, for: .normal)
        }
    }
    
    func setupScreenshotButton() {
        let title = Constants.UI.Button.goToScreenshotTitle
        let imageName = Constants.UI.Image.modelIcon
        let isEnabled = uiModel?.isScreenshotButtonEnabled
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17.2, weight: .medium, scale: .small)
        screenshotButton.setupDetailsButton(buttonType: .light,
                                            title: title,
                                            imageName: imageName,
                                            imageConfig: imageConfig,
                                            isEnabled: isEnabled!)
    }
    
    func setupCodeSnippetButton() {
        let title = Constants.UI.Button.goToCodeSnippetTitle
        let imageName = Constants.UI.Image.codeIcon
        let isEnabled = uiModel?.isCodeSnippetButtonEnabled
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17.2, weight: .medium, scale: .small)
        codeSnippetButton.setupDetailsButton(buttonType: .dark,
                                             title: title,
                                             imageName: imageName,
                                             imageConfig: imageConfig,
                                             isEnabled: isEnabled!)
    }
    
    func setupReadingModeButton() {
        let imageName = Constants.UI.Image.readingModeIcon
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15.5, weight: .regular, scale: .unspecified)
        readingModeButton.setupDetailsButton(buttonType: .dark,
                                             imageName: imageName,
                                             imageConfig: imageConfig)
    }
    
    func setupInterstitial() {
        adsClient?.setupCommandCommandCodeSnippetInterstitialAd(delegate: self, completion: { interstitial in
            self.interstitial = interstitial
        })
    }
}


//MARK: - ColorPickerViewController delegate extension
extension CommandDetailViewController: UIColorPickerViewControllerDelegate {
    
    //MARK: Internal
    internal func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        presenter?.setNewTintColor(with: viewController.selectedColor)
    }
    
    internal func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        presenter?.setNewTintColor(with: viewController.selectedColor)
    }
}


//MARK: - GADBannerView delegate extension
extension CommandDetailViewController: GADBannerViewDelegate {
    
    //MARK: Internal
    internal func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
    }
    
    internal func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerViewDidFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    internal func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
    }
    
    internal func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }
    
    internal func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }
    
    internal func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
}


//MARK: - GAD Delegate protocol extension
extension CommandDetailViewController: GADFullScreenContentDelegate {
    
    //MARK: Internal
    internal func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {}
}
