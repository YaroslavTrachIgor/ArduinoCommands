//
//  CodeSnippetViewController.swift
//  ArduinoCommands
//
//  Created by User on 25.08.2022.
//

import Foundation
import UIKit

//MARK: - Main ViewController protocol
protocol CodeSnippetViewControllerProtocol: ACBaseDetailViewController {
    func presentColorPickerViewController()
    func presentFontChangeViews(with animationType: ACBasePresentationType)
    func setupCodeContentViewAppearance(appearanceType: ACBaseAppearanceType)
    func enableBarViews(with animationType: ACBasePresentationType)
    func changeCodeTextViewFontSize()
}


//MARK: - ViewController Delegate protocol
protocol CodeSnippetViewControllerDelegate: AnyObject {
    func setCodeTintColor(color: UIColor)
    func setCodeFontSize(size: Float)
}


//MARK: - Constants
private extension CodeSnippetViewController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Label {
                
                //MARK: Static
                static let colorPickerVCTitle = "Snippet Tint Color"
            }
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
    }
}


//MARK: - Main ViewController
final class CodeSnippetViewController: UIViewController, ACBaseStoryboarded {

    //MARK: Weak
    weak var model: ACCommand!
    
    //MARK: Private
    private var codeFontSize: Float!
    private var codeTintColor: UIColor!
    private var codeContentAppearanceType: ACBaseAppearanceType = .dark
    private var uiModel: CodeSnippetUIModelProtocol {
        return CodeSnippetUIModel(model: model)
    }
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
extension CodeSnippetViewController: CodeSnippetViewControllerDelegate {
    
    //MARK: Internal
    internal func setCodeTintColor(color: UIColor) {
        codeTintColor = color
    }
    
    internal func setCodeFontSize(size: Float) {
        codeFontSize = size
    }
}


//MARK: - ViewController protocol extension
extension CodeSnippetViewController: CodeSnippetViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupCodeTextView()
        setupCodeBackgroundView()
        setupLineNumbersTextView()
        setupContentSeparatorView()
        setupContentBackgroundView()
        setupSecondaryCodeBackgroundView()
        setupFontChangePopupBlurView()
        setupFontChangePopupBackView()
        setupFontChangeContentView()
        setupFontChangeSlider()
        fontChangeDoneButton.setupPopupButton(tintColor: codeTintColor, title: Constants.UI.Button.doneButtonTitle)
        copyBarButton.setupBaseCopyBarButton()
        shareBarButton.setupBaseShareBarButton()
        costomBackBarButton.setupBaseBackBarButton()
        decorationTextView.setupBaseFooterTextView(text: Constants.UI.TextView.footer)
        appearanceSegmentedControl.setupBaseDetailDarkSegmentedControl()
        colorPickerGoButton.setupCodeContentEditingButton(tintColor: codeTintColor, imageName: Constants.UI.Button.colorPickerGoIcon)
        fontChangeButton.setupCodeContentEditingButton(tintColor: codeTintColor, imageName: Constants.UI.Button.fontChangeIcon)
        view.backgroundColor = UIColor.ACDetails.secondaryBackgroundColor
    }
    
    internal func moveToThePreviousViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    internal func presentColorPickerViewController() {
        let title = Constants.UI.Label.colorPickerVCTitle
        let picker = UIColorPickerViewController()
        picker.selectedColor = codeTintColor
        picker.delegate = self
        picker.title = title
        present(picker, animated: true, completion: nil)
    }
    
    internal func changeCodeTextViewFontSize() {
        let newFontSize = CGFloat(codeFontSize)
        let newFont = UIFont.ACCodeFont(ofSize: newFontSize)
        codeTextView.font = newFont
    }
    
    internal func presentFontChangeViews(with animationType: ACBasePresentationType) {
        animateViewIn(for: fontChangePopupBlurView, animationType: animationType)
        animateViewIn(for: fontChangePopupBackView, animationType: animationType)
    }
    
    internal func enableBarViews(with animationType: ACBasePresentationType) {
        enableViewIn(or: appearanceSegmentedControl, animationType: animationType)
        enableViewIn(or: costomBackBarButton, animationType: animationType)
        enableViewIn(or: shareBarButton, animationType: animationType)
        enableViewIn(or: copyBarButton, animationType: animationType)
    }
    
    internal func setupCodeContentViewAppearance(appearanceType: ACBaseAppearanceType) {
        setCodeContentAppearance(appearanceType: appearanceType)
    }
    
    internal func presentActivityVC(activityItems: [Any]) {
        ACActivityManager.presentVC(activityItems: activityItems, on: self)
    }
}


//MARK: - Main methods
private extension CodeSnippetViewController {
    
    //MARK: Private
    func setupCodeTextView() {
        let content = uiModel.code(codeFontSize: codeFontSize)
        codeTextView.backgroundColor = .clear
        codeTextView.attributedText = content
        codeTextView.tintColor = codeTintColor
        codeTextView.textColor = .white
    }
    
