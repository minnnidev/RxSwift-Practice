import UIKit
import RxSwift

/*
 <delay>
 next 이벤트가 전달되는 시점을 delay
 에러 이벤트는 지연 없이 즉시 전달

 구독 시점을 지연시키고 싶다면 delaySubscription 사용 가능
 */

let disposeBag = DisposeBag()

func currentTimeString() -> String {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f.string(from: Date())
}

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delay(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: disposeBag)

/*
 방출한 next 이벤트는 5초 뒤 구독자에게 전달됨
 2024-05-03 01:48:57.323: delay.playground:24 (__lldb_expr_404) -> subscribed
 2024-05-03 01:48:58.330: delay.playground:24 (__lldb_expr_404) -> Event next(0)
 2024-05-03 01:48:59.327: delay.playground:24 (__lldb_expr_404) -> Event next(1)
 2024-05-03 01:49:00.327: delay.playground:24 (__lldb_expr_404) -> Event next(2)
 2024-05-03 01:49:01.327: delay.playground:24 (__lldb_expr_404) -> Event next(3)
 2024-05-03 01:49:02.326: delay.playground:24 (__lldb_expr_404) -> Event next(4)
 2024-05-03 01:49:03.327: delay.playground:24 (__lldb_expr_404) -> Event next(5)
 2024-05-03 01:49:03.335 next(0)
 2024-05-03 01:49:04.327: delay.playground:24 (__lldb_expr_404) -> Event next(6)
 2024-05-03 01:49:04.341 next(1)
 2024-05-03 01:49:05.327: delay.playground:24 (__lldb_expr_404) -> Event next(7)
 2024-05-03 01:49:05.345 next(2)
 2024-05-03 01:49:06.327: delay.playground:24 (__lldb_expr_404) -> Event next(8)
 2024-05-03 01:49:06.347 next(3)
 2024-05-03 01:49:07.327: delay.playground:24 (__lldb_expr_404) -> Event next(9)
 2024-05-03 01:49:07.327: delay.playground:24 (__lldb_expr_404) -> Event completed
 2024-05-03 01:49:07.327: delay.playground:24 (__lldb_expr_404) -> isDisposed
 2024-05-03 01:49:07.350 next(4)
 2024-05-03 01:49:08.353 next(5)
 2024-05-03 01:49:09.355 next(6)
 2024-05-03 01:49:10.358 next(7)
 2024-05-03 01:49:11.362 next(8)
 2024-05-03 01:49:12.365 next(9)
 2024-05-03 01:49:12.366 completed
 */

