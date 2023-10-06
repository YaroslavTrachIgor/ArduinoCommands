//
//  CommandReadingModeContentAppearanceViewController.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-07.
//

import Foundation
import SwiftUI
import UIKit

//MARK: - ViewController protocol
protocol CommandReadingModeAppearanceViewControllerProtocol: ACBaseViewController {
    func updateArtcileThemeButtons(selectedIndex: Int)
    func updateArtcileThemeNameLabels(selectedIndex: Int)
    func updateContentFontButtons(selectedIndex: Int)
    func updateContentFontNameLabels(selectedIndex: Int)
    func updateSliderValue(_ contentFontSize: Float)
}


//MARK: - Constants
private extension CommandReadingModeAppearanceViewController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum Slider {
                
                //MARK: Static
                static let fontSizeMinimumValue             = Float(11.0)
                static let fontSizeMaximumValue             = Float(23.0)
            }
            enum View {
                
                //MARK: Static
                static let mainViewBackgroundColor          = UIColor.quaternaryLabel
                static let secondaryViewBackgroundColor     = UIColor.systemBackground
            }
            enum Button {
                enum FontThemeButton {
                    
                    //MARK: Static
                    static let serifFont                    = UIFont.ACFont(ofSize: 19, weight: .bold)
                    static let timesFont                    = UIFont.ACReadingFont(ofSize: 19, weight: .bold)
                    static let classicFont                  = UIFont.systemFont(ofSize: 19, weight: .medium)
                    
                    static let backgroundColor              = UIColor.systemBackground
                    static let foregroundColor              = UIColor.systemGray4
                    static let selectedForegroundColor      = UIColor.label
                }
                enum ColorThemeButton {
                    enum White {
                        
                        //MARK: Static
                        static let strokeColor              = UIColor.systemGray4
                        static let backgroundColor          = UIColor.systemBackground
                        static let foregroundColor          = UIColor.systemGray4
                        static let selectedForegroundColor  = UIColor.label
                    }
                    enum Eggshell {
                        
                        //MARK: Static
                        static let strokeColor              = UIColor.clear
                        static let backgroundColor          = UIColor(hexString: "#faf7ed", alpha: 1)
                        static let foregroundColor          = UIColor(hexString: "#5e472b", alpha: 1)
                        static let selectedForegroundColor  = UIColor(hexString: "#5e472b", alpha: 1)
                    }
                    enum Nightowl {
                        
                        //MARK: Static
                        static let strokeColor              = UIColor.clear
                        static let backgroundColor          = UIColor(hexString: "#0c0f21", alpha: 1)
                        static let foregroundColor          = UIColor.white
                        static let selectedForegroundColor  = UIColor.white
                    }
                }
                
                //MARK: Static
                static let themeExmapleTitle = "Aa"
            }
            enum TextView {
                
                //MARK: Static
                static let exampleArticle = "A detailed description of the function. A detailed description of the arguments, syntax, and return value of the function. A detailed description of the circumstances during which the function may not work correctly."
            }
        }
    }
}


//MARK: - ViewController Representable protocol extension
struct CommandReadingModeAppearanceView: UIViewControllerRepresentable {
    
    //MARK: Public
    var themeManager: CommandReadingModeThemeManager
    
    //MARK: Internal
    internal func makeUIViewController(context: Context) -> CommandReadingModeAppearanceViewController {
        let viewController = CommandReadingModeAppearanceViewController.instantiate()
        viewController.themeManager = themeManager
        return viewController
    }

    internal func updateUIViewController(_ uiViewController: CommandReadingModeAppearanceViewController, context: Context) {}
}


//MARK: - Main ViewController
final class CommandReadingModeAppearanceViewController: UIViewController, ACBaseStoryboarded, CommandReadingModeAppearanceManagerInjector {
    
    //MARK: Public
    public var themeManager: CommandReadingModeThemeManager?
    
    //MARK: Static
    static var storyboardName: String {
        return AppDelegate.Keys.StoryboardNames.commandsListTab
    }
    
