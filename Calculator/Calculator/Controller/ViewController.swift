//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickNumberButtons()
        CurrentNumberLabel.text = "0"
        CurrentSignLabel.text = ""
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
    
    func containsDot() {
        if ((CurrentNumberLabel.text?.contains(".")) != nil) {
            
        }
    }
}

