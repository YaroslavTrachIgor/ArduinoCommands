//
//  BasicKnowledgeDetailViewController.swift
//  ArduinoCommands
//
//  Created by User on 10.07.2022.
//

import Foundation
import UIKit
import SwiftUI
import StoreKit

//MARK: - Main ViewController protocol
protocol BasicKnowledgeDetailVCProtocol: ACBaseDetailViewController {
    func setFastBottomContentViewShadowColor()
    func presentSafariVC(stringURL: String)
    func presentTabBarWithAnimation(alpha: Int)
}


//MARK: - Constants
private extension BasicKnowledgeDetailViewController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Button {
                
                //MARK: Static
                static let wikiLinkButtonTitle = "Wikipedia"
            }
            enum Label {
                enum Content {
                    
                    //MARK: Static
                    static let header = "This is where we tell stories."
                    static let subtitle = "Basic Knowledge."
                    static let designedBy = "Designed by Trach Yaroslav"
                }
                enum Deco {
                    
                    //MARK: Static
                    static let decoMiddleTitle = "Basics"
                    static let decoRightTitle = "Author"
                    static let decoLeftTitle = "IDE"
                }
            }
            enum Image {
                
                //MARK: Static
                static let backgroundName = "basic-knowladge-background"
            }
        }
    }
}


//MARK: - Main ViewController
final class BasicKnowledgeDetailViewController: UIViewController, ACBaseStoryboarded {

    //MARK: Weak
    weak var model: ACBasics!
    
    //MARK: Private
    private var uiModel: BasicKnowledgeDetailUIModelProtocol? {
        return BasicKnowledgeDetailUIModel(model: model)
    }
    private var presenter: BasicKnowledgeDetailPresenterProtcol? {
        return BasicKnowledgeDetailPresenter(view: self, model: model)
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var wikiButton: UIButton!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var leftDecoLabel: UILabel!
    @IBOutlet private weak var centerDecoLabel: UILabel!
    @IBOutlet private weak var rightDecoLabel: UILabel!
    @IBOutlet private weak var wavesImageView: UIImageView!
    @IBOutlet private weak var wavesImageBlurView: UIVisualEffectView!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var bottomContentBackView: UIView!
    @IBOutlet private weak var bottomContentBackBlurView: UIVisualEffectView!
    @IBOutlet private weak var bottomContentBackImageView: UIImageView!
    @IBOutlet private weak var designedByLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    //MARK: @IBOutlet collections
    @IBOutlet private var decorationCircleViews: [UIView]!
    
    
    //MARK: Lifecucle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.onViewWillDisappear()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        presenter?.onChangeAppearance()
    }
    
    //MARK: @IBActions
    @IBAction func goToWiki(_ sender: Any) {
        presenter?.onGoToWiki()
    }
    
    @IBAction func share(_ sender: Any) {
        presenter?.onShare()
    }
    
    @IBAction func copyContent(_ sender: Any) {
        presenter?.onCopyContent()
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        presenter?.onBackToMenu()
    }
}


//MARK: - ViewController protocol extension
extension BasicKnowledgeDetailViewController: BasicKnowledgeDetailVCProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupHeaderLabel()
        setupDateLabel()
        setupTitleLabel()
        setupSubtitleLabel()
        setupContentTextView()
        setupDesignedByLabel()
        setupDecorationCircleViews()
        setupBottomContentBackView()
        setupBottomContentBackBlurView()
        setupBottomContentBackImageView()
        leftDecoLabel.setupDecorationRoleLabel(content: Constants.UI.Label.Deco.decoLeftTitle)
        centerDecoLabel.setupDecorationRoleLabel(content: Constants.UI.Label.Deco.decoMiddleTitle, tintColor: .systemTeal)
        rightDecoLabel.setupDecorationRoleLabel(content: Constants.UI.Label.Deco.decoRightTitle, tintColor: .systemPink)
        wikiButton.configuration = setupWikiLinkButtonConfiguration()
    }
    
    internal func setFastBottomContentViewShadowColor() {
        let shadowColor = UIColor.systemGray6.withAlphaComponent(0.5).cgColor
        let borderColor = UIColor.systemGray4.cgColor
        bottomContentBackView.layer.shadowColor = shadowColor
        bottomContentBackView.layer.borderColor = borderColor
    }
    
    internal func moveToThePreviousViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    internal func presentTabBarWithAnimation(alpha: Int) {
        hideTabBarWithAnimation(alpha: alpha)
    }
    
    internal func presentSafariVC(stringURL: String) {
        presentSafariVC(for: stringURL)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems, on: self)
    }
}


