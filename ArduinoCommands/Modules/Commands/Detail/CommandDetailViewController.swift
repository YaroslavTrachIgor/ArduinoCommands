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
                static let contentBackColor = #colorLiteral(red: 0.07412604243, green: 0.07412604243, blue: 0.07412604243, alpha: 1)
                static let backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                static let tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            enum Button {
                
                //MARK: Static
                static let goToScreenshotTitle = "Screenshot"
                static let goToCodeSnippetTitle = "Code Snippet"
            }
            enum Image {
                
                //MARK: Static
                static let detailsIconName = "list.dash"
            }
        }
    }
}


//MARK: - Main View
final class DetailBackgroundView: UIView {
    
    //MARK: @IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var syntaxHeaderLabel: UILabel!
    @IBOutlet weak var syntaxDescriptionLabel: UILabel!
    @IBOutlet weak var syntaxDescriptionBackView: UIView!
    @IBOutlet weak var argumentsHeaderLabel: UILabel!
    @IBOutlet weak var argumentsDescriptionLabel: UILabel!
    @IBOutlet weak var argumentsDescriptionBackView: UIView!
    @IBOutlet weak var returnsHeaderLabel: UILabel!
    @IBOutlet weak var returnsDescriptionLabel: UILabel!
    @IBOutlet weak var returnsDescriptionBackView: UIView!
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
    @IBOutlet private weak var screenshotButton: UIButton!
    @IBOutlet private weak var codeSnippetButton: UIButton!
    @IBOutlet private weak var adBunnerView: GADBannerView!
    @IBOutlet private weak var presentDetailsButton: UIButton!
    @IBOutlet private weak var detailBackgroundBlurView: UIVisualEffectView!
    @IBOutlet private var detailBackgroundView: DetailBackgroundView!
    
    
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
    
    @IBAction func hideDetailView(_ sender: Any) {
        animateViewIn(for: detailBackgroundBlurView, animationType: .hide)
        animateViewIn(for: detailBackgroundView, animationType: .hide)
    }
    
    @IBAction func presentDetails(_ sender: Any) {
        animateViewIn(for: detailBackgroundBlurView, animationType: .present)
        animateViewIn(for: detailBackgroundView, animationType: .present)
    }
    
    @IBAction func copyDetails(_ sender: UIButton) {
        presenter?.onCopyDetails(for: sender.tag)
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
        setupCodeSnippetButton()
        setupScreenshotButton()
        setupPresentDetailsButton()
        setupDetailHeaderLabels()
        setupDetailDescriptionLabels()
        setupDetailDescriptionBackViews()
        setupDetailBackgroundBlurView()
        setupDetailBackgroundView()
        setupDetailContentView()
        setupDetailDoneButton()
        contentSegmentedControl.setupBaseDetailDarkSegmentedControl()
        leftDecorationLabel.setupReturnsDecoLabel(with: uiModel?.returns)
        middleDecorationLabel.setupDevicesDecoLabel(with: uiModel?.isUsedWithDevices)
        rightDecotationLabel.setupMethodDecoLabel()
        costomBackBarButton.setupBaseBackBarButton()
        shareBarButton.setupBaseShareBarButton()
        copyBarButton.setupBaseCopyBarButton()
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
    
    internal func presentCodeSnippetViewController() {
        let codeSnippetVC = CodeSnippetViewController.instantiate()
        codeSnippetVC.model = model
        navigationController?.pushViewController(codeSnippetVC, animated: true)
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
        let backgroundColor = Keys.UI.Colors.contentBackViewColor.withAlphaComponent(0.62)
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
        let contentBackColor = Keys.UI.Colors.contentBackColor
        let contentView = detailBackgroundView.contentView!
        contentView.backgroundColor = contentBackColor.withAlphaComponent(0.8)
        contentView.layer.cornerRadius = cornerRadius
        contentView.bounds = bounds
        contentView.setFastGlassmorphismBorder()
    }
    
    func setupDetailDoneButton() {
        
        
        ////// ADD EXTENSION
        
        
        detailBackgroundView.doneButton.tintColor = .white
        detailBackgroundView.doneButton.backgroundColor = .clear
        detailBackgroundView.doneButton.setTitle("Close", for: .normal)
        detailBackgroundView.doneButton.setTitleColor(.white, for: .normal)
    }
    
    func setupDetailHeaderLabels() {
        let headerLabels = [
            detailBackgroundView.syntaxHeaderLabel,
            detailBackgroundView.argumentsHeaderLabel,
            detailBackgroundView.returnsHeaderLabel
        ]
        for headerLabel in headerLabels {
            headerLabel?.textColor = .white
            headerLabel?.backgroundColor = .clear
        }
    }
    
    func setupDetailDescriptionLabels() {
        let descriptionLabels = [
            detailBackgroundView.syntaxDescriptionLabel,
            detailBackgroundView.argumentsDescriptionLabel,
            detailBackgroundView.returnsDescriptionLabel
        ]
        for descriptionLabel in descriptionLabels {
            descriptionLabel?.backgroundColor = .clear
            descriptionLabel?.textColor = .white
        }
        detailBackgroundView.syntaxDescriptionLabel.text = uiModel?.syntaxDescription
        detailBackgroundView.argumentsDescriptionLabel.text = uiModel?.argumentsDescription
        detailBackgroundView.returnsDescriptionLabel.text = uiModel?.returnsDescription
    }
    
    func setupDetailDescriptionBackViews() {
        let descriptionBackgroundViews = [
            detailBackgroundView.syntaxDescriptionBackView,
            detailBackgroundView.argumentsDescriptionBackView,
            detailBackgroundView.returnsDescriptionBackView
        ]
        let borderColor = UIColor.white.cgColor
        for descriptionBackgroundView in descriptionBackgroundViews {
            descriptionBackgroundView?.backgroundColor = #colorLiteral(red: 0.119350709, green: 0.119350709, blue: 0.119350709, alpha: 1)
            descriptionBackgroundView?.layer.cornerRadius = 8
            descriptionBackgroundView?.layer.borderWidth = 0.5
            descriptionBackgroundView?.layer.borderColor = borderColor
        }
    }
    
    func setupPresentDetailsButton() {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .default)
        let imageName = Keys.UI.Image.detailsIconName
        let image = UIImage(systemName: imageName, withConfiguration: imageConfiguration)
        let contentBackColor = Keys.UI.Colors.contentBackColor
        let backgroundColor = contentBackColor.withAlphaComponent(0.15)
        let tintColor = Keys.UI.Colors.tintColor
        let strokeColor = tintColor.withAlphaComponent(0.2)
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = backgroundColor
        configuration.background.strokeColor = strokeColor
        configuration.background.strokeWidth = 0.45
        configuration.cornerStyle = .large
        configuration.image = image
        presentDetailsButton.configuration = configuration
    }
    
    func setupScreenshotButton() {
        let title = Keys.UI.Button.goToScreenshotTitle
        let baseTintColor = Keys.UI.Colors.tintColor
        let baseBackgroundColor = Keys.UI.Colors.backgroundColor
        let isEnabled = uiModel?.isScreenshotEnabled!
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
        let title = Keys.UI.Button.goToCodeSnippetTitle
        let baseTintColor = Keys.UI.Colors.tintColor
        let baseBackgroundColor = Keys.UI.Colors.backgroundColor
        let contentBackColor = Keys.UI.Colors.contentBackColor
        let isEnabled = uiModel?.isCodeSnippetEnabled!
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
