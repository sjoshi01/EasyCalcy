
let app = XCUIApplication()

//
//  EasyCalcyUITests.swift
//  EasyCalcyUITests
//
//  Created by Sayali Joshi on 2/1/16.
//  Copyright © 2016 Sayali. All rights reserved.
//

import XCTest

class EasyCalcyUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSequenceOfOperation()
    {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.buttons["3"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["x"].tap()
        app.buttons["9"].tap()
        app.buttons["-"].tap()
        app.buttons["4"].tap()
        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        XCTAssert(app.staticTexts[" 55.0"].exists)
    }
    
    func testDivideByZero()
    {
        let app = XCUIApplication()
        app.buttons["5"].tap()
        app.buttons["/"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        XCTAssert(app.staticTexts["Error"].exists)
        
    }
    
    func testSequenceWithNegation()
    {
        
        let app = XCUIApplication()
        app.buttons["8"].tap()
        
        let button = app.buttons["+"]
        button.tap()
        app.buttons["5"].tap()
        app.buttons["+/-"].tap()
        app.buttons["-"].tap()
        app.buttons["6"].tap()
        button.tap()
        
        let button2 = app.buttons["7"]
        button2.tap()
        app.buttons["x"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        button2.tap()
        app.buttons["="].tap()
        XCTAssert(app.staticTexts[" -1.0"].exists)
    }
    
    func testFloatingPointSequence()
    {
        let app = XCUIApplication()
        let button = app.buttons["."]
        button.tap()
        
        let button2 = app.buttons["4"]
        button2.tap()
        app.buttons["8"].tap()
        
        let button3 = app.buttons["+"]
        button3.tap()
        
        let button4 = app.buttons["2"]
        button4.tap()
        button.tap()
        app.buttons["9"].tap()
        app.buttons["x"].tap()
        button2.tap()
        app.buttons["-"].tap()
        XCTAssert(app.staticTexts[" 12.08"].exists)
        
        app.buttons["3"].tap()
        app.buttons["/"].tap()
        button4.tap()
        
        let button5 = app.buttons["="]
        button5.tap()
        XCTAssert(app.staticTexts[" 10.58"].exists)
        app.buttons["+/-"].tap()
        XCTAssert(app.staticTexts[" -10.58"].exists)
        button3.tap()
        app.buttons["5"].tap()
        button5.tap()
        XCTAssert(app.staticTexts[" -5.58"].exists)
    }
    
    func testPercentSequence()
    {
        
        
        
    }
    
    
}
