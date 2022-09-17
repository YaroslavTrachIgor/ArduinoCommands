//
//  ACBaseConfigurableView.swift
//  ArduinoCommands
//
//  Created by User on 18.07.2022.
//

import Foundation

//MARK: - Base configurable View protocol
/**
 To give an opportunity to configure UI elements directly in `UITableViewCell` or `UICollectionViewCell`
 we create a special protocol that has function with associated type
 that will play a role of a special `UIModel` in a particular cell.
 
 In `cellForRowAt` method we call the `configure` function,
 by doing this we unload the controller and respect SOLID principles.
 */
public protocol ACBaseConfigurableView {
    associatedtype DataType
    
    func configure(with data: Self.DataType)
}


/**
 To give an opportunity to configure UI elements repeated logic quickly,
 we create special protocols which will describe these basic logic of this views.
 
 The majority of these UI elements will be `UITableViewCells` or `UICollectionViewCells`.
 */
public protocol ACBaseWithShareView {
    func presentActivityVC(activityItems: [Any])
}

public protocol ACBaseCancelableView {
    func moveToThePreviousViewController()
}


/**
 In the code below, after we created the main basic Views protocols,
 we can setup the other special protocols which will play a role of other Views.
 
 The majority of protocols below are inherited from the `ACBaseWithShareView` protocol
 or `ACBaseCancelableView`protocols and contain their basaic logic(for instance: fast ActivityVC presentation).
 */
public protocol ACBaseUserSheetCellProtocol: ACBaseWithShareView, ACBaseCancelableView, AnyObject {}
