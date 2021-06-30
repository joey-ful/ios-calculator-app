//
//  Calculator.swift
//  Calculator
//
//  Created by 신동훈 on 2021/06/23.
//

import Foundation

enum CalculatorError: Error, LocalizedError {
    case unknownOperator
    case divisionByZero
    case vacantEquation
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .unknownOperator:
            return "알 수 없는 연산자입니다."
        case .divisionByZero:
            return "NaN"
        case .vacantEquation:
            return "식이 비었습니다."
        case .unknownError:
            return "알 수 없는 에러가 발생했습니다."
        }
        
    }
}

enum Operator {
    private static let lowPriority = 1
    private static let highPriority = 2

    case plus, minus
    case multiply, divide

    var priority: Int {
        switch self {
        case .plus, .minus:
            return Operator.lowPriority
        case .multiply, .divide:
            return Operator.highPriority
        }
    }

    static func >(lhs: Operator, rhs: Operator) -> Bool {
        return lhs.priority > rhs.priority
    }
}

struct Calculator {
    func calculate(infix: [String]) throws -> String {
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

    private func calculatePostfix(postfix: [String]) throws -> Double {
        var temporaryNumberStack = Stack<Double>()
        for element in postfix {
            if let number = Double(element) {
                temporaryNumberStack.push(number)
            } else {
                try calculateToValue(operator: element, tempNumberStack: &temporaryNumberStack)
            }
        }
        guard let result = temporaryNumberStack.pop() else {
            throw CalculatorError.vacantEquation
        }
        return result
    }

    private func calculateToValue(operator: String, tempNumberStack: inout Stack<Double>) throws {
        guard let secondOperand = tempNumberStack.pop(),
              let firstOperand = tempNumberStack.pop()
        else {
            return
        }
        let operationResult = try solve(firstOperand: firstOperand, secondOperand: secondOperand, operator: `operator`)
        tempNumberStack.push(operationResult)
    }

    private func checkDivisionError(operator: String, secondOperand: Double) throws {
        if `operator` == "/" && secondOperand == 0.0 {
            throw CalculatorError.divisionByZero
        }
    }

    private func solve(firstOperand: Double, secondOperand: Double, `operator`: String) throws -> Double {
        switch `operator` {
        case "+":
            return firstOperand + secondOperand
        case "-":
            return firstOperand - secondOperand
        case "*":
            return firstOperand * secondOperand
        case "/":
            try checkDivisionError(operator: "/", secondOperand: secondOperand)
            return firstOperand / secondOperand
        default:
            throw CalculatorError.unknownOperator
        }
    }

    private func convertToOperator(string: String) throws -> Operator {
        switch string {
        case "+":
            return .plus
        case "-":
            return .minus
        case "*":
            return .multiply
        case "/":
            return .divide
        default:
            throw CalculatorError.unknownOperator
        }
    }

    private func changeToPostfixNotation(infix: [String]) throws -> [String] {
        var temporarySignStack = Stack<String>()
        var postfix: [String] = []
        for element in infix {
            if Double(element) != nil {
                postfix.append(element)
            } else {
                try popAndAppend(sign: element, from: &temporarySignStack, to: &postfix)
                temporarySignStack.push(element)
            }
        }
        try popAndAppendLeftovers(from: &temporarySignStack, to: &postfix)
        return postfix
    }

    private func hasHigherPriority(this: String, than: String) throws -> Bool {
        let currentOperator: Operator = try convertToOperator(string: this)
        let thanOperator: Operator = try convertToOperator(string: than)
        return currentOperator > thanOperator
    }
    
    private func popAndAppend(sign: String,
                              from temporarySignStack: inout Stack<String>,
                              to postfix: inout [String]) throws {
        while let topOfTemporarySignStack = temporarySignStack.top,
              try hasHigherPriority(this: sign, than: topOfTemporarySignStack) == false {
            if let poppedSign = temporarySignStack.pop() {
                postfix.append(poppedSign)
            }
        }
    }

    private func popAndAppendLeftovers(from temporarySignStack: inout Stack<String>,
                                       to postfix: inout [String]) throws{
        while temporarySignStack.isEmpty == false {
            if let poppedSign = temporarySignStack.pop() {
                postfix.append(poppedSign)
            }
        }
    }
}
