//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

//MARK: - 프로퍼티 선언 및 라이프사이클
class ViewController: UIViewController {

    @IBOutlet var numberZeroButton: UIButton!
    @IBOutlet var numberOneButton: UIButton!
    @IBOutlet var numberTwoButton: UIButton!
    @IBOutlet var numberThreeButton: UIButton!
    @IBOutlet var numberFourButton: UIButton!
    @IBOutlet var numberFiveButton: UIButton!
    @IBOutlet var numberSixButton: UIButton!
    @IBOutlet var numberSevenButton: UIButton!
    @IBOutlet var numberEightButton: UIButton!
    @IBOutlet var numberNineButton: UIButton!
    @IBOutlet var numberDoubleZeroButton: UIButton!
    @IBOutlet var dotButton: UIButton!
    
    @IBOutlet weak var CurrentNumberLabel: UILabel!
    @IBOutlet weak var CurrentSignLabel: UILabel!
    @IBOutlet weak var CEButton: UIButton!
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var historyStack: UIStackView!
    
    var infix: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickNumberButtons()
        CurrentNumberLabel.text = "0"
        CurrentSignLabel.text = ""
    }

    @IBAction func CEButtonTapped(_ sender: Any) {
        CurrentNumberLabel.text = "0"
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        guard let currentNumberText = CurrentNumberLabel.text,
              let currentSignText = CurrentSignLabel.text,
              let operatorButtonLabel = sender.titleLabel else {
            return
        }

        CurrentSignLabel.text = operatorButtonLabel.text
        
        if currentNumberText != "0" {
            let numberLabel = createUILabel(text: currentNumberText)
            var operatorLabel: UILabel?
            if infix.isEmpty {
                infix.append(currentNumberText)
            } else {
                infix.append(currentSignText)
                infix.append(currentNumberText)
                operatorLabel = createUILabel(text: currentSignText)
            }
            appendStackView(operatorLabel: operatorLabel, numberLabel: numberLabel)
            CurrentNumberLabel.text = "0"
        }
    }
    
    func raiseToStack(operator: String, number: String) {
        
    }
    
    @IBAction func shiftSignButtonTapped(_ sender: Any) {
        guard let numberText = CurrentNumberLabel.text, numberText != "0" else {
            return
        }
        if numberText.contains("-") == false {
            CurrentNumberLabel.text?.insert("-", at: numberText.startIndex)
        } else {
            CurrentNumberLabel.text?.removeFirst()
        }
    }
}

//MARK: - Action
extension ViewController {
    func createUILabel(text: String?) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }

    func appendStackView(operatorLabel: UILabel?, numberLabel: UILabel) {
        let stackView = UIStackView()
        stackView.spacing = 8
        if let operatorLabel = operatorLabel {
            stackView.addArrangedSubview(operatorLabel)
        }
        stackView.addArrangedSubview(numberLabel)
        historyStack.addArrangedSubview(stackView)
    }

    @objc func inputNumberOnLabel(_ sender: UIButton) {
        switch sender {
        case numberZeroButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("0")
        case numberDoubleZeroButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("00")
        case dotButton:
            if let dotExist = CurrentNumberLabel.text?.contains("."),
               dotExist == false {
                CurrentNumberLabel.text?.append(".")
            }
        case numberOneButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("1")
        case numberTwoButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("2")
        case numberThreeButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("3")
        case numberFourButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("4")
        case numberFiveButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("5")
        case numberSixButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("6")
        case numberSevenButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("7")
        case numberEightButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("8")
        case numberNineButton:
            checkCurrentNumberLabel()
            CurrentNumberLabel.text?.append("9")
        default:
            CurrentNumberLabel.text = nil
        
        }
    }

    func clickNumberButtons() {
        numberZeroButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberDoubleZeroButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        dotButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberOneButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberTwoButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberThreeButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberFourButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberFiveButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberSixButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberSevenButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberEightButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
        numberNineButton.addTarget(self, action: #selector(inputNumberOnLabel(_:)), for: .touchUpInside)
    }

    func checkCurrentNumberLabel() {
        if CurrentNumberLabel.text == "0" {
            CurrentNumberLabel.text = ""
        } else if CurrentNumberLabel.text == "00" {
            CurrentNumberLabel.text = ""
        }
    }
}
