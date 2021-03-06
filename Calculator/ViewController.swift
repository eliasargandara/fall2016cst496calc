//
//  ViewController.swift
//  Calculator
//
//  Created by Eliasar Gandara on 9/2/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var opHistoryDisplay: UILabel!
    let π = M_PI
    
    // Flags for working with user's input
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var isDecimalAlreadyInNumber: Bool = false
    
    var brain = CalculatorBrain()

    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                opHistoryDisplay.text = brain.getOpHistoryRepresentation()
            }
            else {
                displayValue = nil
            }
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func appendPIValue() {
        if userIsInTheMiddleOfTypingANumber {
            enter();
        }
        display.text = String(π)
        isDecimalAlreadyInNumber = true;
    }
    
    @IBAction func appendDecimal() {
        if !isDecimalAlreadyInNumber {
            display.text = (display.text!) + "."
            isDecimalAlreadyInNumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        isDecimalAlreadyInNumber = false
        if displayValue != nil {
            if let result = brain.pushOperand(displayValue!) {
                displayValue = result
            }
            else {
                displayValue = nil
            }
        }
    }
    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        isDecimalAlreadyInNumber = false
        display.text = ""
        opHistoryDisplay.text = ""
        
        brain.reset()
    }
    
    @IBAction func setMVariable() {
        if displayValue != nil {
            brain.variableValues["M"] = displayValue!
        }
        
        userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func pressMVariable() {
        if let result = brain.pushOperand("M") {
            displayValue = result
        }
        else {
            displayValue = nil
        }
    }
    
    var displayValue: Double? {
        get {
            // Set text to a valid value if the display text is not a valid value
            if display.text != nil {
                let decimal = Double(display.text!)
                if decimal != nil {
                    //let value = NSNumberFormatter().numberFromString(display.text!)!
                    //return value.doubleValue
                    return decimal!
                }
                else {
                    return nil
                }
            }
            else {
                return nil
            }
        }
        set {
            userIsInTheMiddleOfTypingANumber = false
            if newValue != nil {
                display.text = "\(newValue!)"
            }
            else {
                display.text = ""
            }
        }
    }
}