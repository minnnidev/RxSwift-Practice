import UIKit
import RxSwift

/*
 hare(replay:scope)
     - replay buffer default: 0
     - scope: 수명
        - whileConnected(default): subscriber가 존재하는 동안은 subject 공유
        - forever: 하나의 subject를 공유
     - refCountObservable 반환
 */

let disposeBag = DisposeBag()
let sb = PublishSubject<Int>()

let source = Observable<Int>
    .interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .share()

let ob1 = source
    .subscribe{ print("💙", $0) }

let ob2 = source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("💚", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    ob1.dispose()
    ob2.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let ob3 = source.subscribe { print("❤️", $0)}

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        ob3.dispose()
    }
}

/*
 2024-05-24 00:15:58.652: share.playground:9 (__lldb_expr_65) -> subscribed
 2024-05-24 00:15:59.665: share.playground:9 (__lldb_expr_65) -> Event next(0)
 💙 next(0)
 2024-05-24 00:16:00.663: share.playground:9 (__lldb_expr_65) -> Event next(1)
 💙 next(1)
 2024-05-24 00:16:01.662: share.playground:9 (__lldb_expr_65) -> Event next(2)
 💙 next(2)
 2024-05-24 00:16:02.662: share.playground:9 (__lldb_expr_65) -> Event next(3)
 💙 next(3)
 💚 next(3)
 2024-05-24 00:16:03.662: share.playground:9 (__lldb_expr_65) -> Event next(4)
 💙 next(4)
 💚 next(4)
 2024-05-24 00:16:03.933: share.playground:9 (__lldb_expr_65) -> isDisposed
 2024-05-24 00:16:06.030: share.playground:9 (__lldb_expr_65) -> subscribed
 2024-05-24 00:16:07.032: share.playground:9 (__lldb_expr_65) -> Event next(0)
 ❤️ next(0)
 2024-05-24 00:16:08.031: share.playground:9 (__lldb_expr_65) -> Event next(1)
 ❤️ next(1)
 2024-05-24 00:16:09.032: share.playground:9 (__lldb_expr_65) -> Event next(2)
 ❤️ next(2)
 2024-05-24 00:16:09.180: share.playground:9 (__lldb_expr_65) -> isDisposed
 */
