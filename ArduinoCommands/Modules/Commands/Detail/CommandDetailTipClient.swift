//
//  CommandDetailTipClient.swift
//  ArduinoCommands
//
//  Created by User on 2023-10-24.
//

import Foundation

//MARK: - Tip Client protocol
protocol CommandDetailTipClientProtocol {
    var isCircuitTipAvailable: Bool { get }
    var isReadingModeTipAvailable: Bool { get }
    func markCircuitTipAsComplete()
    func markReadingModeTipAsComplete()
}


//MARK: - Main Tip Client
final class CommandDetailTipClient: ACTipsManager, CommandDetailTipClientProtocol {
    
    
    //MARK: Internal
    var isReadingModeTipAvailable: Bool {
        checkTipAvailability(for: .readingMode)
    }
    
    var isCircuitTipAvailable: Bool {
        checkTipAvailability(for: .circuit)
    }
    
    func markCircuitTipAsComplete() {
        markTipAsComplete(.circuit)
    }
    
    func markReadingModeTipAsComplete() {
        markTipAsComplete(.readingMode)
    }
}
