//
//  ColorSliderView.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/5/24.
//

import UIKit

class ColorSliderView: UIView {

    let colorView = UIView()
    let redColorName = UILabel()
    let redSlider = UISlider()
    let redColor = UILabel()
    let greenColorName = UILabel()
    let greenSlider = UISlider()
    let greenColor = UILabel()
    let blueColorName = UILabel()
    let blueSlider = UISlider()
    let blueColor = UILabel()
    let redStackView = UIStackView()
    let greenStackView = UIStackView()
    let blueStackView = UIStackView()
    let resetButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews() {
        [colorView, redColor, redSlider,redColor, greenColorName, greenSlider, greenColor, blueColorName, blueSlider, blueColor, redStackView, greenStackView, blueStackView, resetButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        backgroundColor = .white
        colorView.backgroundColor = .black

        redColorName.text = "red"
        redColor.text = "0"
        redSlider.tintColor = .red
        redSlider.maximumValue = 255

        greenColorName.text = "green"
        greenColor.text = "0"
        greenSlider.tintColor = .green
        greenSlider.maximumValue = 255

        blueColorName.text = "blue"
        blueColor.text = "0"
        blueSlider.tintColor = .blue
        blueSlider.maximumValue = 255

        resetButton.setTitle("reset", for: .normal)
        resetButton.setTitleColor(.systemBlue, for: .normal)

        [redStackView, greenStackView, blueStackView].forEach {
            $0.spacing = 10
        }
    }

    func setConstraints() {
        [colorView, redStackView, greenStackView, blueStackView, resetButton].forEach {
            addSubview($0)
        }

        [redColorName, redSlider, redColor].forEach {
            redStackView.addArrangedSubview($0)
        }

        [greenColorName, greenSlider, greenColor].forEach {
            greenStackView.addArrangedSubview($0)
        }

        [blueColorName, blueSlider, blueColor].forEach {
            blueStackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 150)
        ])

        NSLayoutConstraint.activate([
            redStackView.trailingAnchor.constraint(equalTo: colorView.trailingAnchor),
            redStackView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            redStackView.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15)
        ])


        NSLayoutConstraint.activate([
            greenStackView.trailingAnchor.constraint(equalTo: redStackView.trailingAnchor),
            greenStackView.leadingAnchor.constraint(equalTo: redStackView.leadingAnchor),
            greenStackView.topAnchor.constraint(equalTo: redStackView.bottomAnchor, constant: 15)
        ])


        NSLayoutConstraint.activate([
            blueStackView.trailingAnchor.constraint(equalTo: greenStackView.trailingAnchor),
            blueStackView.leadingAnchor.constraint(equalTo: greenStackView.leadingAnchor),
            blueStackView.topAnchor.constraint(equalTo: greenStackView.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: blueStackView.bottomAnchor, constant: 30)
        ])
    }
}
