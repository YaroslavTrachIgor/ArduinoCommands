//
//  CommandDetailViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 26.05.2022.
//

import Foundation
import UIKit
import OpenAIKit
import GoogleMobileAds

//MARK: - Main ViewController protocol
protocol ACBaseCommandDetailViewControllerProtocol: ACBaseDetailViewController {
    func presentTabBarWithAnimation(alpha: Int)
    func changeTextViewContentAnimately(text: String)
    func presentDetailsViews(with animationType: ACBasePresentationType)
    func enableBarViews(with animationType: ACBasePresentationType)
    func presentDeviceImagesCollectionViewController()
    func presentColorPickerViewController()
    func presentCodeSnippetViewController()
    func presentFastImageViewController()
    func setupRateManager()
    func setupAdBunner()
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
                static let goToScreenshotTitle = "Screenshot"
                static let goToCodeSnippetTitle = "Code Snippet"
            }
            enum Image {
                
                //MARK: Static
                static let detailsIcon = "list.dash"
                static let colorPickerGoIcon = "circle.hexagongrid"
                static let deviceIcon = "externaldrive.badge.plus"
                static let copyIcon = "rectangle.portrait.on.rectangle.portrait"
            }
        }
    }
}


//MARK: - Main ViewController
final class CommandDetailViewController: UIViewController, ACBaseStoryboarded {
    
    //MARK: Weak
    weak var model: ACCommand!
    
    //MARK: Static
    static var storyboardName: String {
        AppDelegate.Keys.StoryboardNames.commandsListTab
    }
    
