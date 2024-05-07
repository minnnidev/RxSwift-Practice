//
//  TextFieldColorViewController.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldColorViewController: UIViewController {

    private let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.black.cgColor
        return tf
    }()

    private let doneButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("done", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setConstraints()
        bindings()
    }

    func bindings() {
        textField.rx.editingDidBegin
            .map { UIColor.red }
//            .subscribe(onNext: { color in
//                self.textField.layer.borderColor = color.cgColor
//            })
            .bind(to: textField.rx.borderColor)
            .disposed(by: disposeBag)

        textField.rx.editingDidEnd
            .map { UIColor.blue }
            .bind(to: textField.rx.borderColor)
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.textField.resignFirstResponder()
            })
            .disposed(by: disposeBag)

//        textField.rx.text.orEmpty
//            .map { "\($0.count)" }
//            .bind(to: countLabel.rx.text)
//            .disposed(by: disposeBag)

        textField.rx.text
            .bind(to: countLabel.rx.count)
            .disposed(by: disposeBag)

    }

    func setConstraints() {
        [textField, doneButton, countLabel].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            countLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 20)
        ])
    }

}

extension Reactive where Base: UILabel {
    var count: Binder<String?> {
        return Binder(self.base) { label, str in
            label.text = "\(str?.count ?? 0)"
        }
    }
}

extension Reactive where Base: UITextField {
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { textField, color in
            textField.layer.borderColor = color?.cgColor
        }
    }

    var editingDidBegin: ControlEvent<Void> {
        return controlEvent(.editingDidBegin)
    }

    var editingDidEnd: ControlEvent<Void> {
        return controlEvent(.editingDidEnd)
    }
}
