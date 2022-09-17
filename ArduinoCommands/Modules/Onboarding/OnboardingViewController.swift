//
//  OnboardingViewController.swift
//  ArduinoCommands
//
//  Created by User on 20.06.2022.
//

import Foundation
import UIKit

//MARK: - Keys
private extension OnboardingViewController {
    
    //MARK: Public
    enum Keys {
        enum UI {
            enum Button {
                
                //MARK: Static
                static let continueButtonTitle = "Continue"
            }
        }
    }
}


//MARK: - Main Onboarding ViewController
final class OnboardingViewController: UIViewController {

    //MARK: Private
    private let contentIndex = 0
    private var presenter: OnboardingPresenterProtocol {
        return OnboardingPresenter(view: self)
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var forewordTextView: UITextView!
    @IBOutlet private weak var continueButton: UIButton!
    
    //MARK: @IBOutlet collections
    @IBOutlet private var sectionsTitleLabels: [UILabel]!
    @IBOutlet private var sectionsSubtitleLabels: [UILabel]!
    @IBOutlet private var sectionsImageViews: [UIImageView]!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.onViewDidLoad()
    }
    
    //MARK: @IBActions
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true)
    }
}


//MARK: - Base ViewController protocol extension
extension OnboardingViewController: ACBaseOnboardingViewController {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupTitleLabel()
        setupTitleLabels()
        setupContinueButton()
        setupSubtitleLabels()
        setupForewordTextView()
        setupSectionsIconImageViews()
    }
    
    internal func setupContent(with data: OnboardingUIModelProtocol) {
        titleLabel.text = data.header
        forewordTextView.text = data.foreword
        /**
         After we set the content for the top special headers,
         we set the content for the UI Elements that are repeated.
         
         To determine the right content for the needed section,
         we use the element tag specified in the `Storyboard` file.
         */
        for titleLabel in sectionsTitleLabels {
            titleLabel.text = data.sectionTitle(for: titleLabel.tag)
        }
        for subtitleLabel in sectionsSubtitleLabels {
            subtitleLabel.text = data.sectionSubtitle(for: subtitleLabel.tag)
        }
        for imageView in sectionsImageViews {
            imageView.image = data.sectionImage(for: imageView.tag)

        }
    }
}


//MARK: Main methods
private extension OnboardingViewController {
    
    //MARK: Private
    func setupTitleLabel() {
        let textColor: UIColor = .label
        let font = UIFont.systemFont(ofSize: 48, weight: .heavy)
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 1
        titleLabel.textColor = textColor
        titleLabel.font = font
    }
    
    func setupForewordTextView() {
        let font = UIFont.systemFont(ofSize: 11, weight: .regular)
        forewordTextView.isSelectable = false
        forewordTextView.isEditable = false
        forewordTextView.textColor = .secondaryLabel
        forewordTextView.font = font
    }
    
    func setupContinueButton() {
        let title = Keys.UI.Button.continueButtonTitle
        let attributes = setupContinueButtonTitleContainer()
        let attributedTitle = AttributedString(title, attributes: attributes)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .link
        config.attributedTitle = attributedTitle
        config.cornerStyle = .large
        continueButton.configuration = config
    }
    
    func setupContinueButtonTitleContainer() -> AttributeContainer {
        let font = UIFont.systemFont(ofSize: 15, weight: .medium)
        var container = AttributeContainer()
        container.foregroundColor = .systemBackground
        container.font = font
        return container
    }
    
    func setupTitleLabels() {
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        for titleLabel in sectionsTitleLabels {
            titleLabel.backgroundColor = .clear
            titleLabel.numberOfLines = 1
            titleLabel.textColor = .label
            titleLabel.font = font
        }
    }
    
    func setupSubtitleLabels() {
        let textColor: UIColor = .label.withAlphaComponent(0.85)
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        for subtitleLabel in sectionsSubtitleLabels {
            subtitleLabel.backgroundColor = .clear
            subtitleLabel.numberOfLines = 3
            subtitleLabel.textColor = textColor
            subtitleLabel.font = font
        }
    }
    
    func setupSectionsIconImageViews() {
        for imageView in sectionsImageViews {
            imageView.contentMode = .scaleAspectFit
        }
    }
}