    //MARK: Private
    private var uiModel: CommandDetailUIModelProtocol? {
        return CommandDetailUIModel(model: model)
    }
    private var presenter: CommandDetailPresenterProtocol? {
        return CommandDetailPresenter(view: self, delegate: self, model: model)
    }
    private var adsClient: ACCommandDetailAdsClientProtocol? {
        return ACCommandDetailAdsClient()
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
    @IBOutlet private weak var screenshotButton: UIButton!
    @IBOutlet private weak var codeSnippetButton: UIButton!
    @IBOutlet private weak var adBunnerView: GADBannerView!
    @IBOutlet private weak var presentDetailsButton: UIButton!
    @IBOutlet private weak var presentDeviceImagesButton: UIButton!
    @IBOutlet private weak var detailBackgroundBlurView: UIVisualEffectView!
    @IBOutlet private weak var detailBackgroundView: CommandDetailBackgroundView!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad { tintColor in
            self.detailsTintColor = tintColor
        }
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
}


//MARK: - ViewController protocol extension
extension CommandDetailViewController: ACBaseCommandDetailViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupTitleLabel()
        setupSubtitleLabel()
        setupContentTextView()
        setupContentBackgroundView()
        setupCodeScreenshotImageView()
        setupContentBackgroundBlurView()
        setupCodeSnippetButton()
        setupScreenshotButton()
        setupDetailHeaderLabels()
        setupDetailDescriptionLabels()
        setupDetailDescriptionBackViews()
        setupDetailBackgroundBlurView()
        setupDetailBackgroundView()
        setupDetailContentView()
        setupDetailCopyButtons()
        setupPresentDeviceImagesButton()
        presentDetailsButton.setupDetailsButton(with: Constants.UI.Image.detailsIcon)
        detailBackgroundView.changeTintColorButton.setupCodeContentEditingButton(tintColor: detailsTintColor, imageName: Constants.UI.Image.colorPickerGoIcon)
        detailBackgroundView.doneButton.setupPopupButton(tintColor: detailsTintColor, title: Constants.UI.Button.closeTitle)
        contentSegmentedControl.setupBaseDetailDarkSegmentedControl()
        leftDecorationLabel.setupReturnsDecoLabel(with: uiModel?.returnsLabelIsHidden)
        middleDecorationLabel.setupDevicesDecoLabel(with: uiModel?.isDevicesLabelEnabled)
        rightDecotationLabel.setupMethodDecoLabel()
        costomBackBarButton.setupBaseBackBarButton()
        shareBarButton.setupBaseShareBarButton()
        copyBarButton.setupBaseCopyBarButton()
    }
    
    internal func setupAdBunner() {
        //adsClient?.setupCommandDetailAdBunner(for: adBunnerView, on: self)
    }
    
    internal func changeTextViewContentAnimately(text: String) {
        contentTextView.changeTextWithAnimation(text: text)
    }
    
    internal func presentTabBarWithAnimation(alpha: Int) {
        hideTabBarWithAnimation(alpha: alpha)
    }
    
    internal func presentDetailsViews(with animationType: ACBasePresentationType) {
        animateViewIn(for: detailBackgroundBlurView, animationType: animationType)
        animateViewIn(for: detailBackgroundView, animationType: animationType)
    }
    
    internal func enableBarViews(with animationType: ACBasePresentationType) {
        enableViewIn(or: contentSegmentedControl, animationType: animationType)
        enableViewIn(or: costomBackBarButton, animationType: animationType)
        enableViewIn(or: shareBarButton, animationType: animationType)
        enableViewIn(or: copyBarButton, animationType: animationType)
    }
    
    internal func setupRateManager() {
        ACRateManager.shared.currentViewController = self
        ACRateManager.shared.presentRateAlert()
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems, on: self)
    }
    
    internal func presentFastImageViewController() {
        let imageVC = FastImageViewController()
        imageVC.image = codeScreenshotImageView.image
        presentSheet(with: imageVC, detents: [.large()])
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
    func setupCodeScreenshotImageView() {
        let image = uiModel?.codeScreenImage
        codeScreenshotImageView.backgroundColor = .clear
        codeScreenshotImageView.contentMode = .scaleAspectFill
        codeScreenshotImageView.image = image
    }
    
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
        contentBackgroundView.layer.maskedCorners = maskedCorners
        contentBackgroundView.layer.cornerRadius = cornerRadius
        contentBackgroundView.layer.masksToBounds = true
        contentBackgroundView.setFastGlassmorphismBorder()
        contentBackgroundView.backgroundColor = backgroundColor
        contentBackgroundView.tintColor = tintColor
        contentBackgroundView.alpha = 1
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
        let baseTintColor = UIColor.ACDetails.tintColor
        let baseBackgroundColor = UIColor.ACDetails.backgroundColor
        let isEnabled = uiModel?.isScreenshotButtonEnabled!
        let backgroundColor: UIColor
        let tintColor: UIColor
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        /**
         In the code below, before we setup needed button properties,
         we check if this buton for this command enabled
         through uiModel properties(in this case, if Screenshot enabled).
         */
        if isEnabled! {
            tintColor = baseBackgroundColor
            backgroundColor = baseTintColor.withAlphaComponent(0.95)
        } else {
            tintColor = baseTintColor.withAlphaComponent(0.55)
            backgroundColor = baseTintColor.withAlphaComponent(0.2)
        }
        let attributes = setupCodeSnippetButtonTitleContainer(tintColor: tintColor)
        let attributedTitle = AttributedString(title, attributes: attributes)
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = tintColor
        configuration.attributedTitle = attributedTitle
        screenshotButton.configuration = configuration
        screenshotButton.isEnabled = isEnabled!
    }
    
    func setupCodeSnippetButton() {
        let title = Constants.UI.Button.goToCodeSnippetTitle
        let baseTintColor = UIColor.ACDetails.tintColor
        let baseBackgroundColor = UIColor.ACDetails.backgroundColor
        let contentBackColor = UIColor.ACDetails.secondaryBackgroundColor
        let isEnabled = uiModel?.isCodeSnippetButtonEnabled!
        let backgroundColor: UIColor
        let strokeColor: UIColor
        let tintColor: UIColor
        var configuration = UIButton.Configuration.filled()
        configuration.background.strokeWidth = 0.45
        configuration.cornerStyle = .large
        /**
         In the code below, before we setup needed button properties,
         we check if this buton for this command enabled
         through uiModel properties(in this case, if Code Snippet enabled).
         */
        if isEnabled! {
            tintColor = baseTintColor
            backgroundColor = contentBackColor.withAlphaComponent(0.95)
            strokeColor = tintColor.withAlphaComponent(0.2)
        } else {
            tintColor = baseBackgroundColor.withAlphaComponent(0.55)
            backgroundColor = contentBackColor.withAlphaComponent(0.2)
            strokeColor = tintColor.withAlphaComponent(0.06)
        }
        let attributes = setupCodeSnippetButtonTitleContainer(tintColor: tintColor)
        let attributedTitle = AttributedString(title, attributes: attributes)
        configuration.attributedTitle = attributedTitle
        configuration.baseForegroundColor = tintColor
        configuration.background.backgroundColor = backgroundColor
        configuration.background.strokeColor = strokeColor
        codeSnippetButton.configuration = configuration
        codeSnippetButton.isEnabled = isEnabled!
    }
    
    
    //MARK: Fast methods
    func setupCodeSnippetButtonTitleContainer(tintColor: UIColor) -> AttributeContainer {
        let font = UIFont.systemFont(ofSize: 16.5, weight: .medium)
        var container = AttributeContainer()
        container.foregroundColor = tintColor
        container.font = font
        return container
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
