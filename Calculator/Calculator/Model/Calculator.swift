//
//  Calculator.swift
//  Calculator
//
//  Created by 신동훈 on 2021/06/23.
//

import Foundation

struct Calculator {
    var postfix: [String] = []
    var temporarySignStack = Stack<String>()
    var temporaryNumberStack = Stack<Double>()
    
    mutating func calculate(infix: [String]) throws -> String {
        postfix = []
        let postfix: [String] = try changeToPostfixNotation(infix: infix)
        do {
            let operationResult = try calculatePostfix(postfix: postfix)
            let finalResult: String = try format(number: operationResult)
            return finalResult
        } catch CalculatorError.divisionByZero {
            return CalculatorError.divisionByZero.localizedDescription
        } catch {
            return ""
        }
    }
    //MARK:- 중위연산을 후위연산으로 바꿔주는 부분
    private mutating func changeToPostfixNotation(infix: [String]) throws -> [String] {
        for element in infix {
            if Double(element) != nil {
                postfix.append(element)
            } else {
                try popAndAppend(sign: element)
                temporarySignStack.push(element)
            }
        }
        try popAndAppendLeftovers()
        return postfix
    }
    
    private mutating func popAndAppend(sign: String) throws {
        while let topOfTemporarySignStack = temporarySignStack.top,
              try hasHigherPriority(this: sign, than: topOfTemporarySignStack) == false {
            if let poppedSign = temporarySignStack.pop() {
                postfix.append(poppedSign)
            }
        }
    }
    
    private func hasHigherPriority(this: String, than: String) throws -> Bool {
        let currentOperator: Operator = try Operator.convert(from: this)
        let thanOperator: Operator = try Operator.convert(from: than)
        return currentOperator > thanOperator
    }

    private mutating func popAndAppendLeftovers() throws{
        while temporarySignStack.isEmpty == false {
            if let poppedSign = temporarySignStack.pop() {
                postfix.append(poppedSign)
            }
        }
    }

    //MARK:- 후위연산을 계산해주는 부분
    private mutating func calculatePostfix(postfix: [String]) throws -> Double {
        
        for element in postfix {
            if let number = Double(element) {
                temporaryNumberStack.push(number)
            } else {
                let `operator` = try Operator.convert(from: element)
                try calculateToValue(operator: `operator`)
            }
        }
        guard let result = temporaryNumberStack.pop() else {
            throw CalculatorError.vacantEquation
        }
        return result
    }

    private mutating func calculateToValue(`operator`: Operator) throws {
        guard let secondOperand = temporaryNumberStack.pop(),
              let firstOperand = temporaryNumberStack.pop()
        else {
            return
        }
        let operationResult = try solve(firstOperand: firstOperand, secondOperand: secondOperand, operator: `operator`)
        temporaryNumberStack.push(operationResult)
    }

    private func solve(firstOperand: Double, secondOperand: Double, `operator`: Operator) throws -> Double {
        switch `operator` {
        case .plus:
            return plus(firstOperand: firstOperand, secondOperand: secondOperand)
        case .minus:
            return minus(firstOperand: firstOperand, secondOperand: secondOperand)
        case .multiply:
            return multiply(firstOperand: firstOperand, secondOperand: secondOperand)
        case .divide:
            return try divide(firstOperand: firstOperand, secondOperand: secondOperand)
        }
    }
    
    private func checkDivisionError(secondOperand: Double) throws {
        if secondOperand == 0.0 {
            throw CalculatorError.divisionByZero
        }
    }
    
//MARK:- 연산결과를 가공해주는 부분
    private func format(number: Double) throws -> String {
        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.usesSignificantDigits = true
            return formatter
        }()
        guard let result = formatter.string(from: NSNumber(value: number)) else {
            throw CalculatorError.unknownError
        }
        return result
    }
}

extension Calculator: Calculatable {
    func plus(firstOperand: Double, secondOperand: Double) -> Double {
        return firstOperand + secondOperand
    }
    
    func minus(firstOperand: Double, secondOperand: Double) -> Double {
        return firstOperand - secondOperand
    }
    
    func multiply(firstOperand: Double, secondOperand: Double) -> Double {
        return firstOperand * secondOperand
    }
    
    func divide(firstOperand: Double, secondOperand: Double) throws -> Double {
        try checkDivisionError(secondOperand: secondOperand)
        return firstOperand / secondOperand
    }
}