    //MARK: @IBOutlets
    @IBOutlet private weak var contentAppearanceToolBarView: UIView!
    @IBOutlet weak var brightnessProgressView: UIProgressView!
    @IBOutlet private weak var fontSizeSlider: UISlider!
    
    //MARK: @IBOutlet Collections
    @IBOutlet private var sliderDecorationBarViews: [UIView]!
    @IBOutlet private var changeArtcileThemeButtons: [UIButton]!
    @IBOutlet private var changeContentFontButtons: [UIButton]!
    @IBOutlet private var articleThemeNamesLabels: [UILabel]!
    @IBOutlet private var contentFontNamesLabels: [UILabel]!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainUI()
        
        let colorThemeIndex = appearanceManager.colorThemeIndex
        let fontThemeIndex = appearanceManager.fontThemeIndex
        updateArtcileThemeNameLabels(selectedIndex: colorThemeIndex)
        updateContentFontNameLabels(selectedIndex: fontThemeIndex)
        updateArtcileThemeButtons(selectedIndex: colorThemeIndex)
        updateContentFontButtons(selectedIndex: fontThemeIndex)
        
        let fontSize = themeManager?.fontSize
        updateSliderValue(Float(fontSize!))
    }
    
    @IBAction func changeArtcleAppearance(_ sender: UIButton) {
        let colorThemeIndex = sender.tag
        appearanceManager.updateAppearanceThemeIndex(colorThemeIndex)
        updateArtcileThemeNameLabels(selectedIndex: colorThemeIndex)
        updateArtcileThemeButtons(selectedIndex: colorThemeIndex)
        
        let colorTheme = appearanceManager.getColorTheme()
        themeManager?.colorTheme = colorTheme!
    }
    
    @IBAction func changeContentFont(_ sender: UIButton) {
        let fontIndex = sender.tag
        appearanceManager.updateContentFontThemeIndex(fontIndex)
        updateContentFontButtons(selectedIndex: fontIndex)
        updateContentFontNameLabels(selectedIndex: fontIndex)
        
        let fontTheme = appearanceManager.getFontTheme()
        themeManager?.fontTheme = fontTheme!
    }
    
    @IBAction func chnageFontSize(_ sender: UISlider) {
        let fontSize = CGFloat(sender.value)
        themeManager?.fontSize = fontSize
    }
}


//MARK: - Main methods
private extension CommandReadingModeAppearanceViewController {
    
    //MARK: Private
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupFontSizeSlider() {
        let minimumValue = Constants.UI.Slider.fontSizeMinimumValue
        let maximumValue = Constants.UI.Slider.fontSizeMaximumValue
        let tintColor = Constants.UI.View.mainViewBackgroundColor
        fontSizeSlider.maximumTrackTintColor = tintColor
        fontSizeSlider.minimumTrackTintColor = .black
        fontSizeSlider.minimumValue = minimumValue
        fontSizeSlider.maximumValue = maximumValue
    }
    
    func setupBrightnessProgressView() {
        let trackTintColor = Constants.UI.View.mainViewBackgroundColor
        let brightness = Float(UIScreen.main.brightness)
        brightnessProgressView.progress = brightness
        brightnessProgressView.trackTintColor = trackTintColor
        brightnessProgressView.progressTintColor = .black
    }
    
    func setupContentAppearanceToolBarView() {
        let backgroundColor = Constants.UI.View.secondaryViewBackgroundColor
        contentAppearanceToolBarView.backgroundColor = backgroundColor
        contentAppearanceToolBarView.clipsToBounds = true
    }
    
    func setupSliderDecorationBarViews() {
        for sliderDecorationBarView in sliderDecorationBarViews {
            let backgroundColor = Constants.UI.View.mainViewBackgroundColor
            let cornerRadius: CGFloat = sliderDecorationBarView.frame.width / 2
            sliderDecorationBarView.backgroundColor = backgroundColor
            sliderDecorationBarView.layer.cornerRadius = cornerRadius
        }
    }
    
