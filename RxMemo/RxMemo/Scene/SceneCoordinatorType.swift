//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable

    @discardableResult
    func close(animated: Bool) -> Completable
}
