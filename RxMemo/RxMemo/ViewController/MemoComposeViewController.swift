//
//  MemoComposeViewController.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Action

class MemoComposeViewController: UIViewController, ViewModelBindableType {
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!
    
    var viewModel: MemoComposeViewModel!

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)

        cancelButton.rx.action = viewModel.cancelAction

        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: rx.disposeBag)

        let willShowObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue } // 옵셔널 자동 언래핑
            .map { $0.cgRectValue.height }

        let wiilHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { noti -> CGFloat in 0 }

        let keyboardObservable = Observable.merge(willShowObservable, wiilHideObservable)
            .share()

        keyboardObservable
            .withUnretained(contentTextView)
            .subscribe(onNext: { tv, height in
                var inset = tv.contentInset
                inset.bottom = height
                tv.contentInset = inset

                var scrollInset = tv.verticalScrollIndicatorInsets
                scrollInset.bottom = height
                tv.verticalScrollIndicatorInsets = scrollInset
            })
            .disposed(by: rx.disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contentTextView.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
}
