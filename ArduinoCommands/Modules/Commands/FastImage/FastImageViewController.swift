//
//  FastImageViewController.swift
//  ArduinoCommands
//
//  Created by User on 25.06.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension FastImageViewController {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum View {
                enum Colors {
                    
                    //MARK: Static
                    static let copyButtonBackColor: UIColor = #colorLiteral(red: 0.09854700416, green: 0.09854700416, blue: 0.09854700416, alpha: 1)
                    static let buttonsBackColor: UIColor = #colorLiteral(red: 0.05017168075, green: 0.05017168075, blue: 0.05017168075, alpha: 1)
                    static let backgroundColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    static let tintColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                enum Corners {
                    
                    //MARK: Static
                    static let basicCornerRadius: CGFloat = 20
                }
            }
            enum Image {
                
                //MARK: Static
                static let copyIcon = "rectangle.portrait.on.rectangle.portrait"
                static let shareIcon = "square.and.arrow.up"
            }
            enum TextView {
                
                //MARK: Static
                static let decoTextViewContent = "Screenshot Interaction. By using these Buttons\n you can Save this Screenshot in defferent ways."
            }
            enum Button {
                enum Titles {
                    
                    //MARK: Static
                    static let copyTitle = "Copy"
                    static let shareTitle = "Share"
                }
                enum Subtitles {
                    
                    //MARK: Static
                    static let copySubitle = "Save to Clipboard"
                    static let shareSubitle = "with Social Media"
                }
            }
        }
    }
}


//MARK: - Fast Image preview ViewController
final class FastImageViewController: UIViewController {

    //MARK: Weak
    weak var image: UIImage!
    
    //MARK: Private
    private var presenter: FastImagePresenterProtocol? {
        return FastImagePresenter(view: self, image: image)
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var copyImageButton: UIButton!
    @IBOutlet private weak var buttonsBacKView: UIView!
    @IBOutlet private weak var buttonsBackBlurView: UIVisualEffectView!
    @IBOutlet private weak var decorationTextView: UITextView!
    
    
    //MARK: Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    @IBAction func copyImage(_ sender: Any) {
        presenter?.onCopyButton()
    }
    
    @IBAction func shareImage(_ sender: Any) {
        presenter?.onShareButton()
    }
}


//MARK: - Base ViewController protocol extension
extension FastImageViewController: ACBaseFastImageViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupMainView()
        setupImageView()
        setupScrollView()
        setupShareButton()
        setupCopyImageButton()
        setupButtonsBacKView()
        setupButtonsBackBlurView()
        decorationTextView.setupBaseFooterTextView(text: Keys.UI.TextView.decoTextViewContent, ofSize: 11.5)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        let tintColor = Keys.UI.View.Colors.backgroundColor
        ACActivityManager.presentVC(activityItems: activityItems,
                                    tintColor: tintColor,
                                    on: self)
    }
}



//MARK: - Main methods
private extension FastImageViewController {
    
    //MARK: Private
    func setupMainView() {
        let backColor = Keys.UI.View.Colors.backgroundColor.withAlphaComponent(0.02)
        let tintColor = Keys.UI.View.Colors.tintColor
        view.backgroundColor = backColor
        view.tintColor = tintColor
    }
    
