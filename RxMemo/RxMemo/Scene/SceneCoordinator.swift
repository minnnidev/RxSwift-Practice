//
//  SceneCoordinator.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.last ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    private let disposeBag = DisposeBag()
    private var window: UIWindow
    private var currentVC: UIViewController

    required init(window: UIWindow) {
        self.window = window
        self.currentVC = window.rootViewController!
    }

    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Never>() // 화면 전환의 성공 실패
        let target = scene.instantiate()

        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }

            nav.rx.willShow
                .withUnretained(self)
                .subscribe(onNext: { (coordinator, event) in
                    coordinator.currentVC = event.viewController.sceneViewController
                })
                .disposed(by: disposeBag)

            nav.pushViewController(target, animated: animated)

            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }

            currentVC = target.sceneViewController
        }

        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }

                self.currentVC = nav.viewControllers.last!.sceneViewController
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }

            return Disposables.create()
        }
    }
}
