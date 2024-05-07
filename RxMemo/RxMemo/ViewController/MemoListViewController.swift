//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by 김민 on 5/7/24.
//

import UIKit

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!

    func bindViewModel() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
}

