//
//  ViewController.swift
//  Calculator
//
//  Created by Leonel Gonzalez Vidales on 09/04/15.
//  Copyright (c) 2015 Leonel Gonzalez Vidales. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    var UserIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton)  {
        let digit = sender.currentTitle!
        if UserIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            UserIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        UserIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if UserIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation2 { sqrt($0) }
        default:
            break
            
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation2(operation: Double -> Double){
        if operandStack.count >= 1
        {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            UserIsInTheMiddleOfTypingANumber = false
        }
    }

}