    func setupLineNumbersTextView() {
        let font = UIFont.ACCodeFont(ofSize: 16, weight: .regular)
        let content = uiModel.linesContent
        lineNumbersTextView.backgroundColor = .clear
        lineNumbersTextView.isScrollEnabled = false
        lineNumbersTextView.isSelectable = false
        lineNumbersTextView.isEditable = false
        lineNumbersTextView.textColor = codeTintColor
        lineNumbersTextView.text = content
        lineNumbersTextView.font = font
    }
    
    func setupCodeBackgroundView() {
        let maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        codeBackgroundView.layer.maskedCorners = maskedCorners
        codeBackgroundView.layer.cornerRadius = cornerRadius
        codeBackgroundView.layer.masksToBounds = true
    }
    
    func setupSecondaryCodeBackgroundView() {
        let maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        secondaryCodeBackgroundView.layer.maskedCorners = maskedCorners
        secondaryCodeBackgroundView.layer.cornerRadius = cornerRadius
        secondaryCodeBackgroundView.layer.masksToBounds = true
    }
    
    func setupContentBackgroundView() {
        let borderColor = codeTintColor.cgColor
        let backgroundColor = codeTintColor.withAlphaComponent(0.1)
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        contentBackgroundView.backgroundColor = backgroundColor
        contentBackgroundView.layer.cornerRadius = cornerRadius
        contentBackgroundView.layer.borderColor = borderColor
        contentBackgroundView.layer.borderWidth = 1
        contentBackgroundView.alpha = 1
    }
    
    func setupContentSeparatorView() {
        let backgroundColor = codeTintColor.withAlphaComponent(0.95)
        contentSeparatorView.isUserInteractionEnabled = false
        contentSeparatorView.backgroundColor = backgroundColor
        contentSeparatorView.alpha = 1
    }
    
    func setupFontChangePopupBlurView() {
        let bounds = view.bounds
        let effect = UIBlurEffect(style: .dark)
        fontChangePopupBlurView.layer.cornerRadius = 0
        fontChangePopupBlurView.bounds = bounds
        fontChangePopupBlurView.effect = effect
    }
    
    func setupFontChangePopupBackView() {
        let bounds = CGRect(x: 0, y: 0, width: 260, height: 150)
        fontChangePopupBackView.layer.cornerRadius = 0
        fontChangePopupBackView.backgroundColor = .clear
        fontChangePopupBackView.bounds = bounds
    }
    
    func setupFontChangeContentView() {
        let bounds = CGRect(x: 0, y: 0, width: 260, height: 55)
        let cornerRadius = CGFloat.Corners.baseACSecondaryRounding
        let backgroundColor = UIColor.ACDetails.secondaryBackgroundColor
        fontChangeContentView.backgroundColor = backgroundColor
        fontChangeContentView.layer.cornerRadius = cornerRadius
        fontChangeContentView.bounds = bounds
    }
    
    func setupFontChangeSlider() {
        let minimumValue: Float = 12
        let maximumValue: Float = 22
        fontChangeSlider.thumbTintColor = .white
        fontChangeSlider.minimumTrackTintColor = codeTintColor
        fontChangeSlider.minimumValue = minimumValue
        fontChangeSlider.maximumValue = maximumValue
        fontChangeSlider.tintColor = codeTintColor
        fontChangeSlider.value = codeFontSize
    }
    
    
    //MARK: Fast Methods
    /// This changes Code Content appearance with animation;
    /// - Parameter appearanceType: case of content appearanc.
    func setCodeContentAppearance(appearanceType: ACBaseAppearanceType = .dark) {
        let backgroundAlpha: CGFloat!
        let secondaryAlpha: CGFloat!
        let backgroundColor: UIColor!
        let textColor: UIColor!
        switch appearanceType {
        case .light:
            backgroundAlpha = 0.95
            secondaryAlpha = 0.1
            backgroundColor = .white
            textColor = .black
        case .dark:
            backgroundAlpha = 0.85
            secondaryAlpha = 0.06
            backgroundColor = .black
            textColor = .white
        case .system:
            backgroundAlpha = 0.85
            secondaryAlpha = 0.01
            backgroundColor = .black
            textColor = codeTintColor
        }
        /**
         In the code below, after we configured all the main variables
         which would be change depending on the particular content appearance,
         we create a special animation block,
         in which all these variables will be substituted under separate views.
         */
        let animation = UIViewPropertyAnimator(duration: 0.46, curve: .easeIn)
        animation.addAnimations { [self] in
            secondaryCodeBackgroundView.backgroundColor = codeTintColor.withAlphaComponent(secondaryAlpha)
            codeBackgroundView.backgroundColor = backgroundColor.withAlphaComponent(backgroundAlpha)
            codeTextView.textColor = textColor
        }
        animation.startAnimation()
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
