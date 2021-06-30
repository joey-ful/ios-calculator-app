//
//  Calculatable.swift
//  Calculator
//
//  Created by 홍정아 on 2021/06/30.
//

import Foundation

protocol Calculatable {
    func plus(firstOperand: Double, secondOperand: Double) -> Double
    func minus(firstOperand: Double, secondOperand: Double) -> Double
    func multiply(firstOperand: Double, secondOperand: Double) -> Double
    func divide(firstOperand: Double, secondOperand: Double) throws -> Double
}