//MARK: - Main methods
private extension BasicKnowledgeDetailViewController {
    
    //MARK: Private
    func setupHeaderLabel() {
        let font = UIFont.ACFont(style: .header)
        let content = Constants.UI.Label.Content.header
        headerLabel.backgroundColor = .clear
        headerLabel.numberOfLines = 2
        headerLabel.textColor = .black
        headerLabel.text = content
        headerLabel.font = font
    }
    
    func setupTitleLabel() {
        let font = UIFont.ACFont(ofSize: 14, weight: .bold)
        let content = uiModel?.title
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .label
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupSubtitleLabel() {
        let font = UIFont.ACFont(style: .articleTitle)
        let content = Constants.UI.Label.Content.subtitle.uppercased()
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = .label
        subtitleLabel.text = content
        subtitleLabel.font = font
    }
    
    func setupContentTextView() {
        let textColor = UIColor.label.withAlphaComponent(0.6)
        let content = uiModel?.content
        let font = UIFont.ACFont(style: .articleContent)
        contentTextView.backgroundColor = .clear
        contentTextView.isSelectable = true
        contentTextView.isEditable = false
        contentTextView.textColor = textColor
        contentTextView.text = content
        contentTextView.font = font
    }
    
    func setupBottomContentBackView() {
        let backdColor = UIColor.secondarySystemBackground.withAlphaComponent(0.3)
        let shadowOffset = CGSize(width: 0, height: -5)
        bottomContentBackView.layer.shadowOpacity = 1
        bottomContentBackView.layer.shadowRadius = 12
        bottomContentBackView.layer.cornerRadius = CGFloat.Corners.baseACRounding
        bottomContentBackView.layer.shadowOffset = shadowOffset
        bottomContentBackView.backgroundColor = backdColor
        bottomContentBackView.setFastGlassmorphismBorder()
    }
    
    func setupBottomContentBackBlurView() {
        let effect = UIBlurEffect(style: .prominent)
        let cornerRadius = bottomContentBackView.layer.cornerRadius
        bottomContentBackBlurView.layer.cornerRadius = cornerRadius
        bottomContentBackBlurView.clipsToBounds = true
        bottomContentBackBlurView.effect = effect
    }
    
    func setupBottomContentBackImageView() {
        let imageName = Constants.UI.Image.backgroundName
        let image = UIImage(named: imageName)
        bottomContentBackImageView.contentMode = .scaleAspectFit
        bottomContentBackImageView.image = image
        bottomContentBackImageView.alpha = 0.4
    }
    
    func setupDesignedByLabel() {
        let font = UIFont.ACFont(style: .footer)
        let content = Constants.UI.Label.Content.designedBy.uppercased()
        designedByLabel.backgroundColor = .clear
        designedByLabel.numberOfLines = 1
        designedByLabel.textColor = .systemGray2
        designedByLabel.text = content
        designedByLabel.font = font
    }
    
    func setupDateLabel() {
        let content = uiModel?.dateDescription
        let font = UIFont.ACFont(style: .footer)
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = .systemGray2
        dateLabel.numberOfLines = 1
        dateLabel.text = content
        dateLabel.font = font
    }
    
    func setupWikiLinkButtonConfiguration() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        let attributedTitle = setupWikiLinkButtonAttributedTitle()
        config.baseBackgroundColor = .black
        config.attributedTitle = attributedTitle
        config.cornerStyle = .capsule
        return config
    }
    
    func setupWikiLinkButtonAttributedTitle() -> AttributedString {
        let title = Constants.UI.Button.wikiLinkButtonTitle
        let font = UIFont.ACFont(ofSize: 12, weight: .bold)
        var attTitle = AttributedString.init(title)
        attTitle.backgroundColor = .black
        attTitle.foregroundColor = .white
        attTitle.obliqueness = 0
        attTitle.font = font
        return attTitle
    }
    
    func setupDecorationCircleViews() {
        for decoView in decorationCircleViews {
            decoView.backgroundColor = .black
            decoView.layer.cornerRadius = decoView.frame.height / 2
        }
    }
}