    func setupFastAppearanceButton(for button: UIButton, isSelected: Bool, backgroundColor: UIColor, foregroundColor: UIColor, selectedForegroundColor: UIColor, strokeColor: UIColor, font: UIFont) {
        var configuration = UIButton.Configuration.filled()
        let foregroundColor: UIColor = isSelected ? selectedForegroundColor : foregroundColor
        let title = Constants.UI.Button.themeExmapleTitle
        let attributes = foregroundColor.setupButtonTitleContainer(font: font)
        let attributedTitle = AttributedString(title, attributes: attributes)
        let strokeColor: UIColor = isSelected ? .label : strokeColor
        let strokeWidth: CGFloat = isSelected ? 1.75 : 1.2
        configuration.background.backgroundColor = backgroundColor
        configuration.background.strokeColor = strokeColor
        configuration.background.strokeWidth = strokeWidth
        configuration.baseForegroundColor = foregroundColor
        configuration.attributedTitle = attributedTitle
        button.configuration = configuration
    }
    
    func setupFastNameLabel(for label: UILabel, isSelected: Bool) {
        let fontWeight: UIFont.Weight = isSelected ? .medium : .regular
        let textColor: UIColor = isSelected ? .label : .systemGray3
        let font = UIFont.systemFont(ofSize: 13, weight: fontWeight)
        label.textColor = textColor
        label.font = font
    }
}


//MARK: - ViewController protocol extension
extension CommandReadingModeAppearanceViewController: CommandReadingModeAppearanceViewControllerProtocol {
    
    //MARK: Internal
    internal func setupMainUI() {
        setupView()
        setupFontSizeSlider()
        setupBrightnessProgressView()
        setupSliderDecorationBarViews()
        setupContentAppearanceToolBarView()
    }
    
    internal func updateArtcileThemeButtons(selectedIndex: Int) {
        for button in changeArtcileThemeButtons {
            let font = Constants.UI.Button.FontThemeButton.serifFont
            switch button.tag {
            case 0:
                setupFastAppearanceButton(for: button,
                                          isSelected: false,
                                          backgroundColor: Constants.UI.Button.ColorThemeButton.White.backgroundColor,
                                          foregroundColor: Constants.UI.Button.ColorThemeButton.White.foregroundColor,
                                          selectedForegroundColor: Constants.UI.Button.ColorThemeButton.White.selectedForegroundColor,
                                          strokeColor: Constants.UI.Button.ColorThemeButton.White.strokeColor,
                                          font: font)
            case 1:
                setupFastAppearanceButton(for: button,
                                          isSelected: false,
                                          backgroundColor: Constants.UI.Button.ColorThemeButton.Eggshell.backgroundColor,
                                          foregroundColor: Constants.UI.Button.ColorThemeButton.Eggshell.foregroundColor,
                                          selectedForegroundColor: Constants.UI.Button.ColorThemeButton.Eggshell.selectedForegroundColor,
                                          strokeColor: Constants.UI.Button.ColorThemeButton.Eggshell.strokeColor,
                                          font: font)
            case 2:
                setupFastAppearanceButton(for: button,
                                          isSelected: false,
                                          backgroundColor: Constants.UI.Button.ColorThemeButton.Nightowl.backgroundColor,
                                          foregroundColor: Constants.UI.Button.ColorThemeButton.Nightowl.foregroundColor,
                                          selectedForegroundColor: Constants.UI.Button.ColorThemeButton.Nightowl.selectedForegroundColor,
                                          strokeColor: Constants.UI.Button.ColorThemeButton.Nightowl.strokeColor,
                                          font: font)
            default: break
            }
            
            if button.tag == selectedIndex {
                switch selectedIndex {
                case 0:
                    setupFastAppearanceButton(for: button,
                                              isSelected: true,
                                              backgroundColor: Constants.UI.Button.ColorThemeButton.White.backgroundColor,
                                              foregroundColor: Constants.UI.Button.ColorThemeButton.White.foregroundColor,
                                              selectedForegroundColor: Constants.UI.Button.ColorThemeButton.White.selectedForegroundColor,
                                              strokeColor: Constants.UI.Button.ColorThemeButton.White.strokeColor,
                                              font: font)
                case 1:
                    setupFastAppearanceButton(for: button,
                                              isSelected: true,
                                              backgroundColor: Constants.UI.Button.ColorThemeButton.Eggshell.backgroundColor,
                                              foregroundColor: Constants.UI.Button.ColorThemeButton.Eggshell.foregroundColor,
                                              selectedForegroundColor: Constants.UI.Button.ColorThemeButton.Eggshell.selectedForegroundColor,
                                              strokeColor: Constants.UI.Button.ColorThemeButton.Eggshell.strokeColor,
                                              font: font)
                case 2:
                    setupFastAppearanceButton(for: button,
                                              isSelected: true,
                                              backgroundColor: Constants.UI.Button.ColorThemeButton.Nightowl.backgroundColor,
                                              foregroundColor: Constants.UI.Button.ColorThemeButton.Nightowl.foregroundColor,
                                              selectedForegroundColor: Constants.UI.Button.ColorThemeButton.Nightowl.selectedForegroundColor,
                                              strokeColor: Constants.UI.Button.ColorThemeButton.Nightowl.strokeColor,
                                              font: font)
                default: break
                }
            }
        }
    }
    
