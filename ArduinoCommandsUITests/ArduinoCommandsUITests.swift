//
//  ArduinoCommandsUITests.swift
//  ArduinoCommandsUITests
//
//  Created by Yaroslav on 08.02.2022.
//

import XCTest

class ArduinoCommandsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["L i s t"].tap()
        app.tables.cells.containing(.staticText, identifier:"SETUP()").staticTexts["THE MAIN OPERATORS"].tap()
        
        app.navigationBars["ArduinoCommands.CommandDetailView"]/*@START_MENU_TOKEN@*/.buttons["Basics"]/*[[".segmentedControls.buttons[\"Basics\"]",".buttons[\"Basics\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let arduinocommandsCommanddetailviewNavigationBar = app.navigationBars["ArduinoCommands.CommandDetailView"]
        arduinocommandsCommanddetailviewNavigationBar.children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()
        app.otherElements.containing(.staticText, identifier:"Copied").children(matching: .other).element(boundBy: 1).tap()
        arduinocommandsCommanddetailviewNavigationBar.children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app/*@START_MENU_TOKEN@*/.navigationBars["UIActivityContentView"]/*[[".otherElements[\"ActivityListView\"].navigationBars[\"UIActivityContentView\"]",".navigationBars[\"UIActivityContentView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Close"].tap()
                
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
