//
//  ArduinoCommandsTests.swift
//  ArduinoCommandsTests
//
//  Created by Yaroslav on 08.02.2022.
//

import XCTest
@testable import ArduinoCommands
//
////MARK: - Commands list section main Test Case
//final class ArduinoCommandsTests: XCTestCase {
//
//    //MARK: Private
//    private var commandsList = [CommandsSection]()
//    private var presenter: CommandsListPresenterProtocol!
//    private var view: ACBaseViewController!
//
//
//    //MARK: Lifecycle
//    override func setUpWithError() throws {
//        view = MockedViewController()
//        presenter = MockedPresenter(view: view)
//    }
//
//    override func tearDownWithError() throws {
//        view = nil
//        presenter = nil
//    }
//
//    //MARK: Private
//    private func testOnViewDidLoad() throws {
//        presenter.onViewDidLoad(with: &commandsList)
//        /*
//         In the code below, after we filled our commands list using presenter method
//         We can test that our model properties are right,
//         And everything that happens 'onViewDidLoad'.
//         */
//        let currentCommand = commandsList[0].commands[0]
//        XCTAssertNil(currentCommand.imageURL)
//        XCTAssertEqual(currentCommand.name, "My Command name")
//        XCTAssertFalse(currentCommand.subtitle == "My Command name")
//        XCTAssertTrue(currentCommand.isUsedWithDevices == true)
//    }
//}
