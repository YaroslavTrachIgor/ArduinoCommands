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
                static let backgroundName = ""//"basic-knowladge-background"
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
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var leftDecoLabel: UILabel!
    @IBOutlet private weak var centerDecoLabel: UILabel!
    @IBOutlet private weak var rightDecoLabel: UILabel!
    @IBOutlet private weak var wavesImageView: UIImageView!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var contentBackView: UIView!
    
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
        setupTitleLabel()
        setupSubtitleLabel()
        setupContentTextView()
        setupDecorationCircleViews()
        leftDecoLabel.setupDecorationRoleLabel(content: Constants.UI.Label.Deco.decoLeftTitle)
        centerDecoLabel.setupDecorationRoleLabel(content: Constants.UI.Label.Deco.decoMiddleTitle, tintColor: .systemTeal)
        rightDecoLabel.setupDecorationRoleLabel(content: Constants.UI.Label.Deco.decoRightTitle, tintColor: .systemPink)
        wikiButton.configuration = setupWikiLinkButtonConfiguration()
        
        contentBackView.backgroundColor = .clear
        contentBackView.addGradient(colors: [UIColor.clear, UIColor(hexString: "#121212", alpha: 0.3), UIColor(hexString: "#121212", alpha: 0.65)], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 0.2))
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
    func setupTitleLabel() {
        let font = UIFont.ACFont(ofSize: 18, weight: .bold)
        let content = uiModel?.title
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .label
        titleLabel.text = content
        titleLabel.font = font
    }
    
    func setupSubtitleLabel() {
        let font = UIFont.ACFont(ofSize: 27, weight: .bold)
        let content = Constants.UI.Label.Content.subtitle.uppercased()
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = .white
        subtitleLabel.text = content
        subtitleLabel.font = font
    }
    
    func setupContentTextView() {
        let textColor = UIColor.secondaryLabel
        let content = uiModel?.content
        let font = UIFont.ACFont(style: .articleContent)
        let style = NSMutableParagraphStyle(); style.lineSpacing = 5
        let attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: style, .font: font]
        let attributedText = NSAttributedString(string: content!, attributes: attributes)
        contentTextView.backgroundColor = .clear
        contentTextView.attributedText = attributedText
        contentTextView.isSelectable = true
        contentTextView.isEditable = false
        contentTextView.textColor = textColor
    }
    
    func setupWikiLinkButtonConfiguration() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        let image = UIImage(systemName: "globe", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .light, scale: .medium))
        let attributedTitle = setupWikiLinkButtonAttributedTitle()
        config.baseBackgroundColor = .label
        config.baseForegroundColor = .systemBackground
        config.attributedTitle = attributedTitle
        config.cornerStyle = .capsule
        config.imagePadding = 6
        config.image = image
        return config
    }
    
    func setupWikiLinkButtonAttributedTitle() -> AttributedString {
        let title = Constants.UI.Button.wikiLinkButtonTitle
        let font = UIFont.ACFont(ofSize: 12, weight: .bold)
        var attTitle = AttributedString.init(title)
        attTitle.foregroundColor = .systemBackground
        attTitle.obliqueness = 0
        attTitle.font = font
        return attTitle
    }
    
    func setupDecorationCircleViews() {
        for decoView in decorationCircleViews {
            decoView.backgroundColor = .label
            decoView.layer.cornerRadius = decoView.frame.height / 2
        }
    }
}






extension UIView {
    func addGradient(colors: [UIColor], locations: [NSNumber]? = nil, startPoint: CGPoint = CGPoint(x: 0.16, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
