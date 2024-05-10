//
//  Scene.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import UIKit

enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    // 연관값의 viewModel을 바인딩하고 return하기
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)

        switch self {
        case .list(let memoListViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }

            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }

            DispatchQueue.main.async {
                listVC.bind(viewModel: memoListViewModel)
            }

            return nav
        case .detail(let detailViewModel):

            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
                fatalError()
            }

            DispatchQueue.main.async {
                detailVC.bind(viewModel: detailViewModel)
            }

            return detailVC
        case .compose(let composeViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
                fatalError()
            }

            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }

            DispatchQueue.main.async {
                composeVC.bind(viewModel: composeViewModel)
            }

            return nav
        }
    }
}
