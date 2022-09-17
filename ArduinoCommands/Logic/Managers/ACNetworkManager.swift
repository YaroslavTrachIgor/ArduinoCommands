//
//  ACNetworkManager.swift
//  ArduinoCommands
//
//  Created by User on 13.07.2022.
//

import Foundation
import Network

//MARK: - Connection Types
public extension ACNetworkManager {
    
    //MARK: Public
    enum ACConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
}


//MARK: - Manager for fast Internet Connection check
final public class ACNetworkManager {
    
    //MARK: Static
    static let shared = ACNetworkManager()
    
    //MARK: Static
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    //MARK: Public
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ACConnectionType?
    
    
    //MARK: Initionalizate
    private init() {
        monitor = NWPathMonitor()
    }
}


//MARK: - Fast methods
public extension ACNetworkManager {
    
    //MARK: Public
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func startMonitoring() {
        /**
         Before we will use `isConnected` property to check users WiFi Connection,
         we will setup Network monitor, and after getting the exact connection Type and connectivity level,
         we will stop monitoring users Connection with `stopMonitoring` method.
         
         Use this function in AppDelegate file.
         */
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.connectionType = .wifi
        }
    }
}
