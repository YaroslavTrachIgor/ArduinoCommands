//
//  TipsManager.swift
//  ArduinoCommands
//
//  Created by User on 2023-10-24.
//

import Foundation

//MARK: - Tip Type
enum ACTipType {
    case settings
    case readingMode
    case analytics
    case circuit
}


//MARK: - Tips Manager protocol
protocol ACTipsManagerProtocol {
    func checkTipAvailability(for tipType: ACTipType) -> Bool
    func markTipAsComplete(_ tipType: ACTipType)
}


//MARK: - Main Tips Manager
class ACTipsManager {
    
    //MARK: Private
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.Tips.isSettingsTipNeeded)
    private var isSettingsTipNeeded = true
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.Tips.isReadingModeTipNeeded)
    private var isReadingModeTipNeeded = true
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.Tips.isAnalyticsTipNeeded)
    private var isAnalyticsTipNeeded = true
    @ACBaseUserDefaults<Bool>(key: UserDefaults.Keys.Tips.isCircuitTipAvailable)
    private var isCircuitTipAvailable = true
}


//MARK: - Tips Manager protocol extension
extension ACTipsManager: ACTipsManagerProtocol {
    
    //MARK: Protocol methods
    func checkTipAvailability(for tipType: ACTipType) -> Bool {
        switch tipType {
        case .settings:     isSettingsTipNeeded
        case .readingMode:  isReadingModeTipNeeded
        case .analytics:    isAnalyticsTipNeeded
        case .circuit:      isCircuitTipAvailable
        }
    }
    
    func markTipAsComplete(_ tipType: ACTipType) {
        switch tipType {
        case .settings:     isSettingsTipNeeded      = false
        case .readingMode:  isReadingModeTipNeeded   = false
        case .analytics:    isAnalyticsTipNeeded     = false
        case .circuit:      isCircuitTipAvailable    = false
        }
    }
}
