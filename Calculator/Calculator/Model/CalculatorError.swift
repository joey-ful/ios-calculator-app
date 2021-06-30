//
//  CalculatorError.swift
//  Calculator
//
//  Created by 홍정아 on 2021/06/30.
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
