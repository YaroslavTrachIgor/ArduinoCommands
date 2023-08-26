//
//  CommandReadingModeContentAppearancePresenter.swift
//  ArduinoCommands
//
//  Created by User on 2023-08-07.
//

import Foundation
import UIKit

//MARK: - Manager Injector protocol
protocol CommandReadingModeAppearanceManagerInjector {
    var appearanceManager: CommandReadingModeAppearanceManager { get }
}


//MARK: - Main Manager instance
fileprivate let sharedCommandReadingModeAppearanceManager: CommandReadingModeAppearanceManager = CommandReadingModeAppearanceManager.shared


//MARK: - Manager Injector protocol extension
extension CommandReadingModeAppearanceManagerInjector {
    
    //MARK: Internal
    var appearanceManager: CommandReadingModeAppearanceManager {
        return sharedCommandReadingModeAppearanceManager
    }
}


final class CommandReadingModeAppearanceManager {
    
    static let shared = CommandReadingModeAppearanceManager()
    
    private init() {}
    
    var fontThemeIndex: Int = 0
    var colorThemeIndex: Int = 0
    
    
    func updateContentFontThemeIndex(_ selectedIndex: Int) {
        fontThemeIndex = selectedIndex
    }
    
    func updateAppearanceThemeIndex(_ selectedIndex: Int) {
        colorThemeIndex = selectedIndex
    }
    
    func getColorTheme() -> ReadingModeColorTheme! {
        switch   colorThemeIndex {
        case 0:  return WhiteColorTheme()
        case 1:  return EggshellColorTheme()
        case 2:  return NightowlColorTheme()
        default: return nil
        }
    }
    
    func getFontTheme() -> ReadingModeFontTheme! {
        switch   fontThemeIndex {
        case 0:  return ClassicFontTheme()
        case 1:  return SerifFontTheme()
        case 2:  return TimesFontTheme()
        default: return nil
        }
    }
}


public protocol ReadingModeColorTheme {
    var secondaryBackgroundColor: UIColor? { get set }
    var previewBackgroundColor: UIColor? { get set }
    var foregroundColor: UIColor? { get set }
    var secondaryForegroundColor: UIColor? { get set }
    var backgroundColor: UIColor? { get set }
}

public protocol ReadingModeFontTheme {
    var titleFont: UIFont? { get set }
    var subtitleFont: UIFont? { get set }
    var descriptionFont: UIFont? { get set }
    var subheadlineFont: UIFont? { get set }
    func contentFont(ofSize: CGFloat) -> UIFont?
}


final class CommandReadingModeThemeManager: ObservableObject {
    
    @Published var colorTheme: ReadingModeColorTheme = WhiteColorTheme()
    @Published var fontTheme: ReadingModeFontTheme = ClassicFontTheme()
    @Published var fontSize: CGFloat = 17
    
    var backgroundColor: UIColor! { colorTheme.backgroundColor }
    var foregroundColor: UIColor! { colorTheme.foregroundColor }
    var previewBackgroundColor: UIColor! { colorTheme.previewBackgroundColor }
    var secondaryBackgroundColor: UIColor! { colorTheme.secondaryBackgroundColor }
    var secondaryForegroundColor: UIColor! { colorTheme.secondaryForegroundColor }
    
    var titleFont: UIFont! { fontTheme.titleFont }
    var subtitleFont: UIFont! { fontTheme.subtitleFont }
    var subheadlineFont: UIFont! { fontTheme.subheadlineFont }
    var descriptionFont: UIFont! { fontTheme.descriptionFont }
    func contentFont(ofSize: CGFloat) -> UIFont? { fontTheme.contentFont(ofSize: ofSize) }
}






final class WhiteColorTheme: ReadingModeColorTheme {
    var backgroundColor: UIColor? = .systemBackground
    var foregroundColor: UIColor? = .label
    var secondaryForegroundColor: UIColor? = .secondaryLabel
    var previewBackgroundColor: UIColor? = .secondarySystemGroupedBackground
    var secondaryBackgroundColor: UIColor? = .secondarySystemBackground
}

final class EggshellColorTheme: ReadingModeColorTheme {
    var backgroundColor: UIColor? = UIColor(hexString: "#faf7ed", alpha: 1)
    var foregroundColor: UIColor? = UIColor(hexString: "#5e472b", alpha: 1)
    var secondaryForegroundColor: UIColor? = UIColor(hexString: "#5e472b", alpha: 0.8)
    var previewBackgroundColor: UIColor? = UIColor(hexString: "#faf7ed", alpha: 1)
    var secondaryBackgroundColor: UIColor? = UIColor(hexString: "#f5f2e9", alpha: 1)
}

final class NightowlColorTheme: ReadingModeColorTheme {
    var backgroundColor: UIColor? = UIColor(hexString: "#0c0f21", alpha: 1)
    var foregroundColor: UIColor? = .white
    var secondaryForegroundColor: UIColor? = .white.withAlphaComponent(0.6)
    var previewBackgroundColor: UIColor? = UIColor(hexString: "#0c0f21", alpha: 1)
    var secondaryBackgroundColor: UIColor? = UIColor(hexString: "#06091a", alpha: 1)
}





final class ClassicFontTheme: ReadingModeFontTheme {
    var titleFont: UIFont? = UIFont.systemFont(ofSize: 30, weight: .bold)
    var subtitleFont: UIFont? = UIFont.systemFont(ofSize: 14, weight: .semibold)
    var descriptionFont: UIFont? = UIFont.systemFont(ofSize: 15, weight: .regular)
    var subheadlineFont: UIFont? = UIFont.systemFont(ofSize: 16, weight: .semibold)
    func contentFont(ofSize: CGFloat) -> UIFont? { UIFont.systemFont(ofSize: ofSize, weight: .regular) }
}

final class SerifFontTheme: ReadingModeFontTheme {
    var titleFont: UIFont? = UIFont.ACFont(ofSize: 26, weight: .bold)
    var subtitleFont: UIFont? = UIFont.ACFont(ofSize: 14, weight: .bold)
    var descriptionFont: UIFont? = UIFont.ACFont(ofSize: 15, weight: .regular)
    var subheadlineFont: UIFont? = UIFont.ACFont(ofSize: 16, weight: .bold)
    func contentFont(ofSize: CGFloat) -> UIFont? { UIFont.ACFont(ofSize: ofSize, weight: .regular) }
}

final class TimesFontTheme: ReadingModeFontTheme {
    var titleFont: UIFont? = UIFont.ACReadingFont(ofSize: 28, weight: .bold)
    var subtitleFont: UIFont? = UIFont.ACReadingFont(ofSize: 14, weight: .bold)
    var descriptionFont: UIFont? = UIFont.ACReadingFont(ofSize: 15, weight: .regular)
    var subheadlineFont: UIFont? = UIFont.ACReadingFont(ofSize: 16, weight: .bold)
    func contentFont(ofSize: CGFloat) -> UIFont? { UIFont.ACReadingFont(ofSize: ofSize, weight: .regular) }
}



