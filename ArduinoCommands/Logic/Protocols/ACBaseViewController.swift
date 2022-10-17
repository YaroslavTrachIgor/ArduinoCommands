//
//  BaseViewController.swift
//  ArduinoCommands
//
//  Created by Yaroslav Trach on 31.05.2022.
//

import Foundation

//MARK: Public
public typealias ACBaseCompletionHandler = (() -> Void)


//MARK: - Base ViewController protocol
/**
 In the code below, we create a special protocl, that will play a role of a simple VC
 and, of course, it describes logic, that every VC in this application contains.
 
 First of all, we need `ACBaseViewController` to use it in Tests and Presenters,
 that is in files where we don't have an opportinity to use `UIKit`.
 */
public protocol ACBaseViewController: AnyObject {
    func setupMainUI()
}

public protocol ACBaseWithShareViewController: ACBaseWithShareView, ACBaseViewController {}

public protocol ACBaseDetailViewController: ACBaseWithShareView, ACBaseCancelableView, ACBaseViewController {}