    internal func updateContentFontButtons(selectedIndex: Int) {
        for button in changeContentFontButtons {
            let backgroundColor = Constants.UI.Button.FontThemeButton.backgroundColor
            let foregroundColor = Constants.UI.Button.FontThemeButton.foregroundColor
            let selectedForegroundColor = Constants.UI.Button.FontThemeButton.selectedForegroundColor
            switch button.tag {
            case 0:
                setupFastAppearanceButton(for: button,
                                          isSelected: false,
                                          backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          selectedForegroundColor: selectedForegroundColor,
                                          strokeColor: foregroundColor,
                                          font: Constants.UI.Button.FontThemeButton.classicFont)
            case 1:
                setupFastAppearanceButton(for: button,
                                          isSelected: false,
                                          backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          selectedForegroundColor: selectedForegroundColor,
                                          strokeColor: foregroundColor,
                                          font: Constants.UI.Button.FontThemeButton.serifFont)
            case 2:
                setupFastAppearanceButton(for: button,
                                          isSelected: false,
                                          backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          selectedForegroundColor: selectedForegroundColor,
                                          strokeColor: foregroundColor,
                                          font: Constants.UI.Button.FontThemeButton.timesFont)
            default: break
            }
            
            if button.tag == selectedIndex {
                switch selectedIndex {
                case 0:
                    setupFastAppearanceButton(for: button,
                                              isSelected: true,
                                              backgroundColor: backgroundColor,
                                              foregroundColor: foregroundColor,
                                              selectedForegroundColor: selectedForegroundColor,
                                              strokeColor: foregroundColor,
                                              font: Constants.UI.Button.FontThemeButton.classicFont)
                case 1:
                    setupFastAppearanceButton(for: button,
                                              isSelected: true,
                                              backgroundColor: backgroundColor,
                                              foregroundColor: foregroundColor,
                                              selectedForegroundColor: selectedForegroundColor,
                                              strokeColor: foregroundColor,
                                              font: Constants.UI.Button.FontThemeButton.serifFont)
                case 2:
                    setupFastAppearanceButton(for: button,
                                              isSelected: true,
                                              backgroundColor: backgroundColor,
                                              foregroundColor: foregroundColor,
                                              selectedForegroundColor: selectedForegroundColor,
                                              strokeColor: foregroundColor,
                                              font: Constants.UI.Button.FontThemeButton.timesFont)
                default: break
                }
            }
        }
    }
    
    internal func updateArtcileThemeNameLabels(selectedIndex: Int) {
        for label in articleThemeNamesLabels {
            let isSelected = selectedIndex == label.tag
            setupFastNameLabel(for: label, isSelected: isSelected)
        }
    }
    
    internal func updateContentFontNameLabels(selectedIndex: Int) {
        for label in contentFontNamesLabels {
            let isSelected = selectedIndex == label.tag
            setupFastNameLabel(for: label, isSelected: isSelected)
        }
    }
    
    internal func updateSliderValue(_ contentFontSize: Float) {
        fontSizeSlider.value = contentFontSize
    }
}
