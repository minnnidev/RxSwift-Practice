//
//  MemoComposeViewModel.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel: BaseViewModel {
    private let content: String?

    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: "")
    }

    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction

    // 파라미터로 action을 받아 이전 화면에서 동적으로 처리할 수 있게
    init(title: String, content: String?, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.content = content

        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }

            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }

        self.cancelAction = CocoaAction { input in
            if let action = cancelAction {
                action.execute(())
            }

            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }

        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
