//
//  ViewController.swift
//  Calculator
//
//  Created by Tobias Fischer on 04/05/16.
//  Copyright © 2016 Tobias Fischer. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet private weak var display: UILabel!
    @IBOutlet weak var sequenceOfOperands: UILabel!

    
    private var userIsInTheMiddleOfTyping = false
    
    
    @IBAction func clear(sender: UIButton) {
        sequenceOfOperands.text = " "
        display.text = "0"
        brain.description = ""
    }
    
    
    @IBAction private func touchDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            
            let textCurrentlyInDisplay = display.text!
            if (digit == ".")
            {
                if (textCurrentlyInDisplay.rangeOfString(".") != nil)
                {
                    return
                }
            }
            
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true;
    }
    
    private var displayValue: Double
        {
        get
        {
            return Double(display.text!)!
        }
        
        set
        {
            display.text = String(newValue)
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton)
    {
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            
        }
        if let mathematicalSymbol = sender.currentTitle
        {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

