//
//  RxTableViewController.swift
//  RxSwift-Practice
//
//  Created by 김민 on 5/7/24.
//

import UIKit
import RxSwift
import RxCocoa

class RxTableViewController: UIViewController {

    private let layoutView = RxTableView()

    private let disposeBag = DisposeBag()
    private let nameObservable = Observable.of(appleProducts.map { $0.name })
    private let productObservable = Observable.of(appleProducts)

    private let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = NumberFormatter.Style.currency
        f.locale = Locale(identifier: "Ko_kr")

        return f
    }()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        bindings()
    }

    private func setTableView() {
//        layoutView.tableView.delegate = self
        layoutView.tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
    }

    private func bindings() {
        // #1 기본 cell로 tableView 구현
//        nameObservable
//            .bind(to: layoutView.tableView.rx.items) { _, row, elem in
//                let cell = UITableViewCell()
//                cell.textLabel?.text = "\(elem)"
//                return cell
//            }
//            .disposed(by: disposeBag)

        // #2 custom cell로 tableView 구현
        productObservable
            .bind(to: layoutView.tableView.rx.items(cellIdentifier: "ProductTableViewCell", cellType: ProductTableViewCell.self)) { [weak self] row, elem, cell in
                cell.categoryLabel.text =  elem.category
                cell.nameLabel.text = elem.name
                cell.summaryLabel.text = elem.summary
                cell.priceLabel.text = self?.priceFormatter.string(for: elem.price)
            }
            .disposed(by: disposeBag)

        // #3 cell model selected 구현 (index 필요하다면 itemSelected도 가능)
        layoutView.tableView.rx.modelSelected(Product.self)
            .subscribe(onNext: {
                print($0.name)
            })
            .disposed(by: disposeBag)

        // #4 RxCocoa를 사용하면서 동시에 delegate를 활용하고 싶다면 
        layoutView.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension RxTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
