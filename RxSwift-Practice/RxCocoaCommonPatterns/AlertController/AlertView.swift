//
//  AlertView.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit

class AlertView: UIView {

    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    let firstAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("One Action", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    let secondAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Two Actions", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    let thirdAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Multiple Actions", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setConstraints() {
        [colorView, firstAlertButton, secondAlertButton, thirdAlertButton].forEach {
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 200),
            colorView.widthAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            firstAlertButton.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 100),
            firstAlertButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            secondAlertButton.topAnchor.constraint(equalTo: firstAlertButton.bottomAnchor, constant: 50),
            secondAlertButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            thirdAlertButton.topAnchor.constraint(equalTo: secondAlertButton.bottomAnchor, constant: 50),
            thirdAlertButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
