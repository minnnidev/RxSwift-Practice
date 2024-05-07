//
//  ColorControlViewController.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit
import RxSwift

class ColorControlViewController: UIViewController {

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Color"
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private let segmentedControl: UISegmentedControl = {
        let items = ["red", "green", "blue"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setConstraints()
        bindings()
    }

    func bindings() {
        // #1 custom binder을 사용하지 않았을 경우
        //        segmentedControl.rx.selectedSegmentIndex
        //            .subscribe(onNext: { [weak self] idx in
        //                switch idx {
        //                case 0:
        //                    self?.colorLabel.text = "red"
        //                case 1:
        //                    self?.colorLabel.text = "green"
        //                default:
        //                    self?.colorLabel.text = "blue"
        //                }
        //            })
        //            .disposed(by: disposeBag)
        //
        //        segmentedControl.rx.selectedSegmentIndex
        //            .subscribe(onNext: { [weak self] idx in
        //                switch idx {
        //                case 0:
        //                    self?.colorLabel.textColor = .red
        //                case 1:
        //                    self?.colorLabel.textColor = .green
        //                default:
        //                    self?.colorLabel.textColor = .blue
        //                }
        //            })
        //            .disposed(by: disposeBag)

        // #2 custom binder 사용 - 직관적
        segmentedControl.rx.selectedSegmentIndex
            .bind(to: colorLabel.rx.segmentedValue)
            .disposed(by: disposeBag)
    }

    func setConstraints() {
        [colorLabel, segmentedControl].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            colorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension Reactive where Base: UILabel {
    var segmentedValue: Binder<Int> {
        return Binder(self.base) { label, index in
            switch index {
            case 0:
                label.text = "red"
                label.textColor = .red
            case 1:
                label.text = "green"
                label.textColor = .green
            case 2:
                label.text = "blue"
                label.textColor = .blue
            default:
                label.text = "unknown"
                label.textColor = .black
            }
        }
    }
}
