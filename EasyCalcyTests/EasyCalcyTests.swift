//
//  EasyCalcyTests.swift
//  EasyCalcyTests
//
//  Copyright © 2016 Sayali. All rights reserved.
//

import XCTest
@testable import EasyCalcy

class EasyCalcyTests: XCTestCase
{
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        

    }
    
    func testPerformanceExample()
    {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSimpleAddition()
    {
            //Arrange
            let controller =  Calculator()
            controller.resultLabel = UILabel()
            controller.displayValue = 0.0
            controller.operators.append("-")
            controller.operators.append("+")
            controller.operands.append("5")
            controller.operands.append("5");
            //Act
            controller.doCalculation()
            //Assert
            XCTAssertTrue(controller.displayValue == 10.0)
    }
        
}
