//
//  BackgroundColorControlViewController.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit
import RxSwift
import RxCocoa

class BackgroundColorControlViewController: UIViewController {

    private let colorSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("reset", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setConstraints()
        bindings()
    }

    func bindings() {
        colorSlider.rx.value
            .map { UIColor(white: CGFloat($0), alpha: 1.0) }
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)

        resetButton.rx.tap
            .map { Float(0.5) }
            .bind(to: colorSlider.rx.value)
            .disposed(by: disposeBag)

        resetButton.rx.tap
            .map { UIColor(white: CGFloat(0.5), alpha: 1.0) }
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)

        colorSlider.rx.color
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)

        resetButton.rx.tap
            .map { UIColor(white: 0.5, alpha: 1.0) }
            .bind(to: colorSlider.rx.color.asObserver(), view.rx.backgroundColor.asObserver())
            .disposed(by: disposeBag)
    }

    func setConstraints() {
        [colorSlider, resetButton].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            colorSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            colorSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: colorSlider.bottomAnchor, constant: 20)
        ])
    }
}

extension Reactive where Base: UISlider {
    var color: ControlProperty<UIColor?> {
        return base.rx.controlProperty(editingEvents: .valueChanged,
        getter: { slider in
            UIColor(white: CGFloat(slider.value), alpha: 1.0)
        },
        setter: { slider, color in
            var white = CGFloat(1)
            color?.getWhite(&white, alpha: nil)
            slider.value = Float(white)
        })
    }
}
