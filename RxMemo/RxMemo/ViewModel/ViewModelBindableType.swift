//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import UIKit

/*
MVVM - ViewModel을 ViewController의 속성으로 추가
ViewModel과 View를 바인딩
이를 수행할 프로토콜
*/

protocol ViewModelBindableType {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
