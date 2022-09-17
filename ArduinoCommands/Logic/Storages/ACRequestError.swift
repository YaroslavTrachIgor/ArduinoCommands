//
//  ACRequestError.swift
//  ArduinoCommands
//
//  Created by User on 26.07.2022.
//

import Foundation

//MARK: - API Requests Errors list
public enum ACRequestError: String, Error {
    case invalidURLError = "The URL is invalid."
    case sessionError = "Session task error. Check your Wifi-Connection."
    case invalidDataError = "Model Data equals to nil. You need to check JSON model structure integrity."
    case unknownApplicationAPIGetError = "Unknown Application API Get request error. Please, try again."
}
