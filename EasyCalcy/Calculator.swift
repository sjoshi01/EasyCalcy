//
//  Calculator.swift
//  EasyCalcy
//
//  Created by Sayali Joshi on 2/2/16.
//  Copyright © 2016 Sayali. All rights reserved.
//

import Foundation
import UIKit

class Calculator
{
    var operatorPriority : [String: Int] = ["+": 1, "-": 1, "x": 2, "/": 2, "=": 3]
    var currentOperand : String = ""
    var currentOperator : String = ""
    var operands = [String]()
    var operators = [String]()
    var resultLabel : UILabel = UILabel()
    var historyLabel : UILabel = UILabel()
    var isFloat: Bool = false

    var displayValue: Double {
        get {
            
            return NSNumberFormatter().numberFromString(self.resultLabel.text!)!.doubleValue
        }
        set {
            
            self.resultLabel.text  = " "+"\(newValue)"
        }
    }
    
    var history: String {
        get {
            
            return self.historyLabel.text!
        }
        set {
            
            self.historyLabel.text  = "\(newValue)"
            
        }
    }
  
    func setLabel(resultField: UILabel, historyLabel: UILabel)
    {
        self.resultLabel = resultField
        self.historyLabel = historyLabel
    }
    
    func resetAll()
    {
        displayValue = 0
        self.operands.removeAll()
        self.operators.removeAll()
        self.currentOperator = ""
        self.currentOperand = ""
        self.history = ""
        isFloat = false
    }
    
    func digitEntered(digit: String)
    {
        currentOperand.appendContentsOf(digit)
        self.pushOperator()
        
        displayValue = Double(self.currentOperand)!
        
    }
    
    func pushOperator()
    {
        if !self.currentOperator.isEmpty
        {
            self.operators.append(self.currentOperator)
            self.currentOperator = ""
            self.isFloat = false
        }
       
    }
    
    func operatorEntered(op: String)
    {
        if !self.currentOperand.isEmpty
        {
            self.operands.append(currentOperand)
        }
        
        if self.operands.count > 0
        {
            currentOperator = op
        }
        
        if self.operators.count >= 1
        {
            self.performOperation(currentOperator)
            
        }
        if op == "%" && self.operands.count > 0
        {
            self.operands.append("100")
            self.operators.append(op)
            doCalculation()
        }

        currentOperand = ""
    }
    
    func performOperation(currentOperator: String)
    {
        let currentPriority = self.operatorPriority[currentOperator]
        let previousPriority = self.operatorPriority[self.operators[operators.count - 1]]
        
        if previousPriority >= currentPriority || currentPriority == 3
        {
            self.doCalculation()
            if self.operators.count != 0 && self.operands.count >= 2
            {
                performOperation(currentOperator); //now recurse
            }
        }
        if self.currentOperator.isEmpty
        {
            self.currentOperator = ""
            if self.operands.count > 0
            {
              self.operands.removeLast()
            }
            self.history = ""
            self.isFloat = false
        }
        
    }
    
    func doCalculation()
    {
        let operand2 = Double(self.operands.removeLast())
        let operand1 = Double(self.operands.removeLast())
        
        let operation = self.operators[operators.count - 1]
        var result:Double = 0
        
        do
        {
            switch operation
            {
                case "+" :   result = add(operand1!, operand2: operand2!)
                             self.operands.append(String(result))
                case "x" :   result = multiply(operand1!, operand2: operand2!)
                             self.operands.append(String(result))
                case "-" :   result = subtract(operand1!, operand2: operand2!)
                             self.operands.append(String(result))
                case "/" :   result = try divide(operand1!, operand2: operand2!)
                             self.operands.append(String(result))
                case "%" :   result = try divide(operand1!, operand2: operand2!)
                             self.operands.append(String(result))
                default: break
            }
            
            if self.operators.count > 0
            {
                self.operators.removeLast()
            }
        }
        catch CalculatorErros.DivideByZero
        {
            self.resetAll()
            self.resultLabel.text = "Error"
            return
        }
        catch
        {
            return
        }
        
        self.displayValue = result
    }
    
    func add(operand1: Double, operand2: Double) ->Double
    {
        return operand1 + operand2
    }
    
    func subtract(operand1: Double, operand2: Double) ->Double
    {
        return operand1 - operand2
    }
    
    func multiply(operand1: Double, operand2: Double) ->Double
    {
        return operand1 * operand2
    }
    
    func divide(operand1: Double, operand2: Double) throws ->Double
    {
        if operand2 == 0
        {
            throw CalculatorErros.DivideByZero
        }
        return operand1 / operand2
    }
    
    func square(operand1: Double) -> Double
    {
        return pow(operand1, 2.0)
    }
    
    func sqrt(operand1: Double) -> Double
    {
        return sqrt(operand1)
    }
    
    func power(operand1: Double, operand2: Double) -> Double
    {
        return pow(operand1,operand2)
    }
    
    func dotEntered(dot: UIButton)
    {
        if !self.isFloat
        {
            if currentOperand.isEmpty
            {
                currentOperand = "0"
            }
            self.digitEntered(".")
        }
        self.isFloat = true

    }
    
    func negationOperator(neg: UIButton)
    {
        if !currentOperand.isEmpty
        {
            currentOperand = String(Double(currentOperand)! * -1 )
            if !isFloat
            {
                self.currentOperand = self.currentOperand.componentsSeparatedByString(".")[0]
            }
            self.displayValue = Double (currentOperand)!
            return
        }
        if currentOperand.isEmpty && self.operands.count > 0
        {
            var negation = self.operands.removeLast()
            negation = String(Double(negation)! * -1 )
            if !negation.containsString(".")
            {
                negation = negation.componentsSeparatedByString(".")[0]
            }
            self.displayValue = Double (negation)!
            self.operands.append(negation)
            return

        }
    }

}

enum CalculatorErros: ErrorType {
    case Empty
    case DivideByZero
}