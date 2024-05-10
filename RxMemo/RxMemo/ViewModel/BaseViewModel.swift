//
//  BaseViewModel.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType

    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