    func setupImageView() {
        imageView.image = image
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupScrollView() {
        scrollView.maximumZoomScale = 4.5
        scrollView.minimumZoomScale = 1
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
    }
    
    func setupButtonsBackBlurView() {
        let cornerRadius = Keys.UI.View.Corners.basicCornerRadius
        let tintColor = Keys.UI.View.Colors.tintColor
        buttonsBackBlurView.layer.cornerRadius = cornerRadius
        buttonsBackBlurView.clipsToBounds = true
        buttonsBackBlurView.tintColor = tintColor
    }
    
    func setupButtonsBacKView() {
        let cornerRadius = Keys.UI.View.Corners.basicCornerRadius
        let backColor = Keys.UI.View.Colors.buttonsBackColor.withAlphaComponent(0.5)
        let tintColor = Keys.UI.View.Colors.tintColor
        buttonsBacKView.setFastGlassmorphismBorder()
        buttonsBacKView.layer.cornerRadius = cornerRadius
        buttonsBacKView.backgroundColor = backColor
        buttonsBacKView.tintColor = tintColor
    }
    
    func setupShareButton() {
        let title = Keys.UI.Button.Titles.shareTitle
        let subtitle = Keys.UI.Button.Subtitles.shareSubitle
        let foregroundColor = Keys.UI.View.Colors.backgroundColor
        let backgroundColor = Keys.UI.View.Colors.tintColor
        let imageKey = Keys.UI.Image.shareIcon
        let image = setupFastButtonConfiguredImage(systemName: imageKey, scale: .large)
        let attributedTitle = setupFastAttributedTitle(size: 15,
                                                       weight: .medium,
                                                       color: foregroundColor,
                                                       text: title)
        let attributedSubtitle = setupFastAttributedTitle(size: 11,
                                                          weight: .regular,
                                                          color: foregroundColor,
                                                          text: subtitle)
        var config = UIButton.Configuration.filled()
        config.setupFastButtonConfiguration(title: attributedSubtitle,
                                            subtitle: attributedTitle,
                                            image: image,
                                            backgroundColor: backgroundColor,
                                            foregroundColor: foregroundColor)
        shareButton.configuration = config
    }
    
    func setupCopyImageButton() {
        let title = Keys.UI.Button.Titles.copyTitle
        let subtitle = Keys.UI.Button.Subtitles.copySubitle
        let foregroundColor = Keys.UI.View.Colors.tintColor
        let backgroundColor = Keys.UI.View.Colors.copyButtonBackColor
        let imageKey = Keys.UI.Image.copyIcon
        let image = setupFastButtonConfiguredImage(systemName: imageKey, scale: .default)
        let attributedTitle = setupFastAttributedTitle(size: 15,
                                                       weight: .medium,
                                                       color: foregroundColor,
                                                       text: title)
        let attributedSubtitle = setupFastAttributedTitle(size: 11,
                                                          weight: .regular,
                                                          color: foregroundColor,
                                                          text: subtitle)
        var config = UIButton.Configuration.gray()
        config.setupFastButtonConfiguration(title: attributedSubtitle,
                                            subtitle: attributedTitle,
                                            image: image,
                                            backgroundColor: backgroundColor,
                                            foregroundColor: foregroundColor)
        copyImageButton.configuration = config
    }
    
    //MARK: Fast methods
    func setupFastButtonConfiguredImage(systemName: String, scale: UIImage.SymbolScale) -> UIImage {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .regular, scale: scale)
        let image = UIImage(systemName: systemName, withConfiguration: imageConfig)
        return image!
    }
    
    func setupFastAttributedTitle(size: CGFloat, weight: UIFont.Weight, color: UIColor, text: String) -> AttributedString {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        let titleAttributes = setupShareButtonTitleContainer(font: font, color: color)
        let attributedText = AttributedString(text, attributes: titleAttributes)
        return attributedText
    }
    
    func setupShareButtonTitleContainer(font: UIFont, color: UIColor) -> AttributeContainer {
        var container = AttributeContainer()
        container.foregroundColor = color
        container.font = font
        return container
    }
}


//MARK: - ScrollViewDelegate protocol
extension FastImageViewController: UIScrollViewDelegate {
    
    //MARK: Internal
    internal func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let zoomScale = scrollView.zoomScale
        if zoomScale > 1 {
            if let image = imageView.image {
                let imageWidth = image.size.width
                let imageHeight = image.size.height
                let imageViewWidth = imageView.frame.width
                let imageViewHeight = imageView.frame.height
                let ratioW = imageViewWidth / imageWidth
                let ratioH = imageViewHeight / imageHeight
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = imageWidth * ratio
                let newHeight = imageHeight * ratio
                let scrollViewHeight = scrollView.frame.height
                let scrollViewWidth = scrollView.frame.width
                let scrollViewContentWidth = scrollView.contentSize.width
                let scrollViewContentHeight = scrollView.contentSize.height
                let conditionLeft = newWidth * zoomScale > imageViewWidth
                let conditionTop = newHeight * zoomScale > imageViewHeight
                let left = 0.5 * (conditionLeft ? newWidth - imageViewWidth : (scrollViewWidth - scrollViewContentWidth))
                let top = 0.5 * (conditionTop ? newWidth - imageViewHeight : (scrollViewHeight - scrollViewContentHeight))
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
