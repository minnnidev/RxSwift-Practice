//
//  DriverView.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit

class DriverView: UIView {

    let textField = UITextField()
    let label = UILabel()
    let sendButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews() {
        [textField, label, sendButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        textField.borderStyle = .roundedRect

        label.text = ""

        sendButton.setTitle("send", for: .normal)
        sendButton.setTitleColor(.systemBlue, for: .normal)
        sendButton.setTitleColor(.lightGray, for: .disabled)

        backgroundColor = .white
    }

    func setConstraints() {
        [textField, label, sendButton].forEach {
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30)
        ])
    }
}
