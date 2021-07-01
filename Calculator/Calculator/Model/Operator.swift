//
//  Operator.swift
//  Calculator
//
//  Created by 홍정아 on 2021/06/30.
//

import Foundation

enum Operator: String {
    private static let lowPriority = 1
    private static let highPriority = 2

    case plus = "+"
    case minus = "−"
    case multiply = "×"
    case divide = "÷"

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
    
    static func convert(from symbol: String) throws -> Operator {
        switch symbol {
        case "+":
            return .plus
        case "−":
            return .minus
        case "×":
            return .multiply
        case "÷":
            return .divide
        default:
            throw CalculatorError.unknownOperator
        }
    }
}
