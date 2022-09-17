//
//  CodeSnippetViewController.swift
//  ArduinoCommands
//
//  Created by User on 25.08.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension CodeSnippetViewController {
    
    //MARK: Private
    enum Keys {
        enum UI {
            enum Button {
                
                //MARK: Static
                static let doneButtonTitle = "Done"
                static let colorPickerGoIcon = "circle.hexagongrid"
                static let fontChangeIcon = "textformat.size"
            }
            enum TextView {
                
                //MARK: Static
                static let footer = "View the code example of Command initalization. This will let you understand the basic case of its usage."
            }
        }
        enum Defaults {
            
            //MARK: Static
            static let codeTintColorKey = "CodeTintColorKey"
            static let codeFontSize = "CodeFontSizeKey"
        }
    }
}


//MARK: - ViewController delegate protocol
protocol ACBaseCodeSnippetViewControllerDelegate: AnyObject {
    func setCodeTintColor(color: UIColor)
    func setCodeFontSize(size: Float)
}


//MARK: - Main ViewController
final class CodeSnippetViewController: UIViewController, ACBaseStoryboarded {

    //MARK: Weak
    weak var model: ACCommand!
    
    //MARK: Private
    private var codeFontSize: Float!
    private var codeTintColor: UIColor!
    private var codeContentAppearanceType: ACBaseAppearanceType = .dark
    private var presenter: CodeSnippetPresenterProtocol? {
        return CodeSnippetPresenter(view: self, delegate: self, model: model)
    }
    
    //MARK: Static
    static var storyboardName: String {
        return AppDelegate.Keys.StoryboardNames.commandsListTab
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var contentBackgroundView: UIView!
    @IBOutlet private weak var contentSeparatorView: UIView!
    @IBOutlet private weak var codeTextView: UITextView!
    @IBOutlet private weak var codeBackgroundView: UIView!
    @IBOutlet private weak var secondaryCodeBackgroundView: UIView!
    @IBOutlet private weak var lineNumbersTextView: UITextView!
    @IBOutlet private weak var decorationTextView: UITextView!
    @IBOutlet private weak var appearanceSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var costomBackBarButton: UIBarButtonItem!
    @IBOutlet private weak var shareBarButton: UIBarButtonItem!
    @IBOutlet private weak var copyBarButton: UIBarButtonItem!
    @IBOutlet private weak var colorPickerGoButton: UIButton!
    @IBOutlet private weak var fontChangeButton: UIButton!
    @IBOutlet private weak var fontChangePopupBlurView: UIVisualEffectView!
    @IBOutlet private weak var fontChangePopupBackView: UIView!
    @IBOutlet private weak var fontChangeContentView: UIView!
    @IBOutlet private weak var fontChangeDoneButton: UIButton!
    @IBOutlet private weak var fontChangeSlider: UISlider!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad { tintColor, fontSize in
            self.codeTintColor = tintColor
            self.codeFontSize = fontSize
        }
    }
    
    //MARK: @IBActions
    @IBAction func dismiss(_ sender: Any) {
        presenter?.onDismiss()
    }
    
    @IBAction func shareCode(_ sender: Any) {
        presenter?.onShareCode()
    }
    
    @IBAction func copyCode(_ sender: Any) {
        presenter?.onCopyCode()
    }
    
    @IBAction func changeAppearance(_ sender: UISegmentedControl) {
        presenter?.onChangeAppearance(for: sender.selectedSegmentIndex)
    }
    
    @IBAction func changeFontSize(_ sender: UISlider) {
        presenter?.onChangeFontSize(for: sender.value)
    }
    
    @IBAction func goToColorPicker(_ sender: Any) {
        presenter?.onGoToColorPicker()
    }
    
    @IBAction func presentChangeFontPopover(_ sender: Any) {
        presenter?.onPresentChangeFontPopover()
    }
    
    @IBAction func fontChangeEndEditing(_ sender: Any) {
        presenter?.onFontChangeEndEditing()
    }
}


//MARK: - Delegate extension
extension CodeSnippetViewController: ACBaseCodeSnippetViewControllerDelegate {
    
    //MARK: Internal
    internal func setCodeTintColor(color: UIColor) {
        codeTintColor = color
    }
    
    internal func setCodeFontSize(size: Float) {
        codeFontSize = size
    }
}


