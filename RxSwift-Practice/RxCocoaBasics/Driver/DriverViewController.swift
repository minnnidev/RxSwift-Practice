//
//  DriverViewController.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit
import RxSwift
import RxCocoa

enum ValidationError: Error {
    case notANumber
}

class DriverViewController: UIViewController {

    private let layoutView = DriverView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let result = layoutView.textField.rx.text.asDriver()
            .flatMapLatest {
                self.validateText($0)
                    .asDriver(onErrorJustReturn: false)
            }

        result
            .map { $0 ? "유효합니다." : "유효하지 않습니다." }
            .drive(layoutView.label.rx.text)
            .disposed(by: disposeBag)

        result
            .map { $0 ? UIColor.systemBlue : UIColor.systemRed }
            .drive(layoutView.label.rx.textColor)
            .disposed(by: disposeBag)

        result
            .drive(layoutView.sendButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    func validateText(_ value: String?) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            guard let str = value, let _ = Double(str) else {
                observer.onError(ValidationError.notANumber)
                return Disposables.create()
            }

            observer.onNext(true)
            observer.onCompleted()

            return Disposables.create()
        }
    }
}
