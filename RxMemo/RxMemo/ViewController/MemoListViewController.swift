//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

class MemoListViewController: UIViewController, ViewModelBindableType {

    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!

    var viewModel: MemoListViewModel!

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        viewModel.memoList
            .bind(to: listTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)

        addButton.rx.action = viewModel.makeCreateAction()

        // do -> 구독 시점이 아닌 이벤트 방출 시점에 이벤트 처리
        // zip 튜플 형태로 합침
        // withUnretained(self)를 사용하여 클로저 캡처리스트 사용하지 않아도 됨. (RxSwift6 이상)
        Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected)
            .withUnretained(self)
            .do(onNext: { (vc, data) in
                vc.listTableView.deselectRow(at: data.1, animated: true)
            })
            .map { $1.0 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)

        listTableView.rx.modelDeleted(Memo.self)
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