//MARK: - Base ViewController protocol extension
extension CodeSnippetViewController: ACBaseCodeSnippetViewController {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupCodeTextView()
        setupCodeBackgroundView()
        setupLineNumbersTextView()
        setupContentBackgroundView()
        setupSecondaryCodeBackgroundView()
        setCodeContentAppearance(appearanceType: .dark)
        appearanceSegmentedControl.setupBaseDetailDarkSegmentedControl()
        setupCodeContentEditingButton(for: colorPickerGoButton, imageName: Keys.UI.Button.colorPickerGoIcon)
        setupCodeContentEditingButton(for: fontChangeButton, imageName: Keys.UI.Button.fontChangeIcon)
        decorationTextView.setupBaseFooterTextView(text: Keys.UI.TextView.footer)
        costomBackBarButton.setupBaseBackBarButton()
        shareBarButton.setupBaseShareBarButton()
        copyBarButton.setupBaseCopyBarButton()
        setupFontChangePopupBlurView()
        setupFontChangePopupBackView()
        setupFontChangeContentView()
        setupFontChangeDoneButton()
        setupFontChangeSlider()
        contentSeparatorView.backgroundColor = codeTintColor
        view.backgroundColor = #colorLiteral(red: 0.1044024155, green: 0.1050226167, blue: 0.1131809279, alpha: 1)
    }
    
    internal func moveToThePreviousViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    internal func presentFontChangeViews(with animationType: ACBaseAnimationType) {
        animateViewIn(for: fontChangePopupBlurView, animationType: animationType)
        animateViewIn(for: fontChangePopupBackView, animationType: animationType)
    }
    
    internal func setupCodeContentViewAppearance(appearanceType: ACBaseAppearanceType) {
        setCodeContentAppearance(appearanceType: appearanceType)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems, on: self)
    }
    
    internal func presentColorPickerViewController() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = codeTintColor
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    internal func changeCodeTextViewFontSize() {
        let newFontSize = CGFloat(codeFontSize)
        let newFont = UIFont.ACCodeFont(ofSize: newFontSize)
        codeTextView.font = newFont
    }
}


//MARK: - Main methods
private extension CodeSnippetViewController {
    
    //MARK: Private
    func setupCodeTextView() {
        let fontSize = CGFloat(codeFontSize)
        let font = UIFont.ACCodeFont(ofSize: fontSize)
        let boldFont = UIFont.ACCodeFont(ofSize: fontSize + 0.8, weight: .bold)
        let command = model.name!
        let edditedCommand = "\((command.dropLast()).dropLast())"
        let boldPartsOfString = [NSString(string: edditedCommand)]
        let attributedText = NSString(string: model.exampleOfCode!).addBoldText(boldPartsOfString: boldPartsOfString, font: font, boldFont: boldFont)
        codeTextView.backgroundColor = .clear
        codeTextView.attributedText = attributedText
    }
    
    func setupCodeBackgroundView() {
        let maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        codeBackgroundView.layer.maskedCorners = maskedCorners
        codeBackgroundView.layer.cornerRadius = cornerRadius
        codeBackgroundView.layer.masksToBounds = true
    }
    
    func setupSecondaryCodeBackgroundView() {
        let backgroundColor = codeTintColor.withAlphaComponent(0.05)
        let maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        secondaryCodeBackgroundView.backgroundColor = backgroundColor
        secondaryCodeBackgroundView.layer.maskedCorners = maskedCorners
        secondaryCodeBackgroundView.layer.cornerRadius = cornerRadius
        secondaryCodeBackgroundView.layer.masksToBounds = true
    }
    
    func setupLineNumbersTextView() {
        let font = UIFont.ACCodeFont(ofSize: 16, weight: .regular)
        var content = String()
        for lineNumber in 0...40 { content = content + " \(lineNumber)" }
        lineNumbersTextView.backgroundColor = .clear
        lineNumbersTextView.isScrollEnabled = false
        lineNumbersTextView.textColor = codeTintColor
        lineNumbersTextView.text = content
        lineNumbersTextView.font = font
    }
    
    func setupContentBackgroundView() {
        let borderColor = codeTintColor.cgColor
        let backgroundColor = codeTintColor.withAlphaComponent(0.1)
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        contentBackgroundView.backgroundColor = backgroundColor
        contentBackgroundView.layer.cornerRadius = cornerRadius
        contentBackgroundView.layer.borderColor = borderColor
        contentBackgroundView.layer.borderWidth = 1
    }
    
    func setupFontChangePopupBackView() {
        let bounds = CGRect(x: 0, y: 0, width: 260, height: 150)
        fontChangePopupBackView.backgroundColor = .clear
        fontChangePopupBackView.bounds = bounds
    }
    
