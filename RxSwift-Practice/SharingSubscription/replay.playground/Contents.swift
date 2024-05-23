import UIKit
import RxSwift

/*
 replay
 Connectable Observable에 버퍼를 추가하고 새로운 구독자에게 최근 이벤트를 전달
 */

let disposeBag = DisposeBag()
//let sb = ReplaySubject<Int>.create(bufferSize: 5)

let source = Observable<Int>
    .interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
//    .multicast(sb)
    .replay(5)

source
    .subscribe { print("💙", $0) }
    .disposed(by: disposeBag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("💚", $0) }
    .disposed(by: disposeBag)

source.connect() // connect() 를 하지 않으면 아무 일이 일어나지 않음!!

/*
 💙 next(0)
 💙 next(1)
 💚 next(0)
 💚 next(1)
 💙 next(2)
 💚 next(2)
 💙 next(3)
 💚 next(3)
 💙 next(4)
 💚 next(4)
 💙 completed
 💚 completed
 */
