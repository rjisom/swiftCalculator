//
//  ViewController.swift
//  Calculator
//
//  Created by Richard isom on 9/2/16.
//  Copyright © 2016 edu.csumb.cst495.isom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var decimalIsPressed = false
    let piValue = M_PI
    
    @IBAction func decimal() {
        userIsInTheMiddleOfTypingANumber = true
        if decimalIsPressed == false {
            display.text = display.text! + "."
            decimalIsPressed = true
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
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            //case "clr": performOperation1 {  }
            case "×": performOperation { $0 * $1 }
            case "÷": performOperation { $1 / $0 }
            case "+": performOperation { $0 + $1 }
            case "−": performOperation { $0 - $1 }
            case "sin": performOperation1 { sin($0) }
            case "cos": performOperation1 { cos($0) }
            case "√": performOperation1 { sqrt($0) }
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation1(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    // Stack operations as buttons are pressed
    var operandStack = Array<Double>()
    var operationStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        decimalIsPressed = false
        operandStack.append(displayValue)
        history.text = "\(displayValue)"
        print("operandStack = \(operandStack)")
    }
    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.removeAll()
        enter()
        display.text = "0"
    }
    
    @IBAction func pi() {
        userIsInTheMiddleOfTypingANumber = true
        if display.text != "0" {
            enter()
            display.text = "\(piValue)"
            enter()
        } else {
            display.text = "\(piValue)"
            enter()
        }
    }
    
    var displayValue: Double {
        
        get {
            if(NSNumberFormatter().numberFromString(display.text!) != nil){
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            }
            return 0
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

