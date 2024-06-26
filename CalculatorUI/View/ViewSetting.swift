//
//  ViewSetting.swift
//  CalculatorUI
//
//  Created by Soo Jang on 6/24/24.
//
import UIKit
import SnapKit

class ViewSetting: UIView {
    var expression = "0" {
        didSet {
            Buttons.operators.forEach {
                if expression == $0 {
                    expression = "0"
                }
            }
            numLabel.text = expression
        }
    }
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.text = expression
        label.textAlignment = .right
        label.textColor = .white
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    lazy var buttons: [UIButton] = {
        let btnLabels = Buttons.texts
        return btnLabels.map {
            let btn = UIButton()
            btn.setTitle($0, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
            btn.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            Buttons.orrangeBtns.forEach {
                if btn.titleLabel?.text == $0 {
                    btn.backgroundColor = .orange
                }
            }
            return btn
        }
    }()
    lazy var horizonSt: [UIStackView] = {
        var stArray: [UIStackView] = []
        for index in stride(from: 0, through: buttons.endIndex, by: 4) {
            let stv = UIStackView(arrangedSubviews: Array(buttons[index...(index + 3)]))
            stv.axis = .horizontal
            stv.spacing = 10
            stv.distribution = .fillEqually
            stArray.append(stv)
        }
        return stArray
    }()
    lazy var vertiSt: UIStackView = {
       let stv = UIStackView(arrangedSubviews: horizonSt)
        stv.axis = .vertical
        stv.spacing = 10
        stv.distribution = .fillEqually
        return stv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setLayout() {
        self.backgroundColor = .black
        [numLabel, vertiSt].forEach {
            self.addSubview($0)
        }
        numLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(200)
            $0.height.equalTo(100)
        }
        buttons.forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(80)
            }
            $0.layer.cornerRadius = 40
        }
        vertiSt.snp.makeConstraints {
            $0.top.equalTo(numLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
    }
}
