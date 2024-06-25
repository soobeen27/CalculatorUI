//
//  ViewController.swift
//  CalculatorUI
//
//  Created by Soo Jang on 6/24/24.
//

import UIKit

class ViewController: UIViewController {

    var viewSetting: ViewSetting!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewSetting.buttons.forEach {
            $0.addTarget(self, action: #selector(btnsTapped), for: .touchDown)
        }
    }

    override func loadView() {
        super.loadView()
        viewSetting = ViewSetting(frame: self.view.frame)
        self.view = viewSetting
    }

    @objc
    func btnsTapped(_ sender: UIButton) {
        guard let input = sender.titleLabel?.text else { return }
        if viewSetting.expression.prefix(1) == "0" {
            viewSetting.expression.removeFirst()
        }
        switch input {
        case "AC":
            viewSetting.expression = "0"
        case "=":
            guard let result = calculate(expression: viewSetting.expression) else { return }
            viewSetting.expression = String(result)
            print(viewSetting.expression)
        case _ where Buttons.operators.contains(input):
            if Buttons.operators.contains(String(viewSetting.expression.last ?? " ")) {
                viewSetting.expression.removeLast()
            }
            viewSetting.expression.append(input)
        default:
            viewSetting.expression.append(input)
        }
    }
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
}