    func setupFontChangeContentView() {
        let bounds = CGRect(x: 0, y: 0, width: 260, height: 55)
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        fontChangeContentView.backgroundColor = .secondarySystemBackground
        fontChangeContentView.layer.cornerRadius = cornerRadius
        fontChangeContentView.bounds = bounds
    }
    
    func setupFontChangePopupBlurView() {
        let bounds = view.bounds
        let effect = UIBlurEffect(style: .dark)
        fontChangePopupBlurView.bounds = bounds
        fontChangePopupBlurView.effect = effect
    }
    
    func setupFontChangeDoneButton() {
        let title = Keys.UI.Button.doneButtonTitle
        fontChangeDoneButton.backgroundColor = .clear
        fontChangeDoneButton.tintColor = codeTintColor
        fontChangeDoneButton.setTitle(title, for: .normal)
    }
    
    func setupFontChangeSlider() {
        let minimumValue: Float = 12
        let maximumValue: Float = 22
        fontChangeSlider.thumbTintColor = .white
        fontChangeSlider.minimumTrackTintColor = codeTintColor
        fontChangeSlider.minimumValue = minimumValue
        fontChangeSlider.maximumValue = maximumValue
        fontChangeSlider.value = codeFontSize
    }
    
    
    //MARK: Fast Methods
    func setupCodeContentEditingButton(for button: UIButton, imageName: String) {
        let borderColor = codeTintColor.cgColor
        let backgroundColor = codeTintColor.withAlphaComponent(0.1)
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        let configuration = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor
        button.layer.cornerRadius = cornerRadius
        button.tintColor = codeTintColor
        button.setImage(image, for: .normal)
        button.backgroundColor = backgroundColor
    }
    
    func setCodeContentAppearance(appearanceType: ACBaseAppearanceType = .dark) {
        let secondaryAlpha: CGFloat
        let backgroundColor: UIColor
        let textColor: UIColor
        switch appearanceType {
        case .light:
            secondaryAlpha = 0.1
            backgroundColor = .white.withAlphaComponent(0.95)
            textColor = .black
        case .dark:
            secondaryAlpha = 0.06
            backgroundColor = .black.withAlphaComponent(0.85)
            textColor = .white
        case .system:
            secondaryAlpha = 0.01
            backgroundColor = .black.withAlphaComponent(0.85)
            textColor = codeTintColor
        }
        fastContentAppearanceAnimation(textColor: textColor,
                                       backgroundColor: backgroundColor,
                                       secondaryAlpha: secondaryAlpha)
    }
    
    func animateViewIn(for view: UIView, animationType: ACBaseAnimationType) {
        switch animationType {
        case .present:
            animatedViewBaseConfiguration(for: view)
            fastAnimatedViewPresent(for: view)
        case .hide:
            fastAnimatedViewHide(for: view)
        }
    }
    
    func fastContentAppearanceAnimation(textColor: UIColor, backgroundColor: UIColor, secondaryAlpha: CGFloat) {
        let animation = UIViewPropertyAnimator(duration: 0.4, curve: .easeIn) { [self] in
            let backgroundColor = codeTintColor.withAlphaComponent(secondaryAlpha)
            secondaryCodeBackgroundView.backgroundColor = backgroundColor
            codeBackgroundView.backgroundColor = backgroundColor
            codeTextView.textColor = textColor
        }
        animation.startAnimation()
    }
    
    func animatedViewBaseConfiguration(for view: UIView) {
        let backgroundView = self.view!
        let center = backgroundView.center
        backgroundView.addSubview(view)
        view.center = center
        fastAnimatedViewSetup(for: view, alpha: 0, transform: 1.2)
    }
    
    func fastAnimatedViewPresent(for view: UIView) {
        /**
         //////////////////
         */
        UIView.animate(withDuration: 0.4) { [self] in
            fastAnimatedViewSetup(for: view, alpha: 1, transform: 1)
        }
    }
    
    func fastAnimatedViewHide(for view: UIView) {
        /**
         //////////////////
         */
        UIView.animate(withDuration: 0.4, animations: { [self] in
            fastAnimatedViewSetup(for: view, alpha: 0, transform: 1.2)
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }
    
    func fastAnimatedViewSetup(for view: UIView, alpha: CGFloat, transform: Double) {
        let transform = CGAffineTransform(scaleX: transform, y: transform)
        view.transform = transform
        view.alpha = alpha
    }
}


//MARK: - ColorPickerViewController delegate extension
extension CodeSnippetViewController: UIColorPickerViewControllerDelegate {
    
    //MARK: Internal
    internal func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        presenter?.setNewTintColor(with: viewController.selectedColor)
    }
    
    internal func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        presenter?.setNewTintColor(with: viewController.selectedColor)
    }
}
