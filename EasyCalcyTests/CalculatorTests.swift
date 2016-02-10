//
//  CalculatorTests.swift
//  EasyCalcy
//
//  Created by Sayali Joshi on 2/1/16.
//  Copyright © 2016 Sayali Joshi. All rights reserved.
//

import XCTest
@testable import EasyCalcy

class CalculatorTests: XCTestCase {

    var calculator : Calculator = Calculator()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddNumbers()
    {
        //Arrange and Act
        let result = calculator.add(-2, operand2: -3)
        let result1 = calculator.add(2, operand2: -3)
        let resultFloat = calculator.add(5.99, operand2: 3.4)
        //Assert
        XCTAssertTrue(result == -5)
        XCTAssertTrue(result1 == -1)
        XCTAssertTrue(resultFloat == 9.39)
    }
    
    
    func testSubtractNumbers()
    {
        //Arrange and Act
        let result = calculator.subtract(-3, operand2: -2)
        let result1 = calculator.subtract(0, operand2: 7)
        let resultFloat = calculator.subtract(8.34, operand2: 2.99)
        
        //Assert
        XCTAssertTrue(result == -1)
        XCTAssertTrue(result1 == -7)
        XCTAssertTrue(resultFloat == 5.35)
    }
    
    func testMultiplyNumbers()
    {
        //Arrange and Act
        let result = calculator.multiply(-5, operand2: -7)
        let result1 = calculator.multiply(0, operand2: 7)
        var resultFloat = calculator.multiply(-4.35, operand2: 6.888)
        resultFloat = (resultFloat * 10000)/10000
        
        //Assert
        XCTAssertTrue(result == 35)
        XCTAssertTrue(result1 == 0)
        XCTAssertTrue(resultFloat == -29.9628)
    }
    
    func testDivideByZero()
    {
        do
        {
            try calculator.divide(4, operand2: 0)
        }
        catch let e as CalculatorErros
        {
            XCTAssertEqual(e, CalculatorErros.DivideByZero)
        }
        catch
        {
            XCTFail("Wrong Exception")
        }
    }
    
    func testDivide()
    {
        do
        {
          let result =  try calculator.divide(9, operand2: 3)
          XCTAssertTrue(result == 3)
        }
        catch
        {
            XCTFail("Wrong Exception")
        }
        
        
    }
    
    func testDoCalculation()
    {
        //Arrange
        calculator.operands.append("4")
        calculator.operands.append("8")
        calculator.operators.append("+")
        
        //Act
        calculator.doCalculation()
        
        //Assert
        XCTAssertTrue(calculator.displayValue == 12)
    }
    
    func testPerformOperation()
    {
        //Arrange
        calculator.operands.append("9")
        calculator.operands.append("5")
        calculator.operators.append("x")
        
        //Act
        calculator.performOperation("-")
        
        //Assert
        XCTAssertTrue(calculator.displayValue == 45)
        
    }
    
    func testResetAll()
    {
        //Arrange and act
        calculator.resetAll()
        
        //Assert
        XCTAssertTrue(calculator.operators.count == 0)
        XCTAssertTrue(calculator.operands.count == 0)
        XCTAssertTrue(calculator.currentOperand == "")
        XCTAssertTrue(calculator.isFloat == false)
        XCTAssertTrue(calculator.currentOperator == "")
        XCTAssertTrue(calculator.displayValue == 0)
    }
    
    func testDigitEntered()
    {
        //Arrange
        calculator.currentOperand = "55"
        calculator.currentOperator = ""
        
        //Act
        calculator.digitEntered("9")
        
        //Assert
        XCTAssertTrue(calculator.displayValue == 559)
    }
    
    func testOperatorEnteredWhenOperandEmpty()
    {
        //Arrange
        calculator.currentOperand = "40"
        
        
        //Act
        calculator.operatorEntered("+")
        
        //Assert
        XCTAssertTrue(calculator.operands.count == 1 )
        
    }
    
    func testOperatorEnteredOperandNotEmpty()
    {
        //Arrange
        calculator.operands.append("25")
        calculator.operands.append("10")
        calculator.operators.append("-")
        
        //Act
        calculator.operatorEntered("=")
        
        //Assert
        XCTAssertTrue(calculator.displayValue == 15)
        
    }
    
    func testOperationsSequence()
    {
        //Arrange and Act
        calculator.digitEntered("3")
        calculator.operatorEntered("+")
        calculator.digitEntered("5")
        calculator.operatorEntered("x")
        calculator.digitEntered("3.5")
        calculator.operatorEntered("+")
        calculator.digitEntered("6")
        calculator.operatorEntered("-")
        calculator.digitEntered("2")
        calculator.operatorEntered("=")
        
        //Assert
        XCTAssertTrue(calculator.displayValue == 24.5)
        
    }
    
    func testOperationSequenceWithDivZero()
    {
        //Arrange and Act
        calculator.digitEntered("15")
        calculator.operatorEntered("-")
        calculator.digitEntered("8")
        calculator.operatorEntered("/")
        calculator.digitEntered("0")
        calculator.operatorEntered("+")
        
        //Assert
        XCTAssertTrue(calculator.resultLabel.text == "Error")
        
        calculator.digitEntered("6")
        calculator.operatorEntered("x")
        calculator.digitEntered("9")
        calculator.operatorEntered("=")
        
        //Assert
        XCTAssertTrue(calculator.displayValue == 54)
    }
    
    func testMultipleFloatPointEntry()
    {
        //Arrange
        calculator.dotEntered(".")
        calculator.digitEntered("2")
        calculator.dotEntered(".")
        calculator.digitEntered("5")
        
        //Assert
        XCTAssertTrue(calculator.resultLabel.text == " 0.25")
    }
    
    func testMultipleEqualToOperatorEntry()
    {
        //Arrange and Act
        calculator.digitEntered("34")
        calculator.operatorEntered("+")
        calculator.digitEntered("6")
        calculator.operatorEntered("=")
        
        //Assert
        XCTAssert(calculator.resultLabel.text == " 40.0")
        
        calculator.operatorEntered("=")
        XCTAssert(calculator.resultLabel.text == " 40.0")
        
        calculator.operatorEntered("x")
        calculator.digitEntered("6")
        calculator.operatorEntered("=")
        XCTAssert(calculator.resultLabel.text == " 240.0")
        
    }
    
    func testDigitAfterEqualtoOperator()
    {
        //Arrange 
        calculator.digitEntered("144")
        calculator.operatorEntered("+")
        calculator.digitEntered("62")
        
        //Act
        calculator.operatorEntered("=")
        
        //Assert
        XCTAssert(calculator.resultLabel.text == " 206.0")
        
        //Arrange
        calculator.digitEntered("248")
        calculator.operatorEntered("/")
        calculator.digitEntered("4")
        
        //Act
        calculator.operatorEntered("=")
        
        //Assert
        XCTAssert(calculator.resultLabel.text == " 62.0")
    }
    
    
}
