//
//  ACBasePresenterProtocol.swift
//  ArduinoCommands
//
//  Created by User on 18.07.2022.
//

import Foundation

//MARK: - Base Presenter protocol
/**
 In the code below, we create a special protocl, that will play a role of a simple Presenter
 and, of course, it describes logic, that every Presenter in this application contains.
 
 First of all, we need `ACBasePresenter` to use it in Tests,
 that is in files where we don't need to use all special `UIKit` logic.
 */
protocol ACBasePresenter: AnyObject {
    func onViewDidLoad()
}
