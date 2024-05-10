//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoDetailViewController: UIViewController, ViewModelBindableType {
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!

    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var viewModel: MemoDetailViewModel!

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        viewModel.contents
            .bind(to: contentTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: rx.disposeBag)

        // action
        editButton.rx.action = viewModel.makeEditAction()
        deleteButton.rx.action = viewModel.makeDeleteAction()

        // tap
        shareButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                let memo = vc.viewModel.memo.content

                let activityVC = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
                vc.present(activityVC, animated: true)
            })
            .disposed(by: rx.disposeBag)

//        var backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
//        viewModel.title
//            .drive(backButton.rx.title)
//            .disposed(by: rx.disposeBag)
//
//        backButton.rx.action = viewModel.popAction
//        navigationItem.hidesBackButton = true
//        navigationItem.leftBarButtonItem = backButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
