//
//  CodeSnippetViewController.swift
//  ArduinoCommands
//
//  Created by User on 25.08.2022.
//

import Foundation
import UIKit

//MARK -
public extension NSString {
    
    //MARK: Public
    func addBoldText(boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: self.range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
}


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


//MARK: - Main code snippet ViewController
final class CodeSnippetViewController: UIViewController, ACBaseStoryboarded {

    //MARK: Weak
    weak var model: ACCommand!
    
    //MARK: Private
    private var codeContentAppearanceType: ACBaseAppearanceType = .dark
    @ACBaseUserDefaultsColor(key: Keys.Defaults.codeTintColorKey)
    private var codeTintColor = .white
    @ACBaseUserDefaults<Float>(key: Keys.Defaults.codeFontSize)
    private var codeFontSize = 16
    
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
        setupFontChangePopupBackView()
        setupFontChangeContentView()
        setupFontChangePopupBlurView()
        setupFontChangeDoneButton()
        setupFontChangeSlider()
        contentSeparatorView.backgroundColor = codeTintColor
        view.backgroundColor = #colorLiteral(red: 0.1044024155, green: 0.1050226167, blue: 0.1131809279, alpha: 1)
    }
    
    
    //MARK: @IBActions
    @IBAction func dismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareCode(_ sender: Any) {
        ACActivityManager.presentVC(activityItems: [model.name!], on: self)
    }
    
    @IBAction func presentScreenshot(_ sender: Any) {
        ACPasteboardManager.copy(model.name!)
        ACGrayAlertManager.presentCopiedAlert(contentType: .code)
    }
    
