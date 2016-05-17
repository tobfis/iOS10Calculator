//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Tobias Fischer on 04/05/16.
//  Copyright © 2016 Tobias Fischer. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0

    private var isPartialResult = true
    
    var description = ""
    
    func setOperand(operand: Double)
    {
        accumulator = operand
    }
    
    private var operations :Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals,
        "tan" : Operation.UnaryOperation(tan),
        "sin" : Operation.UnaryOperation(sin),
        "x²" : Operation.UnaryOperation({$0 * $0}),
        "x^-1" : Operation.UnaryOperation({1/$0})
    ]
    
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String)
    {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                description = description + symbol
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
                description = description + symbol
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                description = description + symbol
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    private func executePendingBinaryOperation() {
        if (pending != nil)
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    private var pending: PendingBinaryOperationInfo?
    
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    var result: Double
        {
        get
        {
            return accumulator
        }
    }
    
}