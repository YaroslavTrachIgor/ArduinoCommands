//
//  CommandDetailViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 26.05.2022.
//

import Foundation
import UIKit
import GoogleMobileAds

//MARK: - Keys
private extension CommandDetailViewController {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Colors {
                
                //MARK: Static
                static let contentBackViewColor = #colorLiteral(red: 0.06201352924, green: 0.06201352924, blue: 0.06201352924, alpha: 1)
                static let backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                static let tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            enum Button {
                
                //MARK: Static
                static let codeSnippetTitle = "Code Snippet"
            }
        }
    }
}

private extension UIBarButtonItem {

    //MARK: Private
    enum Keys {
        enum UI {
            enum ImageNames {
                
                //MARK: Static
                static let costomBackItemName = "arrow.backward"
                static let shareItemName = "square.and.arrow.up"
                static let copyItemName = "square.on.square"
            }
        }
    }
}


public extension UIBarButtonItem {
    
    //MARK: Public
    func setupFastLightBarButtonItem(imageName: String, imageWeight: UIImage.SymbolWeight = .regular, tintColor: UIColor = .white) {
        let config = UIImage.SymbolConfiguration(weight: imageWeight)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        self.tintColor = tintColor
        self.image = image
    }
    
    func setupBaseCopyBarButton() {
        setupFastLightBarButtonItem(imageName: Keys.UI.ImageNames.copyItemName)
    }
    
    func setupBaseShareBarButton() {
        setupFastLightBarButtonItem(imageName: Keys.UI.ImageNames.shareItemName)
    }
    
    func setupBaseBackBarButton() {
        setupFastLightBarButtonItem(imageName: Keys.UI.ImageNames.costomBackItemName)
    }
}


public extension UISegmentedControl {
    
    //MARK: Public
    func setupBaseDetailDarkSegmentedControl() {
        let attributedFontKey = NSAttributedString.Key.font
        let attributedForegroundColorKey = NSAttributedString.Key.foregroundColor
        let segmentedControlBackColor: UIColor = .black.withAlphaComponent(0.25)
        let font = UIFont.ACFont(ofSize: 12, weight: .bold)
        self.backgroundColor = segmentedControlBackColor
        self.selectedSegmentTintColor = backgroundColor
        self.setTitleTextAttributes([attributedForegroundColorKey: segmentedControlBackColor], for: .selected)
        self.setTitleTextAttributes([attributedForegroundColorKey: UIColor.white], for: .normal)
        self.setTitleTextAttributes([attributedFontKey: font], for: .selected)
    }
}



//MARK: - Main command detail ViewController
final class CommandDetailViewController: UIViewController, ACBaseStoryboarded {
    
    //MARK: Weak
    weak var model: ACCommand!
    
    //MARK: Static
    static var storyboardName: String {
        AppDelegate.Keys.StoryboardNames.commandsListTab
    }
    
    //MARK: Private
    private let adsManager = ACGoogleAdsManagar.shared
    private var uiModel: CommandDetailUIModelProtocol? {
        return CommandDetailUIModel(model: model)
    }
    private var presenter: CommandDetailPresenterProtocol? {
        return CommandDetailPresenter(view: self, model: model)
    }
    
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
    @IBOutlet private weak var codeSnippetButton: UIButton!
    @IBOutlet private weak var adBunnerView: GADBannerView!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad()
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
}


//MARK: - Base ViewController protocol extension
extension CommandDetailViewController: ACBaseCommandDetailViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupTitleLabel()
        setupSubtitleLabel()
        setupContentTextView()
        setupContentBackgroundView()
        setupCodeScreenshotImageView()
        setupContentBackgroundBlurView()
        contentSegmentedControl.setupBaseDetailDarkSegmentedControl()
        leftDecorationLabel.setupReturnsDecoLabel(with: uiModel?.returns)
        middleDecorationLabel.setupDevicesDecoLabel(with: uiModel?.isUsedWithDevices)
        rightDecotationLabel.setupMethodDecoLabel()
        costomBackBarButton.setupBaseBackBarButton()
        shareBarButton.setupBaseShareBarButton()
        copyBarButton.setupBaseCopyBarButton()
        setupCodeSnippetButton()
    }
    
    internal func changeTextViewContentAnimately(text: String) {
        contentTextView.changeTextWithAnimation(text: text)
    }
    
    internal func presentTabBarWithAnimation(alpha: Int) {
        hideTabBarWithAnimation(alpha: alpha)
    }
    
    internal func setupAdBunner() {
        adsManager.rootViewController = self
        adsManager.setupCommandDetailAdBunner(for: adBunnerView)
    }
    
    internal func presentFastImageViewController() {
        let imageVC = FastImageViewController()
        imageVC.image = codeScreenshotImageView.image
        presentSheet(with: imageVC, detents: [.large()])
    }
    
    internal func presentCodeSnippetViewController() {
        let codeSnippetVC = CodeSnippetViewController.instantiate()
        codeSnippetVC.model = model
        navigationController?.pushViewController(codeSnippetVC, animated: true)
    }
    
    internal func setupRateManager() {
        ACRateManager.shared.currentViewController = self
        ACRateManager.shared.presentRateAlert()
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems, on: self)
    }
    
    internal func moveToThePreviousViewController() {
        navigationController?.popToRootViewController(animated: true)
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
        let tintColor = Keys.UI.Colors.tintColor
        let font = UIFont.ACFont(style: .articleTitle)
        titleLabel.textColor = tintColor
        titleLabel.numberOfLines = 1
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupSubtitleLabel() {
        let content = uiModel?.subtitle
        let tintColor = Keys.UI.Colors.tintColor
        let textColor = tintColor.withAlphaComponent(0.9)
        let font = UIFont.ACFont(style: .articleSubtitle)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = textColor
        subtitleLabel.text = content
        subtitleLabel.font = font
    }
    
    func setupContentTextView() {
        let content = uiModel?.content
        let tintColor = Keys.UI.Colors.tintColor
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
        let backgroundColor = Keys.UI.Colors.contentBackViewColor.withAlphaComponent(0.25)
        let cornerRadius = CGFloat.Corners.baseACBigRounding
        let tintColor = Keys.UI.Colors.tintColor
        contentBackgroundView.layer.maskedCorners = maskedCorners
        contentBackgroundView.layer.cornerRadius = cornerRadius
        contentBackgroundView.layer.masksToBounds = true
        contentBackgroundView.setFastGlassmorphismBorder()
        contentBackgroundView.backgroundColor = backgroundColor
        contentBackgroundView.tintColor = tintColor
        contentBackgroundView.alpha = 1
    }
    
    func setupCodeSnippetButton() {
        let title = Keys.UI.Button.codeSnippetTitle
        let tintColor = Keys.UI.Colors.tintColor
        let attributes = setupCodeSnippetButtonTitleContainer()
        let attributedTitle = AttributedString(title, attributes: attributes)
        let strokeColor = tintColor.withAlphaComponent(0.2)
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = attributedTitle
        configuration.baseForegroundColor = tintColor
        configuration.background.backgroundColor = #colorLiteral(red: 0.07412604243, green: 0.07412604243, blue: 0.07412604243, alpha: 1)
        configuration.background.strokeColor = strokeColor
        configuration.background.strokeWidth = 0.45
        configuration.cornerStyle = .large
        codeSnippetButton.configuration = configuration
    }
    
    func setupCodeSnippetButtonTitleContainer() -> AttributeContainer {
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        var container = AttributeContainer()
        container.foregroundColor = Keys.UI.Colors.tintColor
        container.font = font
        return container
    }
}
