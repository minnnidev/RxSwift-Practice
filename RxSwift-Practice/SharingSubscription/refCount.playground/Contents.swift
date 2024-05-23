import UIKit
import RxSwift

/*
 refCount

 refCount 옵저버블은 내부에 ConnectableObservable을 유지하고,
 새로운 구독자가 추가될 때 자동으로 connect 메소드 호출
 더이상 필요하지 않다면 시퀀스 중지
 */

let disposeBag = DisposeBag()

let source = Observable<Int>
    .interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .publish()
    .refCount()

let ob1 = source
    .subscribe { print("💙", $0) }

//source.connect()

// 3초 후 구독 중지
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    ob1.dispose()
}

// 7초 후 구독 중지
DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let ob2 = source.subscribe { print("💚", $0) }

    // 3초 후 (총 10초 후) 구독 중지
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        ob2.dispose()
    }
}

/*
 2024-05-24 00:08:03.813: refCount.playground:16 (__lldb_expr_61) -> subscribed
 2024-05-24 00:08:04.835: refCount.playground:16 (__lldb_expr_61) -> Event next(0)
 💙 next(0)
 2024-05-24 00:08:05.832: refCount.playground:16 (__lldb_expr_61) -> Event next(1)
 💙 next(1)
 2024-05-24 00:08:06.832: refCount.playground:16 (__lldb_expr_61) -> Event next(2)
 💙 next(2)
 2024-05-24 00:08:06.999: refCount.playground:16 (__lldb_expr_61) -> isDisposed
 2024-05-24 00:08:11.199: refCount.playground:16 (__lldb_expr_61) -> subscribed
 2024-05-24 00:08:12.201: refCount.playground:16 (__lldb_expr_61) -> Event next(0)
 💚 next(0)
 2024-05-24 00:08:13.201: refCount.playground:16 (__lldb_expr_61) -> Event next(1)
 💚 next(1)
 2024-05-24 00:08:14.201: refCount.playground:16 (__lldb_expr_61) -> Event next(2)
 💚 next(2)
 2024-05-24 00:08:14.352: refCount.playground:16 (__lldb_expr_61) -> isDisposed
 */
