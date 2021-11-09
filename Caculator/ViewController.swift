//  ViewController.swift
//  Caculator
//  Created by Nguyen Hoang Viet on 30/09/2021.

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var resultsLabel: UILabel!
  @IBOutlet weak var inputLabel: UILabel!
  var lastOperator: String = ""
  var position: String = ""
  var currentNumber: Double = 0.0
  var previousNumber: Double = 0.0
  var isOperatorRunning = false
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBAction func clearAll(_ sender: Any) {
    resultsLabel.text = ""
    inputLabel.text = ""
    lastOperator = ""
    currentNumber = 0
    previousNumber = 0
    isOperatorRunning = false
  }
  @IBAction func opposite(_ sender: Any) {
    guard var textResultsLabel = resultsLabel.text else { return  }
    if textResultsLabel == "0" || textResultsLabel.isEmpty {
      return
    }
    if !textResultsLabel.contains("-") {
      textResultsLabel.insert("-", at: textResultsLabel.startIndex)
      resultsLabel.text = textResultsLabel
    } else {
      textResultsLabel.remove(at: textResultsLabel.startIndex)
      resultsLabel.text = textResultsLabel
    }
  }
  @IBAction func onNumberButtonClicked(_ sender: UIButton) {
    guard var textResultsLabel = resultsLabel.text, let textLabel = sender.titleLabel?.text,
          var textInputLabel  = inputLabel.text else { return }
    switch sender.tag {
    case 19:
      if !textResultsLabel.isEmpty {
        textResultsLabel += textLabel
        resultsLabel.text = textResultsLabel
        textInputLabel += textLabel
        inputLabel.text = textInputLabel
      } else if !(textResultsLabel.contains(".")) {
        appendText(sender)
      }
    default:
      if isOperatorRunning {
        setText(sender)
        currentNumber = Double(resultsLabel.text!) ?? 0
        isOperatorRunning = false
      } else {
        if resultsLabel.text == "0" {
          setText(sender)
        } else {
          appendText(sender)
        }
        currentNumber = Double(resultsLabel.text!) ?? 0
      }
      textInputLabel += textLabel
      inputLabel.text = textInputLabel
    }
  }
  @IBAction func onOperatorButtonClick(_ sender: UIButton) {
    guard var textResultsLabel = resultsLabel.text, let textLabel = sender.titleLabel?.text,
          var textInputLabel = inputLabel.text else { return }
    if !textResultsLabel.isEmpty {
      if textLabel == "=" {
        let result = performCaulation()
        textResultsLabel = result.removeZerosFromEnd()
        resultsLabel.text = textResultsLabel
      } else {
        previousNumber = performCaulation()
        setText(sender)
        lastOperator = textLabel
        isOperatorRunning = true
        textInputLabel += textLabel
        inputLabel.text = textInputLabel
      }
    }
  }
  @IBAction func backTap(_ sender: Any) {
    guard var textInputLabel = inputLabel.text, var textResultsLabel = resultsLabel.text else { return }
    if !textInputLabel.isEmpty {
      textInputLabel.removeLast()
      inputLabel.text = textInputLabel
    }
    if !textResultsLabel.isEmpty {
      textResultsLabel.removeLast()
      resultsLabel.text = textResultsLabel
    }
  }
  func performCaulation() -> Double {
    var result: Double
    switch  lastOperator {
    case "+":
      result = previousNumber + currentNumber
    case "-":
      result = previousNumber - currentNumber
    case "X":
      result = previousNumber * currentNumber
    case "/":
      var divide: Double = 0
      if currentNumber == 0 {
        let alert = UIAlertController(title: "Erros", message: "No division by zero", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertActionOk)
        self.present(alert, animated: true, completion: nil)
      } else {
        divide = previousNumber / currentNumber
      }
      result = divide
    case "%":
      result = previousNumber.truncatingRemainder(dividingBy: currentNumber)
    default:
      result = Double(resultsLabel.text!) ?? 0
    }
    return result
  }
  func appendText(_ sender: UIButton) {
    guard let textLabel = sender.titleLabel?.text, var textResultsLabel = resultsLabel.text else { return }
    textResultsLabel += textLabel
    resultsLabel.text = textResultsLabel
  }
  func setText(_ sender: UIButton) {
    guard let text = sender.titleLabel?.text else { return }
    resultsLabel.text = text
  }
}