    @IBAction func changeAppearance(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            setCodeContentAppearance(appearanceType: .dark)
        case 1:
            setCodeContentAppearance(appearanceType: .light)
        default:
            break
        }
    }
    
    @IBAction func changeTintColor(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = codeTintColor
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func presentChangeFontPopover(_ sender: Any) {
        animateViewIn(for: fontChangePopupBlurView, animationType: .present)
        animateViewIn(for: fontChangePopupBackView, animationType: .present)
    }
    
    @IBAction func fontChangeEndEditing(_ sender: Any) {
        animateViewIn(for: fontChangePopupBlurView, animationType: .hide)
        animateViewIn(for: fontChangePopupBackView, animationType: .hide)
    }
    
    @IBAction func changeFontSize(_ sender: UISlider) {
        let newFontSize = CGFloat(sender.value)
        let newFont = UIFont(name: "Menlo", size: newFontSize)
        let newBoldFont = UIFont(name: "Menlo", size: newFontSize)
        let command = model.name!
        let edditedCommand = "\((command.dropLast()).dropLast())"
        codeTextView.attributedText = NSString(string: model.exampleOfCode!).addBoldText(boldPartsOfString: [NSString(string: edditedCommand)], font: newFont!, boldFont: newBoldFont!)
        codeFontSize = sender.value
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
        setupFontChangePopupBackView()
        setupFontChangeContentView()
        setupFontChangePopupBlurView()
        setupFontChangeDoneButton()
        setupFontChangeSlider()
        contentSeparatorView.backgroundColor = codeTintColor
        view.backgroundColor = #colorLiteral(red: 0.1044024155, green: 0.1050226167, blue: 0.1131809279, alpha: 1)
    }
    
    internal func setupCodeContentViewAppearance(appearanceType: ACBaseAppearanceType) {
        setCodeContentAppearance(appearanceType: appearanceType)
    }
    
    internal func presentFontChangeViews(with animationType: ACBaseAnimationType) {
        animateViewIn(for: fontChangePopupBlurView, animationType: animationType)
        animateViewIn(for: fontChangePopupBackView, animationType: animationType)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems, on: self)
    }
    
    internal func changeCodeTextViewFontSize(with size: Float) {
        let newFontSize = CGFloat(size)
        let newFont = UIFont(name: "Menlo", size: newFontSize)
        codeTextView.font = newFont
    }
    
    internal func presentColorPickerViewController() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = codeTintColor
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    internal func moveToThePreviousViewController() {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - Main methods
private extension CodeSnippetViewController {
    
    //MARK: Private
    func setupCodeTextView() {
        let fontSize = CGFloat(codeFontSize)
        let font = UIFont(name: "Menlo", size: fontSize)
        let boldFont = UIFont(name: "Menlo Bold", size: fontSize + 0.8)
        let command = model.name!
        let edditedCommand = "\((command.dropLast()).dropLast())"
        codeTextView.backgroundColor = .clear
        codeTextView.attributedText = NSString(string: model.exampleOfCode!).addBoldText(boldPartsOfString: [NSString(string: edditedCommand)], font: font!, boldFont: boldFont!)
    }
    
    func setupCodeBackgroundView() {
        codeBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        codeBackgroundView.layer.cornerRadius = 12
        codeBackgroundView.layer.masksToBounds = true
    }
    
    func setupSecondaryCodeBackgroundView() {
        secondaryCodeBackgroundView.backgroundColor = codeTintColor.withAlphaComponent(0.05)
        secondaryCodeBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        secondaryCodeBackgroundView.layer.cornerRadius = 12
        secondaryCodeBackgroundView.layer.masksToBounds = true
    }
    
    func setupLineNumbersTextView() {
        let fontn = UIFont(name: "Menlo", size: 16)
        var content = String()
        for lineNumber in 0...40 { content = content + " \(lineNumber)" }
        lineNumbersTextView.backgroundColor = .clear
        lineNumbersTextView.isScrollEnabled = false
        lineNumbersTextView.textColor = codeTintColor
        lineNumbersTextView.text = content
        lineNumbersTextView.font = fontn
    }
    
    func setupContentBackgroundView() {
        contentBackgroundView.backgroundColor = codeTintColor.withAlphaComponent(0.1)
        contentBackgroundView.layer.cornerRadius = 12
        contentBackgroundView.layer.borderWidth = 1
        contentBackgroundView.layer.borderColor = codeTintColor.cgColor
    }
    
    func setupFontChangePopupBackView() {
        fontChangePopupBackView.bounds = CGRect(x: 0, y: 0, width: 260, height: 150)
        fontChangePopupBackView.backgroundColor = .clear
    }
    
    func setupFontChangeContentView() {
        fontChangeContentView.bounds = CGRect(x: 0, y: 0, width: 260, height: 55)
        fontChangeContentView.layer.cornerRadius = 12
        fontChangeContentView.backgroundColor = .secondarySystemBackground
    }
    
    func setupFontChangePopupBlurView() {
        fontChangePopupBlurView.bounds = view.bounds
        fontChangePopupBlurView.effect = UIBlurEffect(style: .dark)
    }
    
    func setupFontChangeDoneButton() {
        let title = Keys.UI.Button.doneButtonTitle
        fontChangeDoneButton.backgroundColor = .clear
        fontChangeDoneButton.tintColor = codeTintColor
        fontChangeDoneButton.setTitle(title, for: .normal)
    }
    
    func setupFontChangeSlider() {
        fontChangeSlider.minimumTrackTintColor = codeTintColor
        fontChangeSlider.thumbTintColor = .white
        fontChangeSlider.minimumValue = 12
        fontChangeSlider.maximumValue = 22
        fontChangeSlider.value = codeFontSize
    }
    
    func setupCodeContentEditingButton(for button: UIButton, imageName: String) {
        button.layer.borderColor = codeTintColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.tintColor = codeTintColor
        button.setImage(UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(scale: .medium)), for: .normal)
        button.backgroundColor = codeTintColor.withAlphaComponent(0.1)
    }
    
    func setCodeContentAppearance(appearanceType: ACBaseAppearanceType = .dark) {
        let secondaryAlphaColor: CGFloat
        let backgroundColor: UIColor
        let textColor: UIColor
        
        switch appearanceType {
        case .light:
            secondaryAlphaColor = 0.1
            backgroundColor = .white.withAlphaComponent(0.95)
            textColor = .black
        case .dark:
            secondaryAlphaColor = 0.06
            backgroundColor = .black.withAlphaComponent(0.85)
            textColor = .white
        case .system:
            secondaryAlphaColor = 0.01
            backgroundColor = .black.withAlphaComponent(0.85)
            textColor = codeTintColor
        }
        
        let animation = UIViewPropertyAnimator(duration: 0.4, curve: .easeIn) { [self] in
            secondaryCodeBackgroundView.backgroundColor = codeTintColor.withAlphaComponent(secondaryAlphaColor)
            codeBackgroundView.backgroundColor = backgroundColor
            codeTextView.textColor = textColor
        }
        animation.startAnimation()
    }
    
    func animateViewIn(for desiredView: UIView, animationType: ACBaseAnimationType) {
        switch animationType {
        case .present:
            let backgroundView = self.view!
            backgroundView.addSubview(desiredView)
            
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.center = backgroundView.center
            desiredView.alpha = 0
            
            UIView.animate(withDuration: 0.4) {
                desiredView.transform = CGAffineTransform(scaleX: 1, y: 1)
                desiredView.alpha = 1
            }
        case .hide:
            UIView.animate(withDuration: 0.4, animations: {
                desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                desiredView.alpha = 0
            }, completion: { _ in
                desiredView.removeFromSuperview()
            })
        }
    }
}


public enum ACBaseAppearanceType {
    case light
    case dark
    case system
}


public enum ACBaseAnimationType {
    case present
    case hide
}


extension CodeSnippetViewController: UIColorPickerViewControllerDelegate {
    
    //MARK: Internal
    internal func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        codeTintColor = viewController.selectedColor
        viewDidLoad()
    }
    
    internal func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        codeTintColor = viewController.selectedColor
        viewDidLoad()
    }
}
