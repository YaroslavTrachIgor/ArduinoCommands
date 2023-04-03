//
//  CodeSnippetPresenter.swift
//  ArduinoCommands
//
//  Created by User on 16.09.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension CodeSnippetPresenter {
    
    //MARK: Private
    enum Keys {
        
        //MARK: Static
        static let defaultCodeTintColor: UIColor = .white
        static let defaultCodeFontSize: Float = 16
    }
}


//MARK: - Presenter protocol
protocol CodeSnippetPresenterProtocol {
    init(view: CodeSnippetViewControllerProtocol, delegate: CodeSnippetViewControllerDelegate, model: ACCommand)
    func onViewDidLoad(completion: @escaping (UIColor, Float) -> Void)
    func onShareCode()
    func onCopyCode()
    func onFontChangeEndEditing()
    func onPresentChangeFontPopover()
    func onChangeFontSize(for size: Float)
    func onChangeAppearance(for selectedSegmentIndex: Int)
    func setNewTintColor(with color: UIColor)
    func onGoToColorPicker()
    func onDismiss()
}


//MARK: - Main Presenter
final class CodeSnippetPresenter {
    
    //MARK: Private
    @ACBaseUserDefaultsColor(key: UserDefaults.Keys.codeTintColorKey)
    private var codeTintColor = Keys.defaultCodeTintColor
    @ACBaseUserDefaults<Float>(key: UserDefaults.Keys.codeFontSize)
    private var codeFontSize = Keys.defaultCodeFontSize
    
    //MARK: Weak
    private weak var delegate: CodeSnippetViewControllerDelegate?
    private weak var view: CodeSnippetViewControllerProtocol?
    private weak var model: ACCommand?
    
    
    //MARK: Initialization
    init(view: CodeSnippetViewControllerProtocol,
         delegate: CodeSnippetViewControllerDelegate,
         model: ACCommand) {
        self.view = view
        self.model = model
        self.delegate = delegate
    }
}


//MARK: - Presenter protocol extension
extension CodeSnippetPresenter: CodeSnippetPresenterProtocol {
    
    //MARK: Internal
    internal func onViewDidLoad(completion: @escaping (UIColor, Float) -> Void) {
        completion(codeTintColor, codeFontSize)
        view?.setupCodeContentViewAppearance(appearanceType: .dark)
        view?.setupMainUI()
    }
    
    internal func onGoToColorPicker() {
        view?.presentColorPickerViewController()
    }
    
    internal func onDismiss() {
        view?.moveToThePreviousViewController()
    }
    
    internal func onShareCode() {
        view?.presentActivityVC(activityItems: [model?.exampleOfCode! as Any])
    }
    
    internal func onPresentChangeFontPopover() {
        animateFontChange(presentationType: .present)
    }
    
    internal func onFontChangeEndEditing() {
        animateFontChange(presentationType: .hide)
    }
    
    internal func onChangeAppearance(for selectedSegmentIndex: Int) {
        switch selectedSegmentIndex {
        case 0:
            view?.setupCodeContentViewAppearance(appearanceType: .dark)
        case 1:
            view?.setupCodeContentViewAppearance(appearanceType: .light)
        default:
            break
        }
    }
    
    internal func onChangeFontSize(for size: Float) {
        codeFontSize = size
        delegate?.setCodeFontSize(size: size)
        view?.changeCodeTextViewFontSize()
    }
    
    internal func setNewTintColor(with color: UIColor) {
        codeTintColor = color
        delegate?.setCodeTintColor(color: color)
        view?.setupMainUI()
        view?.setupCodeContentViewAppearance(appearanceType: .dark)
        view?.resetAppearanceSegmentedControl()
    }
    
    internal func onCopyCode() {
        ACPasteboardManager.copy((model?.exampleOfCode!)!)
        ACGrayAlertManager.presentCopiedAlert(contentType: .code)
    }
}


//MARK: - Main methods
private extension CodeSnippetPresenter {
    
    //MARK: Private
    func animateFontChange(presentationType: ACBasePresentationType) {
        switch presentationType {
        case .present:
            view?.presentFontChangeViews(with: .present)
            view?.enableBarViews(with: .hide)
        case .hide:
            view?.presentFontChangeViews(with: .hide)
            view?.enableBarViews(with: .present)
        }
    }
}
