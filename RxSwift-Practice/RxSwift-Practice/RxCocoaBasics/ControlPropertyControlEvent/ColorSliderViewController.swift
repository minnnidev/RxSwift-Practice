//
//  ColorSliderViewController.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/5/24.
//

import UIKit
import RxSwift
import RxCocoa

class ColorSliderViewController: UIViewController {

    private let layoutView = ColorSliderView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // slider 변경에 따라 컬러 수치 바꾸기
        layoutView.redSlider.rx.value
            .map { "\(Int($0))" }
            .bind(to: layoutView.redColor.rx.text)
            .disposed(by: disposeBag)

        layoutView.greenSlider.rx.value
            .map { "\(Int($0))" }
            .bind(to: layoutView.greenColor.rx.text)
            .disposed(by: disposeBag)

        layoutView.blueSlider.rx.value
            .map { "\(Int($0))" }
            .bind(to: layoutView.blueColor.rx.text)
            .disposed(by: disposeBag)

        // 컬러 수치들에 따라 색 바꾸기
        let bg = Observable.combineLatest([layoutView.redSlider.rx.value, layoutView.greenSlider.rx.value, layoutView.blueSlider.rx.value])
        bg
            .map { UIColor(red: CGFloat($0[0]) / 255,
                           green: CGFloat($0[1]) / 255,
                           blue: CGFloat($0[2]) / 255,
                           alpha: 1.0)}
            .bind(to: layoutView.colorView.rx.backgroundColor)
            .disposed(by: disposeBag)

        // reset button tap할 시 초기화
        layoutView.resetButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.layoutView.colorView.backgroundColor = .black
                self?.layoutView.redSlider.value = 0
                self?.layoutView.greenSlider.value = 0
                self?.layoutView.blueSlider.value = 0
            })
            .disposed(by: disposeBag)
    }
}
