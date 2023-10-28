//
//  BasicKnowledgeTipClient.swift
//  ArduinoCommands
//
//  Created by User on 2023-10-24.
//

import Foundation

//MARK: - Tip Client protocol
protocol BasicKnowledgeTipClientProtocol {
    var isSettingsTipAvailable: Bool { get }
    func markSettingsTipAsComplete()
}


//MARK: - Main Tip Client
final class BasicKnowledgeTipClient: ACTipsManager, BasicKnowledgeTipClientProtocol {
    
    //MARK: Internal
    var isSettingsTipAvailable: Bool {
        checkTipAvailability(for: .settings)
    }
    
    func markSettingsTipAsComplete() {
        markTipAsComplete(.settings)
    }
}
