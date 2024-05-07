//
//  AlertViewController.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit
import RxSwift

enum AlertType {
    case ok
    case cancel
}

class AlertViewController: UIViewController {

    private let layoutView = AlertView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutView.firstAlertButton.rx.tap
            .flatMap { [unowned self] in
                self.oneActionAlert("Current Color", self.layoutView.colorView.backgroundColor?.rgbHexString)
            }
            .subscribe(onNext: { [unowned self] alertType in
                switch alertType {
                case .ok:
                    print(self.layoutView.colorView.backgroundColor?.rgbHexString ?? "")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        layoutView.secondAlertButton.rx.tap
            .flatMap { [unowned self] in
                self.twoActionAlert("Rest Color", "Reset to black color?")
            }
            .subscribe(onNext: { [unowned self] alertType in
                switch alertType {
                case .ok:
                    self.layoutView.colorView.backgroundColor = .black
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        layoutView.thirdAlertButton.rx.tap
            .flatMap { [unowned self] in
                self.multipleActionSheet(MaterialBlue.allColors, "Colors", "choose one")
            }
            .subscribe(onNext: { [unowned self] color in
                layoutView.colorView.backgroundColor = color
            })
            .disposed(by: disposeBag)
    }

    func oneActionAlert(_ title: String, _ message: String? = nil) -> Observable<AlertType> {
        return Observable.create { [weak self] observer in
            let alertVC = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }

            alertVC.addAction(okAction)
            self?.present(alertVC, animated: true)

            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }

    func twoActionAlert(_ title: String, _ message: String? = nil) -> Observable<AlertType> {
        return Observable.create { [weak self] observer in
            let alertVC = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                observer.onNext(.cancel)
                observer.onCompleted()
            }

            alertVC.addAction(okAction)
            alertVC.addAction(cancelAction)

            self?.present(alertVC, animated: true)

            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }

    func multipleActionSheet(_ colors: [UIColor], _ title: String, _ message: String? = nil) -> Observable<UIColor> {
        return Observable.create { [weak self] observer in
            let actionSheet = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .actionSheet)

            for color in colors {
                let colorAction = UIAlertAction(title: color.rgbHexString, style: .default) { _ in
                    observer.onNext(color)
                    observer.onCompleted()
                }
                actionSheet.addAction(colorAction)
            }

            self?.present(actionSheet, animated: true)

            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }
}
